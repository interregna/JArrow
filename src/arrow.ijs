9!:5 (1) NB. Enable nameref caching.
init ''

removeObject=: -.@ret@g_object_unref@<

NB. =========================================================
NB. Array
NB. =========================================================
readArrayType=: {{
'arrayPt'=. y
arrayTypePtr=. ptr garrow_array_get_value_data_type < arrayPt
namePtr=. ret garrow_data_type_get_name < arrayTypePtr
res=. getString namePtr
g_free << namePtr
removeObject arrayTypePtr
res
}}

readArrayTypeIndex=: {{
'arrayPt'=. y
arrayTypePtr=. ptr garrow_array_get_value_data_type < arrayPt
res=. ret garrow_data_type_get_id < arrayTypePtr
removeObject arrayTypePtr
res
}}

readArrayBitWidth=: {{
'arrayPt'=. y
dataWidthPtr=. ptr garrow_array_get_value_data_type < arrayPt
res=. ret garrow_fixed_width_data_type_get_bit_width < dataWidthPtr
removeObject dataWidthPtr
res
}}

readArrayLength=: {{ret garrow_array_get_length < y}}

readArrayRows=: {{
NB. Use this only for reading parts of arrays.
'arrayPt rowIndices'=. y
indexType=. readArrayTypeIndex arrayPt
arrayType=. readArrayType arrayPt
length=. readArrayLength arrayPt
getValueFunc=. typeGetValue&typeIndexLookup indexType NB. lookup functions
fRun=. getValueFunc,', arrayPt;<'
('Max row index must be  less than row count of ',": length) assert (>./ rowIndices) <: length
results=. ; ret@". each (fRun&,)@": each <"0 (rowIndices)
NB. width =. readArrayBitWidth arrayPt
NB. lengthPt =. setInts length
NB. getValuesFunc =. typeGetValues&typeIndexLookup indexType NB. lookup functions
NB. arrayValuesPt =.  ptr ". getValuesFunc,', (arrayPt);<lengthPt'
NB. Jtype =.  ". typeJMemr&typeIndexLookup indexType
NB. results =. memr (ret arrayValuesPt),0,length,Jtype
NB. memf > lengthPt
results
}}

readArray=: {{
NB. Read the whole array at once instead of one call for each.
'arrayPt'=. y
indexType=. readArrayTypeIndex arrayPt
arrayType=. readArrayType arrayPt
fRun=. typeGetValues&typeIndexLookup indexType NB. lookup functions
Jtype=. ". typeJMemr&typeIndexLookup indexType
lengthPtr=. setInts ] length=. readArrayLength arrayPt
if. indexType e. (0,4,5,6,7,11,13,16,19,29) do.  NB. Shims for getValues return values directly instead of pointers.
  result=. > (fRun)~ arrayPt;<lengthPtr
else.
  resPtr=. ptr (fRun)~ arrayPt;<lengthPtr
  result=. memr (>resPtr),0,length,Jtype
  if. indexType = 1 do. g_free < resPtr end. NB. Boolean array values must be freed for some reason.
end.
memf > lengthPtr
nullCount=. ret garrow_array_get_n_nulls < arrayPt
NB.   if. (* nullCount) do. <arrayPt
NB.    nullBufferPtr =. ptr garrow_array_get_null_bitmap <arrayPt
NB.    echo 'null buffer ptr'; nullCount; nullBufferPtr;(>. length % 8)
NB.    echo nullBitMap =. _8 ic memr (> ptr getBuffer nullBufferPtr),0,(>. length),2
NB.   end.
result
}}"0

readSubArray=: {{
NB. Use this only for reading parts of arrays.
NB. Currently iterates through everything...
'arrayPt'=. y
indexType=. readArrayTypeIndex arrayPt
arrayType=. readArrayType arrayPt
length=. readArrayLength arrayPt
getValueFunc=. typeGetValue&typeIndexLookup indexType NB. lookup functions
fRun=. getValueFunc,', arrayPt;<'
results=. ; ret@". each (fRun&,)@": each <"0 i.length
NB. width =. readArrayBitWidth arrayPt
NB. lengthPt =. setInts length
NB. getValuesFunc =. typeGetValues&typeIndexLookup indexType NB. lookup functions
NB. arrayValuesPt =.  ptr ". getValuesFunc,', (arrayPt);<lengthPt'
NB. Jtype =.  ". typeJMemr&typeIndexLookup indexType
NB. results =. memr (ret arrayValuesPt),0,length,Jtype
NB. memf > lengthPt
results
}}


