NB. =========================================================
NB. Reading and writing IPC
NB. =========================================================

NB. recordbatch is rowise data
NB. table is columnar store schema + (chunked) arrays

NB. filesytem -> inputstream
NB. inputstream -> read
NB. recordbatch -> array/table
NB. <----->
NB. recordbatch
NB. outputstream
NB. filesystem

NB. IPC
NB. The columnar IPC protocol utilizes a one-way stream of binary messages of these types:
NB. Schema
NB. RecordBatch
NB. DictionaryBatch
NB. The message encapsulation format in flatbuffers (https://arrow.apache.org/docs/format/Columnar.html#encapsulated-message-format)


NB. https://arrow.apache.org/docs/cpp/tables.html#record-batches
NB. RecordBatch:
NB. Collection of equal-length arrays matching a particular Schema.
NB. A record batch is table-like data structure that is semantically a sequence of fields, each a contiguous Arrow array
NB. Table:
NB. Logical table as sequence of chunked arrays.


NB. https://arrow.apache.org/docs/cpp/examples/row_columnar_conversion.html
NB. convert between: array of structs <and> table

NB. These alternatives seem to inject the concept of 'writers', but conflict with the tensors vs tables.


NB. NONSERIALIZED: table, SERIALIZED: record batch
NB. The primitive unit of serialized data in the columnar format is the “record batch”. 
NB. Semantically, a record batch is an ordered collection of arrays, known as its fields, each having the same length as one another but potentially different data types. A record batch’s field names and types collectively form the batch’s schema.
NB. file <> stream       : file has a fixed length and terminating footer, stream does not 


NB. https://arrow.apache.org/docs/format/Columnar.html
NB. ".arrow"  We recommend the “.arrow” extension for files created with this format. Note that files created with this format are sometimes called “Feather V2” or with the “.feather” extension, the name and the extension derived from “Feather (V1)”, which was a proof of concept early in the Arrow project for language-agnostic fast data frame storage for Python (pandas) and R.
NB. ".arrows" We recommend the “.arrows” file extension for the streaming format although in many cases these streams will not ever be stored as files.


NB. NB. The difference between RecordBatchFileReader and RecordBatchStreamReader 
NB. NB. is that the input source must have a seek method for random access. 
NB.
NB. NB. Create inputstream (source) for recordbatch:
NB. NB. Create these via filesystem -OR-
NB. NB. directly from file . filesystem path is seekable, whereas buffer or mmmap 
NB.  garrow_file_input_stream_new
NB.  garrow_buffer_input_stream_new
NB.  garrow_memory_mapped_input_stream_new
NB.  garrow_gio_input_stream_new
NB.  garrow_compressed_input_stream_new
NB. NB. Create recordbatch from inputstream source
NB. garrow_input_stream_read_record_batch
NB.
NB.
NB. garrow_record_batch_file_reader_new
NB. garrow_record_batch_file_reader_get_schema
NB.
NB. NB. Read the recordbatches
NB. garrow_record_batch_reader_read_all (returns a table)
NB. garrow_record_batch_reader_new
NB. garrow_record_batch_reader_read_next
NB. garrow_record_batch_stream_reader_new
NB.
NB. garrow_record_batch_file_reader_new
NB. garrow_record_batch_file_reader_get_schema
NB. garrow_record_batch_file_reader_read_record_batch
NB.
NB. NB. Create file output streams (sinks):
NB. garrow_file_output_stream_new NB. write to a file
NB. garrow_buffer_output_stream_new	NB. Write to a buffer (in-memory)
NB. garrow_compressed_output_stream_new	NB. Compress the stream before writing onward.
NB.
NB. NB. Write the recordbatch into the  sink for recordbatch
NB. garrow_output_stream_write_record_batch
NB.
NB. garrow_record_batch_get_schema
NB. NB. ;;<(makeReadOptions '')



NB. Event-driven API
NB. https://arrow.apache.org/docs/cpp/api/ipc.html#event-driven-api
NB. listener StreamDecoder

NB. =========================================================
NB. =========================================================

newList =. {{
listitems =.y
listPtr =. <0
for_listitem.  listitems do. 
listPtr =. ptr g_list_append listPtr;<listitem
end. 
listPtr
}}

newSchema=: {{
NB. 'name dataType nullableBoolean'
fields =. y
fieldPtrs =. newField"1 fields
listPtr =. newList fieldPtrs
schemaPtr =. ptr garrow_schema_new <listPtr
schemaPtr
}}

NB. load'csv'
NB. newSchema makenum _3 ]\;: 'delay int64 0 distance int64 0 time float 0'

