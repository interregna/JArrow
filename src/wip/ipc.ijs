NB. arrow::read_ipc_stream()
NB. arrow::read_feather()
NB. arrow::read_parquet()
NB. arrow::read_csv_arrow()
NB. arrow::read_json_arrow()
NB. arrow::read_delim_arrow()
NB. arrow::read_schema()
NB. arrow::read_message()
NB. arrow::read_tsv_arrow()

NB. =========================================================
NB. Reading and writing IPC
NB. =========================================================

NB. recordbatch is row store data
NB. table is columnar store in arrays

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


NB. =========================================================
NB. Input streams
NB. =========================================================
fileInputStream =. {{
filepath =. y
filePtr =. setString  jpath filepath
e=. < mema 4
inputStreamPtr =. ptr garrow_file_input_stream_new filePtr;<e
memf > e
inputStreamPtr
}}

NB.  garrow_buffer_input_stream_new
NB.  garrow_memory_mapped_input_stream_new
NB.  garrow_gio_input_stream_new
NB.  garrow_compressed_input_stream_new

newResizableBuffer =: {{
e=. < mema 4
ptr garrow_resizable_buffer_new 1;<e
}}

newBufferOutpuStream =:{{
ptr garrow_buffer_output_stream_new < newResizableBuffer''
}}

NB. =========================================================
NB. Output streams
NB. =========================================================

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

recordBatchStreamWriter =:{{
'outputStreamPtr schemaPtr' =.y 
e=. < mema 4
recordBatchStreamWriterPtr =.ptr garrow_record_batch_stream_writer_new outputStreamPtr;schemaPtr;<e
recordBatchStreamWriterPtr
}}

NB. =========================================================
NB. IPC WRITER CLASSES
NB. =========================================================

writeRecordBatchStream =. {{
NB. IPC stream format is  optionally footer-terminated and does not contain ARROW1 magic numbers at beginning and end.
'filepath appendboolean recordBatchPtr' =. y
fileOutputStreamPtr =. fileOutpuStream filepath;appendboolean
NB. e1=. < mema 4
NB. ret garrow_output_stream_align fileOutputStreamPtr;64;<e1
writeOptionsPtr =. makeWriteOptions ''
e2=. < mema 4
schemaPtr =. ptr garrow_record_batch_get_schema <recordBatchPtr
recordBatchStreamWriterPtr =. ptr garrow_record_batch_stream_writer_new fileOutputStreamPtr;schemaPtr;<e2
NB. Then you could do the thing below and then close the writer, or use the garrow_record_batch_writer_write_record_batch on the writer.
e3=. < mema 4
garrow_record_batch_writer_write_record_batch recordBatchStreamWriterPtr;recordBatchPtr;<e3
NB. echo ret garrow_output_stream_write_record_batch fileOutputStreamPtr;recordBatchPtr;writeOptionsPtr;<e3
1
}}

recordBatchFileWriter =:{{
'outputStreamPtr schemaPtr' =.y 
e=. < mema 4
recordbatchFilestreamWriterPtr =.ptr garrow_record_batch_file_writer_new outputStreamPtr;schemaPtr;<e
recordbatchFilestreamWriterPtr
}}


writeRecordBatchFile =. {{
'filepath appendboolean recordBatchPtr' =. y
NB. The IPC file format is footer-terminated and does contain ARROW1 magic numbers at beginning and end.
fileOutputStreamPtr =. fileOutpuStream filepath;appendboolean
e2=. < mema 4
NB. ret garrow_output_stream_align fileOutputStreamPtr;64;<e2
writeOptionsPtr =. (makeWriteOptions '')
e1=. < mema 4
schemaPtr =. ptr garrow_record_batch_get_schema <recordBatchPtr
NB. recordFileStreamWriterPtr =. ptr garrow_record_batch_file_writer_new fileOutputStreamPtr;schemaPtr;<e1 NB. Doesn't write anything yet.
recordbatchFilestreamWriterPtr =.  recordBatchFileWriter fileOutputStreamPtr;<schemaPtr
NB. Then you could do the thing below and then close the writer, or use the garrow_record_batch_writer_write_record_batch on the writer.
e3=. < mema 4
garrow_record_batch_writer_write_record_batch recordbatchFilestreamWriterPtr;recordBatchPtr;<e3
NB. echo ret garrow_output_stream_write_record_batch fileOutputStreamPtr;recordBatchPtr;writeOptionsPtr;<e3
NB. Close writes the terminating footer.
e4=. < mema 4
success =. ret garrow_record_batch_writer_close recordbatchFilestreamWriterPtr;< e4
success
}}

