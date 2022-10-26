9!:5 (1) NB. Enable nameref caching.
init ''


NB. =========================================================
NB. Array
NB. =========================================================
readArrayType=: {{
'arrayPt'=. y
dataTypePt=. ptr garrow_array_get_value_data_type < arrayPt
getString (ret ptr garrow_data_type_get_name < dataTypePt)
}}

readArrayTypeIndex=: {{
'arrayPt'=. y
datatypePt=. ptr garrow_array_get_value_data_type < arrayPt
ret garrow_data_type_get_id < datatypePt
}}

readArrayBitWidth=: {{
'arrayPt'=. y
datatypePt=. ptr garrow_array_get_value_data_type < arrayPt
ret garrow_fixed_width_data_type_get_bit_width < datatypePt
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
if. indexType e. (0,4,5,6,7,11,13,16,19) do.  NB. Shims for getValues return values directly instead of pointers.
  result=. > (fRun)~ arrayPt;<lengthPtr
else.
  resPtr=. ptr (fRun)~ arrayPt;<lengthPtr
  result=. memr (>resPtr),0,length,Jtype
end.
nullCount=. ret garrow_array_get_n_nulls <arrayPt NB.
NB.   if. (* nullCount) do. <arrayPt
NB.    nullBufferPtr =. ptr garrow_array_get_null_bitmap <arrayPt
NB.    echo 'null buffer ptr'; nullCount; nullBufferPtr;(>. length % 8)
NB.    echo nullBitMap =. _8 ic memr (> ptr getBuffer nullBufferPtr),0,(>. length),2
NB.   end.
result
}}