makeReadOptions=: {{
readoptions =. y
readOptionsPtr =. garrow
NB. "max-recursion-depth"	gint
NB. "use-threads"	gboolean
readOptionsPtr =. ptr garrow_read_options_new ''
NB. setProperties
readOptionsPtr
}}

makeWriteOptions=: {{
readoptions =. y
NB. "use-threads"	gboolean
NB. "alignment"	gint
NB. "allow-64bit" 	gboolean
NB. "codec"		GArrowCodec *
NB. "max-recursion-depth"	gint
NB. "use-threads"	gboolean
NB. "write-legacy-ipc-format"	gboolean
writeOptionsPtr =. ptr garrow_write_options_new ''
NB. setProperties
writeOptionsPtr
}}


NB. garrow_record_batch_get_schema

inputStreamtoRecordBatch =. {{
'inputStreamPtr schemaPtr readOptionsPtr' =. y
e=. < mema 4
recordBatchPtr =. ptr garrow_input_stream_read_record_batch inputStreamPtr;schemaPtr;readOptionsPtr;<e
memf > e
recordBatchPtr
}}

NB. garrow_buffer_new_bytes


fileInputStream =. {{
filepath =. y
filePtr =. setString  jpath filepath
e=. < mema 4
inputStreamPtr =. ptr garrow_file_input_stream_new filePtr;<e
inputStreamPtr
}}

NB.  garrow_buffer_input_stream_new
NB.  garrow_memory_mapped_input_stream_new
NB.  garrow_gio_input_stream_new
NB.  garrow_compressed_input_stream_new


writeRecordBatch=: {{
'tablePtr filepath'=. y
e=. < mema 4
fnPtr=. setString filepath
fileOutputStreamrPtr=. ptr garrow_file_output_stream_new fnPtr;0;<e
garrow_output_stream_align fileOutputStreamrPtr;64;;<e
NB. ...
}}


newResizableBuffer =: {{
e=. < mema 4
ptr garrow_resizable_buffer_new 1;<e
}}

newBufferOutpuStream =:{{
ptr garrow_buffer_output_stream_new < newResizableBuffer''
}}

NB. Output

fileOutpuStream=:{{
'filepath appendboolean' =. y
fnPtr =. setString jpath filepath
e=. < mema 4
ptr garrow_file_output_stream_new fnPtr;appendboolean;<e
}}

newCompressedOutpuStream =:{{
'codecPtr outputStreamPtr' =. y
e=. < mema 4
ptr garrow_compressed_output_stream_new codecPtr;outputStreamPtr;<e
}}


NB. Need to write the schema into this output stream somewhere...
NB. I suppose the idea is that one has a bunch of record batches, can get the schema from the first.
NB. But if the recordbatch contains the schema, why does it need to be sent in IPC first? Maybe something about parsing.
writeRecordBatchFile =. {{
'filepath appendboolean recordBatchPtr' =. y
fileOutputStreamPtr =. fileOutpuStream filepath;appendboolean
e2=. < mema 4
NB. ret garrow_output_stream_align fileOutputStreamPtr;64;<e2
writeOptionsPtr =. (makeWriteOptions '')
e1=. < mema 4
schemaPtr =. ptr garrow_record_batch_get_schema <recordBatchPtr
recordFileStreamWriterPtr =. ptr garrow_record_batch_file_writer_new fileOutputStreamPtr;schemaPtr;<e1 NB. Doesn't write anything yet.
NB. Then you could do the thing below and then close the writer, or use the garrow_record_batch_writer_write_record_batch on the writer.
e3=. < mema 4
garrow_record_batch_writer_write_record_batch recordFileStreamWriterPtr;recordBatchPtr;<e3
NB. echo ret garrow_output_stream_write_record_batch fileOutputStreamPtr;recordBatchPtr;writeOptionsPtr;<e3
NB. The IPC stream format is only optionally terminated, whereas the IPC file format must include a terminating footer.
NB. Close writes the terminating footer.
e4=. < mema 4
success =. ret garrow_record_batch_writer_close recordFileStreamWriterPtr;< e4
NB. garrow_writable_flush
success
}}