writeTableFile =: {{
'filepath appendboolean tablePtr' =. y
schemaPtr =. getSchemaPt tablePtr
recordBatchFileWriterPtr =.  recordBatchFileWriter (fileOutpuStream filepath;appendboolean);<schemaPtr
e1=. < mema 4
success1 =. ret garrow_record_batch_writer_write_table recordBatchFileWriterPtr;tablePtr;<e1
e2=. < mema 4
success2 =. ret garrow_record_batch_writer_close recordBatchFileWriterPtr;<e2
memf > e1
memf > e2
>./ success1, success2 
}}


writeTensorFile =. {{
'filepath appendboolean tensorPtr' =. y
fileOutputStreamPtr =. fileOutpuStream filepath;appendboolean
e=. < mema 4
ret garrow_output_stream_write_tensor outputStreamPtr;tensorPtr;<e
}}


NB. =========================================================
NB. IPC READER CLASSES
NB. =========================================================


recordBatchFileReader =. {{
filepath =. y
fileInputStreamPtr =. fileInputStream filepath
e0=. < mema 4
ret garrow_input_stream_align fileInputStreamPtr;64;<e0
e1=. < mema 4
NB. echo '[+] Size: ', ": ret garrow_seekable_input_stream_get_size fileInputStreamPtr;<e1
e2=. < mema 4
rbreaderPtr =. ptr garrow_record_batch_file_reader_new fileInputStreamPtr;<e2
'Not a valid recordbatchReader.' assert * >  rbreaderPtr
NB. schemaPtr =. ptr garrow_record_batch_file_reader_get_schema <rbreaderPtr
NB. echo '[+] Schema: '
NB. echo getSchemaFields schemaPtr
recordBatchCount =. ret garrow_record_batch_file_reader_get_n_record_batches <rbreaderPtr
NB. echo '[+] Recordbatch count: ', ":ret garrow_record_batch_file_reader_get_n_record_batches <rbreaderPtr
NB. e3=. < mema 4
NB. p3r garrow_input_stream_read_record_batch fileInputStreamPtr;schemaPtr;(makeReadOptions'');<e2
e4=. < mema 4
recordBatchPtr =. (ptr@garrow_record_batch_file_reader_read_record_batch)"1 rbreaderPtr ;"0 1 (i. recordBatchCount);"0 0<e4
('Not a valid recordbatch.'&assert)@* each recordBatchPtr
recordBatchPtr
}}

recordBatchStreamReader =: {{
filepath =. y
fileInputStreamPtr =. fileInputStream filepath
'Not a vaild inputstream pointer.' assert * > fileInputStreamPtr
e1=. < mema 4
ret garrow_input_stream_align fileInputStreamPtr;64;<e1
NB. echo ret garrow_seekable_input_stream_get_size fileInputStreamPtr;<e
e2=. < mema 4
streamReaderPtr =. ptr garrow_record_batch_stream_reader_new fileInputStreamPtr;<e2
'Not a valid streamReader.' assert * >  streamReaderPtr
schemaPtr =. ptr garrow_record_batch_reader_get_schema <streamReaderPtr
NB. echo getSchemaFields schemaPtr
readOptionsPtr =. makeReadOptions''
'Not a valid table.' assert * > schemaPtr
e4=. < mema 4
recordBatchPtr =. ptr garrow_input_stream_read_record_batch fileInputStreamPtr;schemaPtr;readOptionsPtr;<e4
NB. getString ptr garrow_record_batch_to_string recordBatchPtr;<e
recordBatchPtr
}}


tableStreamReader =: {{
NB. read input stream directly from file.
filepath =. y
inputStreamPtr =. fileInputStream filepath
e =. < mema 4
ret garrow_input_stream_align inputStreamPtr;64;<e
streamReaderPtr =. ptr garrow_record_batch_stream_reader_new inputStreamPtr;<e
tablePtr =. ptr garrow_record_batch_reader_read_all streamReaderPtr;<e
memf > e
ret  g_object_unref < inputStreamPtr
ret  g_object_unref < streamReaderPtr
tablePtr
}}