NB. =========================================================
NB. chunkedArray
NB. =========================================================
readChunk=: {{
'chunkedArrayPt index'=. y
ptr@garrow_chunked_array_get_chunk chunkedArrayPt;index
}}

readChunks=: {{
'chunkedArrayPt'=. y
nChunks=. ret@garrow_chunked_array_get_n_chunks < chunkedArrayPt
arrayPts=. readChunk each <"1 (<chunkedArrayPt),.(<"0 i. nChunks)
res=. < ; readArray each arrayPts
removeObject each arrayPts
res
}}"0

readChunkedArray=: {{
'chunkedArrayPt'=. y
NB. length =. > ptr@garrow_chunked_array_get_length < chunkedArrayPt
NB. valuetype =. > ptr@garrow_chunked_array_get_value_type < chunkedArrayPt
NB. nrows  =. > ptr@garrow_chunked_array_get_n_rows < chunkedArrayPt
NB. nnulls =. > ptr@garrow_chunked_array_get_n_nulls < chunkedArrayPt
NB. valuedatatype =. ptr@garrow_chunked_array_get_value_data_type < chunkedArrayPt
NB. length;nrows;nnulls;valuetype;<valuedatatype
readChunks chunkedArrayPt
}}"0

NB. =========================================================
NB. Field
NB. =========================================================
newField=: {{
'name dataType nullableBoolean'=. 3 {. y
typeArgs=. 3 }. y
namePtr=. setString name
dtFn=. typeNew&typeNameLookup dataType
datatypePtr=. ptr (dtFn)~ ''
fieldPtr=. ptr garrow_field_new_full namePtr;datatypePtr;nullableBoolean
fieldPtr
}}

getFieldName=: {{
'fieldPt'=. y
fieldNamePtr=. ptr garrow_field_get_name < fieldPt
res=. getString fieldNamePtr
res
}}

getFieldDataType=: {{
'fieldPt'=. y
dataTypePtr=. ptr garrow_field_get_data_type < fieldPt
namePtr=. ret garrow_data_type_get_name < dataTypePtr
res=. getString namePtr
g_free << namePtr
removeObject dataTypePtr
res
}}

NB. =========================================================
NB. Schema
NB. =========================================================
getSchemaPt=: {{
tablePt=. y
ptr garrow_table_get_schema < tablePt
}}

getSchemaFieldPt=: {{
'schemaPt index'=. y
ptr garrow_schema_get_field schemaPt;index
}}

getSchemaName=: {{
'schemaPt index'=. y
fieldPts=. getSchemaFieldPt (<schemaPt),< index
name=. getFieldName fieldPts
removeObject fieldPts
name
}}

getSchemaNames=: {{
schemaPt=. y
nFields=. ret garrow_schema_n_fields < schemaPt
names=. getSchemaName each <"1 (<schemaPt),.<"0 i. nFields
names
}}

getSchemaFields=: {{
schemaPt=. y
nFields=. ret garrow_schema_n_fields < schemaPt
fieldPts=. getSchemaFieldPt each <"1 (<schemaPt),.<"0 i. nFields
types=. getFieldDataType each fieldPts
names=. getFieldName each fieldPts
res=. names,:types
NB. removeObject each fieldPts NB. returns g_object_unref: assertion 'G_IS_OBJECT (object)' failed
res
}}

printBasicSchema=: {{
tablePt=. y
schemaPt=. getSchemaPt tablePt
res=. getString ret ptr garrow_schema_to_string < schemaPt
removeObject schemaPt
res
}}