writeRecordBatchStream =. {{
'filepath appendboolean recordBatchPtr' =. y
fnPtr =. setString jpath filepath
e=. < mema 4
fileOutputStreamPtr =. ptr garrow_file_output_stream_new fnPtr;appendboolean;<e

e2=. < mema 4
NB. ret garrow_output_stream_align fileOutputStreamPtr;64;<e2
writeOptionsPtr =. (makeWriteOptions '')
e1=. < mema 4
schemaPtr =. ptr garrow_record_batch_get_schema <recordBatchPtr
recordBatchStreamWriterPtr =. ptr garrow_record_batch_stream_writer_new fileOutputStreamPtr;schemaPtr;<e1
NB. Then you could do the thing below and then close the writer, or use the garrow_record_batch_writer_write_record_batch on the writer.
NB. Unclear if this is necessary.
e3=. < mema 4
NB. Try to write it twice now:
garrow_record_batch_writer_write_record_batch recordBatchStreamWriterPtr;recordBatchPtr;<e3 NB. Using the stream writier works with 
NB. echo ret garrow_output_stream_write_record_batch fileOutputStreamPtr;recordBatchPtr;writeOptionsPtr;<e3

NB. The IPC stream format is only optionally terminated, whereas the IPC file format must include a terminating footer.
NB. Close writes the terminating footer.
e4=. < mema 4
NB. garrow_writable_flush
1
}}

writeTensorFile =. {{
'filepath appendboolean tensorPtr' =. y
fileOutputStreamPtr =. fileOutpuStream filepath;appendboolean
e=. < mema 4
ret garrow_output_stream_write_tensor outputStreamPtr;tensorPtr;<e
}}

recordBatchFileWriter =:{{
'outputStreamPtr schemaPtr' =.y 
e=. < mema 4
recordBatchStreamWriterPtr =.ptr garrow_record_batch_file_writer_new outputStreamPtr;schemaPtr;<e
recordBatchStreamWriterPtr
}}

recordBatchStreamWriter =:{{
'outputStreamPtr schemaPtr' =.y 
e=. < mema 4
recordBatchStreamWriterPtr =.ptr garrow_record_batch_stream_writer_new outputStreamPtr;schemaPtr;<e
recordBatchStreamWriterPtr
}}

NB. =========================================================
NB. =========================================================

{{
'outputStreamPtr schemaPtr recordBatchPtr' =.y 
e=. < mema 4
recordBatchStreamWriter  =. recordBatchStreamWriter outputStreamPtr;schemaPtr
ret garrow_record_batch_writer_write_record_batch recordBatchStreamWriter;recordBatchPtr;<e
ret garrow_record_batch_writer_close rbfwp;<e
}}

{{
'outputStreamPtr schemaPtr tablePtr' =.y 
e=. < mema 4
recordBatchStreamWriter  =. recordBatchStreamWriter outputStreamPtr;schemaPtr
ret garrow_record_batch_writer_write_table recordBatchStreamWriter;tablePtr;<e
}}




NB. =========================================================
NB. Test writing with several methods:
NB. =========================================================