tableStreamReader2 =.{{
NB. Read file buffer then read stream from buffer.
NB. This is 1.5-5 times slower than reading directly from the file, but it works as a buffer POC.
e =. < mema 4
size =. fsize jpath y
dataPtr =. mema size
(fread jpath y) memw  dataPtr,0,size,2
gBtyesPtr =. ptr g_bytes_new (<dataPtr);size
bufferPtr =. ptr garrow_buffer_new_bytes <gBtyesPtr
inputStreamPtr =. bufferInputStreamPtr =. ptr garrow_buffer_input_stream_new <bufferPtr 
ret garrow_input_stream_align inputStreamPtr;64;<e
streamReaderPtr =. ptr garrow_record_batch_stream_reader_new inputStreamPtr;<e
schemaPtr =. ptr garrow_record_batch_reader_get_schema <streamReaderPtr
tablePtr =. ptr garrow_record_batch_reader_read_all streamReaderPtr;<e
g_bytes_unref <gBtyesPtr
memf dataPtr
memf > e
ret g_object_unref <  schemaPtr 
ret g_object_unref <  bufferPtr
ret  g_object_unref < inputStreamPtr
tablePtr
}}

NB. mpPtr =. ptr garrow_memory_pool_default ''
NB. ret garrow_memory_pool_get_bytes_allocated <mpPtr 
NB. ret garrow_memory_pool_get_max_memory <mpPtr 

y =. '~/Downloads/flights-200k.arrows'
g_object_unref < tableStreamReader y
g_object_unref < tableStreamReader2 y
(1e4) 6!:2  'g_object_unref < tableStreamReader y'
(1e4) 6!:2  'g_object_unref < tableStreamReader2 y'

y =. '~/Downloads/scrabble_games.arrows'
g_object_unref < tableStreamReader y
g_object_unref < tableStreamReader2 y
(1e4) 6!:2  'g_object_unref < tableStreamReader y'
(1e4) 6!:2  'g_object_unref < tableStreamReader2 y'

y =. '~/Downloads/example.arrows' 
g_object_unref < tableStreamReader y
g_object_unref <  tableStreamReader2 y
NB. readTable  tableStreamReader2 y
(1e4) 6!:2  'g_object_unref < tableStreamReader y'
(1e4) 6!:2  'g_object_unref < tableStreamReader2 y'



NB. =========================================================
NB. Test writing with several methods:
NB. =========================================================

load jpath '~JPackageDev/jarrow/src/wip/flight.ijs'

clientPtr =. createClient@connectLocation 'grpc+tcp://localhost:5005'
flightListPtr =. getClientFlights  clientPtr;''
infoPtr =. flightInfoList flightListPtr
endpointPtrs =. getEndpoints infoPtr NB. Each info pointer has multiple potential endpoints
NB. Get table pointers:
tblPtr =. {. each flightStreamReadAllTable@{. each endPointsFlightstreamReader@{.  each endpointPtrs

NB. Get recordbatch  pointers:
rbPtrs =. flightStreamRecordBatch@{. each endPointsFlightstreamReader@{. each  endpointPtrs

NB. Write into an arrow file
NB. Write with: garrow_record_batch_writer_write_table
arrowFP =. '~/Downloads/example_table.arrow'
writeTableFile  arrowFP;0;< > {. tblPtr

NB. Write into an arrow file
NB. Write with: garrow_record_batch_writer_write_record_batch
arrowFP =. '~/Downloads/example_recordbatch.arrow'
writeRecordBatchFile arrowFP;0;(< {. > {.rbPtrs) NB. Only writes the first recordbatch for now.

NB. Write into an arrows stream
NB. This should iterate over a list of recordbatches rather than a single recordbatch
NB. Write with: garrow_output_stream_write_record_batch
arrowFP =. '~/Downloads/example.arrows'
writeRecordBatchStream arrowFP;0;(< {. > {.rbPtrs) NB. Only writes the first recordbatch for now.

NB. * * u * * g_input_stream_read_bytes (GInputStream *stream,gsize count,GCancellable *cancellable, GError **error);GBytes *
NB. * * g_input_stream_clear_pending (GInputStream *stream);void


NB. =========================================================
NB. Readers

arrowFP =. '~/Downloads/example_recordbatch.arrow' NB. works, created with garrow_record_batch_writer_write_record_batch
recordBatchFileReader arrowFP

arrowFP =. '~/Downloads/example_table.arrow' NB. works, created with garrow_record_batch_writer_write_table
recordBatchFileReader arrowFP




NB. This works, read with garrow_record_batch_stream_reader_new
arrowFP =. '~/Downloads/flights-200k.arrows'
recordBatchStreamReader arrowFP
$ each  readTable  tableStreamReader arrowFP

arrowFP =. '~/Downloads/example.arrows' 
recordBatchStreamReader arrowFP
$ each  readTable tableStreamReader arrowFP

arrowFP =. '~/Downloads/scrabble_games.arrows'
recordBatchStreamReader arrowFP
$ each  readTable  tableStreamReader arrowFP 