printTableSchema=: (,.~(,.&' ')@(":@,.@:i.@#))@:>@:(LF&cut)@printBasicSchema

readTableNames=: {{
tablePt=. y
schemaPt=. getSchemaPt tablePt
res=. getSchemaNames schemaPt
removeObject schemaPt
res
}}

readTableSchema=: {{
tablePt=. y
schemaPt=. getSchemaPt tablePt
res=. getSchemaFields schemaPt
removeObject schemaPt
res
}}

readTableColName=: {{
'tablePt index'=. y
schemaPt=. getSchemaPt tablePt
res=. getSchemaName schemaPt;<index
removeObject schemaPt
res
}}


NB. =========================================================
NB. Table
NB. =========================================================
tableNRows=: {{ret garrow_table_get_n_rows (< y)}}
tableNCols=: {{ret garrow_table_get_n_columns (< y)}}

readData=: {{
'tablePt'=. y
ncols=. tableNCols tablePt
chunkedArrayPts=. ptr"1 garrow_table_get_column_data tablePt ;"0 i. ncols
res=. ,. readChunks chunkedArrayPts
removeObject"0 chunkedArrayPts
res
}}

readsData=: ,@((,.&.>)@:readData)

readDataInverted=: ,@:(,each)@readData

readDataCol=: {{
'tablePt colIndex'=. y
ncols=. tableNCols tablePt
'Index is greater than number of columns. Note columns are zero-indexed.' assert colIndex < ncols
chunkedArrayPts=. <"0 ptr"1 garrow_table_get_column_data (< tablePt), < colIndex
results=. ,. ; each readChunks each chunkedArrayPts
removeObject each chunkedArrayPts
results
}}

readCol=: {{
'tablePt colIndex'=. y
((<@readTableColName),.readDataCol) (< tablePt),< colIndex
}}

readTable=: {{
'tablePt'=. y
(readTableNames ,. ,@readData) tablePt
}}

readsTable=: {{
'tablePt'=. y
(,@readTableNames ,: readsData) tablePt
}}

readDataframe=: {{
'tablePt'=. y
((,@readTableNames),: ,@readData) tablePt
}}

NB. =========================================================
NB. Format readers
NB. =========================================================
readFileSchema=: {{ readTableSchema@u ] filepath=. y }}
printFileSchema=: {{ printSchema@u ] filepath=. y }}
readFileData=: {{ readData@u ] filepath=. y }}
readFileTable=: {{ readTable@u ] filepath=. y }}
readsFileTable=: {{ readsTable@u ] filepath=. y }}
readFileDataframe=: {{ readDataframe@u ] filepath=. y }}
readFileCol=: {{
'filepath index'=. y
readCol (u filepath);<index
}}


NB. =========================================================
NB. CSV format
NB. Add CSV options. Is it necessary to close reader?
NB. =========================================================
readCSV=: {{
'filepath'=. y
'File does not exist or is not permissioned for read.' assert fexist (jpath filepath)
filenamePtr=. setString (jpath filepath)
e=. < mema 4
fInputStreamPtr=. ptr garrow_file_input_stream_new filenamePtr;<e
'Check file exists and permissions.' assert * > fInputStreamPtr
NB. Example adding column names:
readOptionPtr=. ptr garrow_csv_read_options_new ''
NB. '"/usr/local/lib/libarrow-glib.dylib" garrow_csv_read_options_add_column_name n * *'&cd (< ptr rdOptPt ),(<< setString 'col1')
NB. ptr i32 =. '"/usr/local/lib/libarrow-glib.dylib" garrow_int32_data_type_get_type *'&cd ''
NB. '"/usr/local/lib/libarrow-glib.dylib" garrow_csv_read_options_add_column_type n * * *'&cd (< ptr rdOptPt ),(< setString 'col1');(< ptr i32)
csvReaderPtr=. ptr garrow_csv_reader_new (fInputStreamPtr);(readOptionPtr);<e
tablePtr=. ptr garrow_csv_reader_read csvReaderPtr;<e
removeObject"0 csvReaderPtr,readOptionPtr,fInputStreamPtr
memf"0 > (filenamePtr),e
tablePtr
}}

readCSVSchema=: (readCSV readFileSchema)
printCSVSchema=: (readCSV printFileSchema)
readCSVData=: (readCSV readFileData)
readCSVTable=: (readCSV readFileTable)
readsCSVTable=: (readCSV readsFileTable)
readCSVDataframe=: (readCSV readFileDataframe)
readCSVCol=: (readCSV readFileCol)


