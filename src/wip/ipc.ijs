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