readArray2=: {{
NB. Use this only for reading parts of arrays.
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
< ; readArray each arrayPts
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
getFieldName=: {{
'fieldPt'=. y
getString ptr garrow_field_get_name fieldPt
}}

getFieldDataType=: {{
'fieldPt'=. y
dataTypePt=. ptr garrow_field_get_data_type fieldPt
getString ret garrow_data_type_get_name < dataTypePt
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
name=. getFieldName < fieldPts
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
types=. getFieldDataType@< each fieldPts
names=. getFieldName@< each fieldPts
names,:types
}}

printSchema=: {{
tablePt=. y
schemaPt=. getSchemaPt tablePt
getString ret ptr garrow_schema_to_string < schemaPt
}}

neatPrintSchema=: (,.~(,.&' ')@(":@,.@:i.@#))@:>@:(LF&cut)@printSchema

readTableSchema=: {{
tablePt=. y
schemaPt=. getSchemaPt tablePt
getSchemaNames schemaPt
}}

readTableSchemaTypes=: {{
tablePt=. y
schemaPt=. getSchemaPt tablePt
getSchemaFields schemaPt
}}

readTableSchemaCol=: {{
'tablePt index'=. y
getSchemaName (getSchemaPt tablePt);<index
}}


NB. =========================================================
NB. Table
NB. =========================================================
tableNRows=: {{ret garrow_table_get_n_rows (< y)}}
tableNCols=: {{ret garrow_table_get_n_columns (< y)}}

readData=: {{
'tablePt'=. y
ncols=. tableNCols tablePt
chunkedArrayPts=. <"0 ptr"1 garrow_table_get_column_data tablePt ;"0 i. ncols
,. > readChunkedArray each chunkedArrayPts
}}

readDataInverted=: ,@:(,each)@readData

readDataCol=: {{
'tablePt colIndex'=. y
ncols=. tableNCols tablePt
'Index is greater than number of columns. Note columns are zero-indexed.' assert colIndex < ncols
chunkedArrayPts=. <"0 ptr"1 garrow_table_get_column_data (< tablePt), < colIndex
,. ; each readChunkedArray each chunkedArrayPts
}}

readCol=: {{
'tablePt colIndex'=. y
((<@readTableSchemaCol),.readDataCol) (< tablePt),< colIndex
}}

readTable=: {{
'tablePt'=. y
(readTableSchema ,. ,@readData) tablePt
}}

readsTable=: {{
'tablePt'=. y
(,@readTableSchema ,: ,@((,.&.>)@:readData)) tablePt
}}

readDataframe=: {{
'tablePt'=. y
((,@readTableSchema),: ,@readData) tablePt
}}

NB. =========================================================
NB. Format readers
NB. =========================================================
readFileSchema=: {{ readTableSchemaTypes@u ] filepath=. y }}
printFileSchema=: {{ neatPrintSchema@u ] filepath=. y }}
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
fInputStreamPtr=. garrow_file_input_stream_new filenamePtr;<e
'Check file exists and permissions.' assert * > ptr fInputStreamPtr
NB. Example adding column names:
readOptionPt=. garrow_csv_read_options_new ''
NB. '"/usr/local/lib/libarrow-glib.dylib" garrow_csv_read_options_add_column_name n * *'&cd (< ptr rdOptPt ),(<< setString 'col1')
NB. ptr i32 =. '"/usr/local/lib/libarrow-glib.dylib" garrow_int32_data_type_get_type *'&cd ''
NB. '"/usr/local/lib/libarrow-glib.dylib" garrow_csv_read_options_add_column_type n * * *'&cd (< ptr rdOptPt ),(< setString 'col1');(< ptr i32)
csvReaderPtr=. ptr garrow_csv_reader_new (ptr fInputStreamPtr);(ptr readOptionPt);<e
tablePtr=. ptr garrow_csv_reader_read csvReaderPtr;<e
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
readJsonl=: {{
'filepath'=. y
'File does not exist or is not permissioned for read.' assert fexist (jpath filepath)
filenamePtr=. setString (jpath filepath)
e=. < mema 4
fInputStreamPtr=. ptr garrow_file_input_stream_new filenamePtr;<e
'Check file exists and available will permissions.' assert * > ptr fInputStreamPtr
readOptionPt=. ptr garrow_json_read_options_new ''
csvReaderPtr=. ptr garrow_json_reader_new fInputStreamPtr;readOptionPt;<e
tablePtr=. ptr garrow_json_reader_read csvReaderPtr;<e
'Invalid JSON-format.' assert > tablePtr
tablePtr
}}

readJsonlSchema=: (readJsonl readFileSchema)
printJsonlSchema=: (readJsonl printFileSchema)
readJsonlData=: (readJsonl readFileData)
readJsonlTable=: (readJsonl readFileTable)
readsJsonlTable=: (readJsonl readsFileTable)
readJsonlDataframe=: (readJsonl readFileDataframe)
readJsonlCol=: (readJsonl readFileCol)


NB. =========================================================
NB. Parquet format
NB. =========================================================
readParquet=: {{
'filepath'=. y
'File does not exist or is not permissioned for read.' assert fexist (jpath filepath)
e1=. < mema 4
e2=. < mema 4
readerPathPtr=. ptr gparquet_arrow_file_reader_new_path (jpath filepath);<e1
tablePtr=. ptr gparquet_arrow_file_reader_read_table readerPathPtr;<e2
memf > e1
memf > e2
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
e1=. < mema 4
e2=. < mema 4
e3=. < mema 4
pqtWtrPtr=. ptr gparquet_writer_properties_new ''
schemaPtr=. ptr getSchemaPt tablePtr
fnPtr=. setString filepath
pqtFileWriterPtr=. ptr gparquet_arrow_file_writer_new_path schemaPtr;fnPtr;pqtWtrPtr;<e1
chunksize=. 5000
success=. ret gparquet_arrow_file_writer_write_table pqtFileWriterPtr;tablePtr;chunksize;<e2
gparquet_arrow_file_writer_close pqtFileWriterPtr;<e3
memf"0 > (fnPtr),e1,e2,e3
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
tablePtr
}}

readFeatherSchema=: (readFeather readFileSchema)
printFeatherSchema=: (readFeather printFileSchema)
readFeatherData=: (readFeather readFileData)
readFeatherTable=: (readFeather readFileTable)
readsFeatherTable=: (readFeather readsFileTable)
readFeatherDataframe=: (readFeather readFileDataframe)
readFeatherCol=: (readFeather readFileCol)