NB. =========================================================
NB. JSON lines format
NB. =========================================================
readJson=: {{
'filepath'=. y
'File does not exist or is not permissioned for read.' assert fexist (jpath filepath)
filenamePtr=. setString (jpath filepath)
e=. < mema 4
fInputStreamPtr=. ptr garrow_file_input_stream_new filenamePtr;<e
'Check file exists and available will permissions.' assert * > ptr fInputStreamPtr
readOptionPtr=. ptr garrow_json_read_options_new ''
jsonReaderPtr=. ptr garrow_json_reader_new fInputStreamPtr;readOptionPtr;<e
tablePtr=. ptr garrow_json_reader_read jsonReaderPtr;<e
'Invalid JSON-format.' assert > tablePtr
removeObject"0 readOptionPtr, fInputStreamPtr jsonReaderPtr
memf"0 > (filenamePtr),e
tablePtr
}}

readJsonSchema=: (readJson readFileSchema)
printJsonSchema=: (readJson printFileSchema)
readJsonData=: (readJson readFileData)
readJsonTable=: (readJson readFileTable)
readsJsonTable=: (readJson readsFileTable)
readJsonDataframe=: (readJson readFileDataframe)
readJsonCol=: (readJson readFileCol)


NB. =========================================================
NB. Parquet format
NB. =========================================================
readParquet=: {{
'filepath'=. y
'File does not exist or is not permissioned for read.' assert fexist (jpath filepath)
e=. < mema 4
readerPathPtr=. ptr gparquet_arrow_file_reader_new_path (jpath filepath);<e
tablePtr=. ptr gparquet_arrow_file_reader_read_table readerPathPtr;<e
removeObject readerPathPtr
memf > e
tablePtr
}}

readParquetSchema=: (readParquet readFileSchema)
printParquetSchema=: (readParquet printFileSchema)
readParquetData=: (readParquet readFileData)
readParquetTable=: (readParquet readFileTable)
readsParquetTable=: (readParquet readsFileTable)
readParquetDataframe=: (readParquet readFileDataframe)
readParquetCol=: (readParquet readFileCol)

NB. writeParquet tablePointer;'~out1.parquet'
NB. Add write options
writeParquet=: {{
'tablePtr filepath'=. y
e=. < mema 4
pqtWtrPtr=. ptr gparquet_writer_properties_new ''
schemaPtr=. ptr getSchemaPt tablePtr
filenamePtr=. setString filepath
pqtFileWriterPtr=. ptr gparquet_arrow_file_writer_new_path schemaPtr;filenamePtr;pqtWtrPtr;<e
chunksize=. 5000
success=. ret gparquet_arrow_file_writer_write_table pqtFileWriterPtr;tablePtr;chunksize;<e
gparquet_arrow_file_writer_close pqtFileWriterPtr;<e
removeObject"0 pqtWtrPtr, schemaPtr, pqtFileWriterPtr
memf"0 > (filenamePtr),e
success
}}


NB. =========================================================
NB. Feather format ('Version 1')
NB. =========================================================
readFeather=: {{
NB. Properties
NB. gint	max-recursion-depth	Read / Write
NB. gboolean	use-threads	Read / Write
NB. gint	alignment	Read / Write
NB. gboolean	allow-64bit	Read / Write
NB. GArrowCodec *	codec	Read / Write
NB. gint	max-recursion-depth	Read / Write
NB. gboolean	use-threads	Read / Write
NB. gboolean	write-legacy-ipc-format	Read / Write
'filepath'=. y
'File does not exist or is not permissioned for read.' assert fexist (jpath filepath)
filenamePtr=. setString (jpath filepath)
e=. < mema 4
fInputStreamPtr=. ptr garrow_file_input_stream_new filenamePtr;<e
'Check file exists and available will permissions.' assert * > ptr fInputStreamPtr
arrowReaderPtr=. ptr garrow_feather_file_reader_new fInputStreamPtr;<e
'Null pointer error' assert > arrowReaderPtr
tablePtr=. ptr garrow_feather_file_reader_read arrowReaderPtr;<e
removeObject"0 fInputStreamPtr,arrowReaderPtr
memf"0 > (filenamePtr),e
tablePtr
}}

readFeatherSchema=: (readFeather readFileSchema)
printFeatherSchema=: (readFeather printFileSchema)
readFeatherData=: (readFeather readFileData)
readFeatherTable=: (readFeather readFileTable)
readsFeatherTable=: (readFeather readsFileTable)
readFeatherDataframe=: (readFeather readFileDataframe)
readFeatherCol=: (readFeather readFileCol)






NB. =========================================================
NB. Reading and writing IPC
NB. =========================================================