NB. Get reccord batches from server.
flightStreamPtr =. getEndPointReader clientPtr;(getTicket > {.  getEndpoints infoPtr);<callOptPtr
rbPtrs =. flightStreamRecordBatch flightStreamPtr
schemaPtr =. getSchemaPt flightStreamReadAllTable flightStreamPtr
e=. < mema 4
recordBatchReaderPtr =. ptr garrow_record_batch_reader_new (newList rbPtrs);schemaPtr;<e
tablePtr =. ptr garrow_record_batch_reader_read_all recordBatchReaderPtr ;<e

NB. Write a stream
NB. Write with: garrow_output_stream_write_record_batch
arrowFP =. '~/Downloads/example.arrows'
writeRecordBatchStream arrowFP;0;<({. rbPtrs)

NB. Write with: garrow_record_batch_writer_write_record_batch
arrowFP =. '~/Downloads/example_recordbatch.arrow'
writeRecordBatchFile arrowFP;0;<({. rbPtrs)
NB. rbfwp =.  recordBatchFileWriter (fileOutpuStream arrowFP;0);<schemaPtr
NB. ret garrow_record_batch_writer_write_record_batch rbfwp;({. rbPtrs);<e
NB. ret garrow_record_batch_writer_close rbfwp;<e

NB. Write with: garrow_record_batch_writer_write_table 
arrowFP =. '~/Downloads/example_table.arrow'
rbfwp =.  recordBatchFileWriter (fileOutpuStream arrowFP;0);<schemaPtr
ret garrow_record_batch_writer_write_table rbfwp;tablePtr;<e
ret garrow_record_batch_writer_close rbfwp;<e




NB. schemaPtr =. getSchemaPt flightStreamReadAllTable flightStreamPtr
NB. recordBatchReaderPtr =. ptr garrow_record_batch_reader_new (newList rbPtrs);schemaPtr;<e
NB. ptr garrow_record_batch_reader_read_all recordBatchReaderPtr ;<e




NB. fexist arrowFP
NB. fnPtr =. setString fread jpath arrowFP
NB. bufferPtr =. ptr garrow_buffer_new fnPtr;<len
NB. ptr garrow_record_batch_stream_reader_new bufferPtr;<e NB. Crashes, maybe an invalid buffer?
NB. NB. bisPtr=. ptr garrow_buffer_input_stream_new  < bPtr
NB. ptr garrow_record_batch_stream_reader_new bisPtr;<e NB. Invalid: Tried reading schema message, was null or length 0
NB.
NB. * * u * * g_input_stream_read_bytes (GInputStream *stream,gsize count,GCancellable *cancellable, GError **error);GBytes *
NB. * * g_input_stream_clear_pending (GInputStream *stream);void

NB. Be careful because streams are stateful.

NB. garrow_record_batch_file_reader_get_schema
NB. garrow_record_batch_reader_get_schema (GArrowRecordBatchReader *reader); GArrowSchema *


flightStreamRecordBatch =: {{
NB. Watch filestream reader is stateful, and this function changes the state.
'fileStreamReaderPtr' =. y
e=. mema 4
fsChunkPtr =. ptr gaflight_record_batch_reader_read_next fileStreamReaderPtr;<<e
rbPtr=. > a:
if. > fsChunkPtr do.  NB. fsChunkPtr is a null pointer (<0) when there are no more batches.
 NB. ptr gaflight_stream_chunk_get_metadata	< fsChunkPtr  NB. (GAFlightStreamChunk *chunk); GArrowBuffer *
 rbPtr =. rbPtr, ptr gaflight_stream_chunk_get_data < fsChunkPtr NB. GArrowRecordBatch *
else.
 rbPtr =. < 0
end.
rbPtr
}}

NB. IPC READER CLASSES
NB. These are both record batch readers for stream format, for some reason.
NB. garrow_table_batch_reader_new NB. Table to recordbatch reader
NB. garrow_record_batch_reader_read_all NB. Reader to table


recordBatchFileReader =. {{
NB. Need to add iterators
NB. garrow_record_batch_iterator_new
NB. garrow_record_batch_serialize . takes a record batch, returns a buffer
filepath =. y
fileInputStreamPtr =. fileInputStream filepath
e0=. < mema 4
echo '[+] Align: ', ": ret garrow_input_stream_align fileInputStreamPtr;64;<e0
e=. < mema 4
echo '[+] Size: ', ": ret garrow_seekable_input_stream_get_size fileInputStreamPtr;<e
rbreaderPtr =. ptr garrow_record_batch_file_reader_new fileInputStreamPtr;<e
if. > rbreaderPtr do. 
schemaPtr =. ptr garrow_record_batch_file_reader_get_schema <rbreaderPtr
echo '[+] Schema: '
echo getSchemaFields schemaPtr
echo '[+] Recordbatch count: ', ":ret garrow_record_batch_file_reader_get_n_record_batches <rbreaderPtr NB. This is wacky, iterators on iterators.
NB. Need to iterate through stateful reader..
NB. 
NB. e2=. < mema 4
NB. ptr garrow_input_stream_read_record_batch fileInputStreamPtr;schemaPtr;(makeReadOptions'');<e2
NB. cder''
recordBatchPtr =. ptr garrow_record_batch_file_reader_read_record_batch rbreaderPtr;0;<e NB. Zero-indexed.
 if. >recordBatchPtr do.
 res =. readRecordBatchString recordBatchPtr NB. Change to reurn recordbatchpointers
 else.
 res =. <0
 end.
else.
res =. <0
end.
res
}}


recordBatchStreamReader =: {{
filepath =. y
fileInputStreamPtr =. fileInputStream filepath
e=. < mema 4
echo ret garrow_seekable_input_stream_get_size fileInputStreamPtr;<e
streamReaderPtr =. ptr garrow_record_batch_stream_reader_new fileInputStreamPtr;<e
if. > streamReaderPtr  do. 
schemaPtr =. ptr garrow_record_batch_reader_get_schema <streamReaderPtr
echo getSchemaFields schemaPtr
NB. As an alternative to the reader,
NB. Could also use the raw IO functions: garrow_input_stream_read_record_batch
readOptionsPtr =. makeReadOptions''
if. > tablePtr do. 
 recordBatchPtr =. ptr garrow_input_stream_read_record_batch fileInputStreamPtr;schemaPtr;readOptionsPtr;<e
 ret =. getString ptr garrow_record_batch_to_string recordBatchPtr;<e
else.
ret =. <0
end. 
else.
ret =. <0
end.
ret
}}

tableStreamReader =. {{
filepath =. y
fileInputStreamPtr =. fileInputStream filepath
e=. < mema 4
echo ret garrow_seekable_input_stream_get_size fileInputStreamPtr;<e
streamReaderPtr =. ptr garrow_record_batch_stream_reader_new fileInputStreamPtr;<e
if. > streamReaderPtr  do. 
schemaPtr =. ptr garrow_record_batch_reader_get_schema <streamReaderPtr
getSchemaFields schemaPtr
NB. As an alternative to the reader,
NB. Could also use the raw IO functions: garrow_input_stream_read_record_batch
NB. Or if it's seekable go to a specific part of the file
tablePtr =. ptr garrow_record_batch_reader_read_all streamReaderPtr;<e
if. > tablePtr do. 
 ret =. readsTable tablePtr
else.
ret =. <0
end. 
else.
ret =. <0
end.
ret
}}


NB. These work, read with garrow_record_batch_file_reader_new on a garrow_file_input_stream_new
arrowFP =. '~/Downloads/example_recordbatch.arrow' NB. works, created with garrow_record_batch_writer_write_record_batch
arrowFP =. '~/Downloads/example_table.arrow' NB. works, created with garrow_record_batch_writer_write_table
recordBatchFileReader arrowFP

NB. This works, read with garrow_record_batch_stream_reader_new
arrowFP =. '~/Downloads/flights-200k.arrows'
arrowFP =. '~/Downloads/example.arrows' 
recordBatchStreamReader arrowFP
tableStreamReader arrowFP

NB. These don't work with anything yet.
arrowFP =. '~/Downloads/scrabble_games.arrows'
arrowFP =. '~/Downloads/scrabble.arrows'

tableStreamReader arrowFP
recordBatchFileReader y=. arrowFP

NB. filepath =. arrowsFP
NB. fileInputStreamPtr =. fileInputStream filepath
NB. e=. < mema 4
NB. echo ret garrow_seekable_input_stream_get_size fileInputStreamPtr;<e
NB. streamReaderPtr =. ptr garrow_record_batch_stream_reader_new fileInputStreamPtr;<e

NB. garrow_record_batch_stream_reader_new should work with any inputStream.

NB. garrow_table_batch_reader_new

arrowFP =. '~/Downloads/scrabble.arrow'
fileInputStreamPtr =. fileInputStream jpath arrowFP
e=. < mema 4
ret garrow_seekable_input_stream_get_size fileInputStreamPtr;<e
garrow_record_batch_stream_reader_new fileInputStreamPtr;<e
garrow_record_batch_file_reader_new fileInputStreamPtr;<e
schemaPtr =. ptr garrow_record_batch_reader_get_schema <streamReaderPtr
getSchemaFields schemaPtr


NB. Try dump fileinputstream to buffer, buffer to bufferinputstream, then read.
fileInputStreamPtr =. fileInputStream jpath arrowFP
len =. ret garrow_seekable_input_stream_get_size fileInputStreamPtr ;<e
cancellablePtr =. ptr '"/usr/local/lib/libarrow-glib.dylib" g_cancellable_new * '&cd ''
bytesPtr =. ptr '"/usr/local/lib/libarrow-glib.dylib" g_input_stream_read_bytes * * i * *'&cd fileInputStreamPtr;len;cancellablePtr;<e NB. Invalid: Need seeking after ReadAt() before calling implicitly-positioned operation
bufferPtr =. ptr garrow_buffer_new_bytes < bytesPtr
bufferInputStreamPtr=. ptr garrow_buffer_input_stream_new  < bufferPtr 
ret garrow_seekable_input_stream_get_size bufferInputStreamPtr;<e
NB. ret garrow_input_stream_align bufferInputStreamPtr; 8;<e
ptr garrow_record_batch_stream_reader_new bufferInputStreamPtr;<e NB. Invalid: Tried reading schema message, was null or length 0

ret garrow_seekable_input_stream_get_support_zero_copy < bufferInputStreamPtr
bptr =. ptr garrow_seekable_input_stream_peek bufferInputStreamPtr;100;<e
memr (>bptr),0,100,2
NB. memr (> ptr g_bytes_get_data bytesPtr;< (setInts 2000)),0,2000,2