NB. Tables are columnar store in 'arrays', each of which is a column.
NB.   Tables are are not a common format and are not serializable.
NB.   Arrays can be batched into chunked arrawys, which may vary in length between columns.
NB. IPC format files and streaming data are stored in rows.
NB.   Batches of rows are called 'recordBatches', suitable for storing and streaming.
NB.   IPC is a common format and is serializable.
NB.   '.arrow' and '.feather' files are IPC format files with headers and footers, suitable for random access.
NB.   '.arrows' files are streaming IPC format without footers.

NB. https://arrow.apache.org/docs/cpp/tables.html#record-batches
NB. Table: Logical table as sequence of chunked arrays.
NB. RecordBatch: Collection of equal-length arrays matching a particular Schema.
NB. A record batch is table-like data structure that is semantically a sequence of fields, each a contiguous Arrow array

NB. ".arrow"  We recommend the “.arrow” extension for files created with this format. Note that files created with this format are sometimes called “Feather V2” or with the “.feather” extension, the name and the extension derived from “Feather (V1)”, which was a proof of concept early in the Arrow project for language-agnostic fast data frame storage for Python (pandas) and R.
NB. ".arrows" We recommend the “.arrows” file extension for the streaming format although in many cases these streams will not ever be stored as files.
NB. https://arrow.apache.org/docs/format/Columnar.html

NB. IPC Format
NB. The columnar IPC protocol utilizes a one-way stream of binary messages of these types:
NB. 1) Schema 2) RecordBatch 3) DictionaryBatch
NB. The message encapsulation format in flatbuffers
NB. https://arrow.apache.org/docs/format/Columnar.html#encapsulated-message-format


NB. Tbere are two concepts of streams in Arrow; the term is overloaded and this is a a source of confusion.
NB. 1) Input and output streams, which reference interfaces to data stores.
NB. 2) The writers for IPC-format files without footers, suitable for streaming.
NB. The difference between RecordBatchFileReader and RecordBatchStreaader
NB. is that the input source must have a seek method for random access.

NB. Event-driven API
NB. https://arrow.apache.org/docs/cpp/api/ipc.html#event-driven-api
NB. listener StreamDecoder


NB. =========================================================

newList=. {{
items=. y
listPtr=. <0
for_item. items do.
  listPtr=. ptr g_list_append listPtr;<item
end.
listPtr
}}

setBytes=. {{
byteCount=. # y
NB. bytePtr =. mema  byteCount
bytePtr=. > ptr g_malloc <byteCount
y memw bytePtr,0,byteCount,2
NB. gBtyesPtr =. ptr g_bytes_new_static (<bytePtr);byteCount
gBtyesPtr=. ptr g_bytes_new_take (<bytePtr);byteCount
gBtyesPtr
}}

newResizableBuffer=: {{
e=. < mema 4
res=. ptr garrow_resizable_buffer_new 1;<e
memf > e
res
}}

newSchema=: {{
NB. 'name dataType nullableBoolean'
fields=. y
fieldPtrs=. newField"1 fields
listPtr=. newList fieldPtrs
schemaPtr=. ptr garrow_schema_new <listPtr
schemaPtr
}}

makeReadOptions=: {{
readoptions=. y
readOptionsPtr=. garrow
NB. "max-recursion-depth"	gint
NB. "use-threads"	gboolean
readOptionsPtr=. ptr garrow_read_options_new ''
NB. setProperties
readOptionsPtr
}}

makeWriteOptions=: {{
readoptions=. y
NB. "use-threads"	gboolean
NB. "alignment"	gint
NB. "allow-64bit" 	gboolean
NB. "codec"		GArrowCodec *
NB. "max-recursion-depth"	gint
NB. "use-threads"	gboolean
NB. "write-legacy-ipc-format"	gboolean
writeOptionsPtr=. ptr garrow_write_options_new ''
NB. setProperties
writeOptionsPtr
}}


NB. =========================================================
NB. Input streams
NB. =========================================================

fileInputStream=. {{
filepath=. y
'File does not exist.' assert jpath filepath
filePtr=. setString jpath filepath
e=. < mema 4
inputStreamPtr=. ptr garrow_file_input_stream_new filePtr;<e
garrow_input_stream_align inputStreamPtr;64;<e
memf > e
inputStreamPtr
}}

bufferInputStream=. {{
gBtyesPtr=. y
bufferPtr=. ptr garrow_buffer_new_bytes <gBtyesPtr
bufferInputStreamPtr=. ptr garrow_buffer_input_stream_new <bufferPtr
e=. < mema 4
garrow_input_stream_align bufferInputStreamPtr;64;<e
memf > e
bufferInputStreamPtr
}}

memmoryMappedFileInputStream=. {{
filepath=. y
'File does not exist.' assert jpath filepath
filePtr=. setString jpath filepath
e=. < mema 4
inputStreamPtr=. ptr garrow_memory_mapped_input_stream_new filePtr;<e
garrow_input_stream_align inputStreamPtr;64;<e
memf > e
inputStreamPtr
}}

gioInputStream=. {{
inputStream=. y
inputStreamPtr=. ptr garrow_gio_input_stream_new inputStream
e=. < mema 4
garrow_input_stream_align inputStreamPtr;64;<e
memf > e
inputStreamPtr
}}

codec=. {{
compressionTypes=. 'UNCOMPRESSED SNAPPY GZIP BROTLI ZSTD LZ4 LZO BZ2'
NB. UNCOMPRESSED Not compressed.
NB. SNAPPY Snappy compression.
NB. GZIP gzip compression.
NB. BROTLI Brotli compression.
NB. ZSTD Zstandard compression.
NB. LZ4 LZ4 compression.
NB. LZO LZO compression.
NB. BZ2 bzip2 compression.
compression=. y
compressionEnum=. {. (< tolower compression) I.@E. ;: tolower compressionTypes
e=. < mema 4
codecPtr=. ptr garrow_codec_new compressionEnum;<e
if. -. * > codecPtr do.
  echo 'Invalid compression type. Valid compression types are: ', > ;: 'UNCOMPRESSED SNAPPY GZIP BROTLI ZSTD LZ4 LZO BZ2'
  codecPtr=. <0
else.
NB. echo ret garrow_codec_get_compression_type  < codecPtr
NB. codecNamePtr =. ptr garrow_codec_get_name < codecPtr
end.
memf > e
codecPtr
}}

compressedInputStream=. {{
'codecName inputStreamPtr'=. y
codePtr=. codec codecName
e=. < mema 4
inputStreamPtr=. ptr garrow_compressed_input_stream_new codecPtr;inputStreamPtr;<e
garrow_input_stream_align inputStreamPtr;64;<e
memf > e
inputStreamPtr
}}



NB. =========================================================
NB. Output streams
NB. =========================================================


fileOutpuStream=: {{
'filepath appendboolean'=. y
'File does not exist.' assert jpath filepath
fnPtr=. setString jpath filepath
e=. < mema 4
fileOutpuStreamPtr=. ptr garrow_file_output_stream_new fnPtr;appendboolean;<e
memf > e
fileOutpuStreamPtr
}}

bufferOutpuStream=: {{
ptr garrow_buffer_output_stream_new < newResizableBuffer''
}}

newCompressedOutpuStream=: {{
'codecPtr outputStreamPtr'=. y
e=. < mema 4
compressedOutpuStreamPtr=. ptr garrow_compressed_output_stream_new codecPtr;outputStreamPtr;<e
memf > e
compressedOutpuStreamPtr
}}

recordBatchStreamWriter=: {{
'outputStreamPtr schemaPtr'=. y
e=. < mema 4
recordBatchStreamWriterPtr=. ptr garrow_record_batch_stream_writer_new outputStreamPtr;schemaPtr;<e
memf > e
recordBatchStreamWriterPtr
}}

NB. =========================================================
NB. IPC WRITER CLASSES
NB. =========================================================

writeRecordBatchStream=. {{
NB. IPC stream format is  optionally footer-terminated and
NB. it does not contain ARROW1 magic numbers at beginning and end.
'filepath appendboolean recordBatchPtrs'=. y
'File does not exist.' assert jpath filepath
fileOutputStreamPtr=. fileOutpuStream filepath;appendboolean
e=. < mema 4
ret garrow_output_stream_align fileOutputStreamPtr;64;<e
writeOptionsPtr=. makeWriteOptions ''
schemaPtr=. ptr garrow_record_batch_get_schema < {. recordBatchPtrs
recordBatchStreamWriterPtr=. ptr garrow_record_batch_stream_writer_new fileOutputStreamPtr;schemaPtr;<e
for_recordBatchPtr. recordBatchPtrs do.
  garrow_record_batch_writer_write_record_batch recordBatchStreamWriterPtr;recordBatchPtr;<e
end.
memf > e
1
}}

recordBatchFileWriter=: {{
'outputStreamPtr schemaPtr'=. y
e=. < mema 4
recordbatchFilestreamWriterPtr=. ptr garrow_record_batch_file_writer_new outputStreamPtr;schemaPtr;<e
memf > e
recordbatchFilestreamWriterPtr
}}


writeRecordBatchFile=. {{
'filepath appendboolean recordBatchPtrs'=. y
'File does not exist.' assert jpath filepath
NB. The IPC file format is footer-terminated and does contain ARROW1 magic numbers at beginning and end.
fileOutputStreamPtr=. fileOutpuStream filepath;appendboolean
e=. < mema 4
ret garrow_output_stream_align fileOutputStreamPtr;64;<e
writeOptionsPtr=. (makeWriteOptions '')
schemaPtr=. ptr garrow_record_batch_get_schema < {. recordBatchPtrs
recordbatchFilestreamWriterPtr=. recordBatchFileWriter fileOutputStreamPtr;<schemaPtr
for_recordBatchPtr. recordBatchPtrs do.
  garrow_record_batch_writer_write_record_batch recordbatchFilestreamWriterPtr;recordBatchPtr;<e
end.
success=. ret garrow_record_batch_writer_close recordbatchFilestreamWriterPtr;< e
memf > e
success
}}

writeTableFile=: {{
'filepath appendboolean tablePtr'=. y
'File does not exist.' assert jpath filepath
schemaPtr=. getSchemaPt tablePtr
recordBatchFileWriterPtr=. recordBatchFileWriter (fileOutpuStream filepath;appendboolean);<schemaPtr
e=. < mema 4
success1=. ret garrow_record_batch_writer_write_table recordBatchFileWriterPtr;tablePtr;<e
success2=. ret garrow_record_batch_writer_close recordBatchFileWriterPtr;<e
memf > e
>./ success1, success2
}}

writeTensorFile=. {{
'filepath appendboolean tensorPtr'=. y
'File does not exist.' assert jpath filepath
fileOutputStreamPtr=. fileOutpuStream filepath;appendboolean
e=. < mema 4
res=. ret garrow_output_stream_write_tensor outputStreamPtr;tensorPtr;<e
memf > e
res
}}


NB. =========================================================
NB. IPC READER CLASSES
NB. =========================================================


recordBatchFileReader=. {{
filepath=. y
'File does not exist.' assert jpath filepath
fileInputStreamPtr=. fileInputStream filepath
e=. < mema 4
ret garrow_input_stream_align fileInputStreamPtr;64;<e
NB. echo '[+] Size: ', ": ret garrow_seekable_input_stream_get_size fileInputStreamPtr;<e
rbreaderPtr=. ptr garrow_record_batch_file_reader_new fileInputStreamPtr;<e
'Not a valid recordbatchReader.' assert * > rbreaderPtr
NB. schemaPtr =. ptr garrow_record_batch_file_reader_get_schema <rbreaderPtr
recordBatchCount=. ret garrow_record_batch_file_reader_get_n_record_batches <rbreaderPtr
NB. echo '[+] Recordbatch count: ', ":ret garrow_record_batch_file_reader_get_n_record_batches <rbreaderPtr
NB. ptr garrow_input_stream_read_record_batch fileInputStreamPtr;schemaPtr;makeReadOptions'');<e
recordBatchPtr=. (ptr@garrow_record_batch_file_reader_read_record_batch)"1 rbreaderPtr ;"0 1 (i. recordBatchCount);"0 0<e
('Not a valid recordbatch.'&assert)@* each recordBatchPtr
memf > e
recordBatchPtr
}}

fileInputStreamTable=: {{
NB. read input stream directly from file.
filepath=. y
'File does not exist.' assert jpath filepath
inputStreamPtr=. fileInputStream filepath
e=. < mema 4
streamReaderPtr=. ptr garrow_record_batch_stream_reader_new inputStreamPtr;<e
tablePtr=. ptr garrow_record_batch_reader_read_all streamReaderPtr;<e
memf > e
removeObject inputStreamPtr
removeObject streamReaderPtr
tablePtr
}}

recordBatchTable=: {{
recordBatches=. y
schemaPtr=. ptr garrow_record_batch_get_schema < {. recordBatches
recordBatchArrayPointer=. setInts > recordBatches
countRecordBatches=. # recordBatches
e=. < mema 4
tablePtr=. ptr garrow_table_new_record_batches schemaPtr;recordBatchArrayPointer;countRecordBatches;<e
memf > e
tablePtr
}}

byteInputStream=. {{
bytes=. y
byteCount=. # bytes
bytePtr=. > ptr g_malloc <byteCount
bytes memw bytePtr,0,byteCount,2
gBtyesPtr=. ptr g_bytes_new_take (<bytePtr);byteCount
bufferPtr=. ptr garrow_buffer_new_bytes <gBtyesPtr
g_bytes_unref < gBtyesPtr NB. Must use bytes unref, NOT object unref. Object unref will cause segfault.
bufferInputStreamPtr=. ptr garrow_buffer_input_stream_new <bufferPtr
'Not a vaild buffer input stream pointer.' assert * > bufferInputStreamPtr
removeObject bufferPtr
e=. < mema 4
ret garrow_input_stream_align bufferInputStreamPtr;64;<e
memf > e
bufferInputStreamPtr
}}

recordBatchStreamReaderTable=. {{
bufferInputStreamPtr=. y
'Not a vaild buffer input stream pointer.' assert * > bufferInputStreamPtr
e=. < mema 4
streamReaderPtr=. ptr garrow_record_batch_stream_reader_new bufferInputStreamPtr;<e
'Not a vaild stream reader pointer.' assert * > streamReaderPtr
tablePtr=. ptr garrow_record_batch_reader_read_all streamReaderPtr;<e
'Not a vaild table pointer.' assert * > tablePtr
memf > e
removeObject streamReaderPtr
tablePtr
}}

getRecordBatch=: {{
recordBatchPtr=. y
nCols=. ret garrow_record_batch_get_n_columns < recordBatchPtr
names=. > a:
arrays=. > a:
for_cn. i. nCols do.
  names=. names, < getString ptr garrow_record_batch_get_column_name recordBatchPtr;<cn
  arrayPtr=. ptr garrow_record_batch_get_column_data recordBatchPtr;<cn
  arrays=. arrays , < readArray arrayPtr
  removeObject arrayPtr
end.
NB. names
< ,. each arrays
}}

recordBatchStreamReader=: {{
NB. This will read recordbatchs out of a stream file.
filepath=. y
'File does not exist.' assert jpath filepath
inputStreamPtr=. fileInputStream filepath
NB. inputStreamPtr =. memmoryMappedFileInputStream filepath
'Not a vaild inputstream pointer.' assert * > inputStreamPtr
e=. < mema 4
ret garrow_input_stream_align inputStreamPtr;64;<e
NB. echo ret garrow_seekable_input_stream_get_size fileInputStreamPtr;<e
streamReaderPtr=. ptr garrow_record_batch_stream_reader_new inputStreamPtr;<e
'Not a valid streamReader.' assert * > streamReaderPtr
NB. schemaPtr =. ptr garrow_record_batch_reader_get_schema <streamReaderPtr
NB. readOptionsPtr =. makeReadOptions''
NB. 'Not a valid schema.' assert * > schemaPtr
NB. recordBatchPtr =. ptr garrow_input_stream_read_record_batch fileInputStreamPtr;schemaPtr;readOptionsPtr;<e
res=. > a:
recordBatchPtr=. [ptr garrow_record_batch_reader_read_next streamReaderPtr;<e
while. > recordBatchPtr do.
  res=. res, getRecordBatch recordBatchPtr
  removeObject recordBatchPtr
  recordBatchPtr=. [ptr garrow_record_batch_reader_read_next streamReaderPtr;<e
end.
removeObject inputStreamPtr
removeObject streamReaderPtr
memf > e
res
}}


NB. IPC format for saved files (.arrow file)
readArrowTable=. readIPCTable=. recordBatchTable@recordBatchFileReader
NB. IPC format for streaming, but from a file on disk (.arrows file)
readFileBufferTable=. readArrowsTable=. readIPCFileStreamTable=. fileInputStreamTable




