
NB. =========================================================
NB. Arrow flight
NB. python3 flightclient.py put localhost:5005 iGd220525.csv
NB. python3 flightclient.py list localhost:5005
NB. python3 flightclient.py do localhost:5005 shutdown

writeString=:{{
l1 =. >:@# string =. , y
string memw (] stringPt =. mema l1),0,l1,2
<stringPt
}}

writeInts=:{{
l =. (# , y)
(,y) memw (] Pt =. mema l * 2^2+IF64),0,l,4
<Pt
}}

readString=:{{memr (> y),0,_1,2}}

readInts=:{{memr (> y),0,x,4}}

NB. test
e=. mema 4 NB. pointer to int32 for error codes
uriPt =. writeString 'grpc+tcp://localhost:5005'
locPtr =. ptr gaflight_location_new uriPt;<<e

readString ptr gaflight_location_to_string <locPtr
readString  ptr gaflight_location_get_scheme <locPtr

clientOptPtr =. ptr gaflight_client_options_new ''
clientPtr =. ptr gaflight_client_new locPtr;(clientOptPtr);<<e
callOptPtr =. ptr gaflight_call_options_new ''

NB. List Flights
criteria =. ''
critPtr =. writeString criteria
bytePtr =. ptr '"/usr/local/lib/libarrow-flight-glib.dylib" g_bytes_new * * i'&cd critPtr; # criteria
criteriaPtr =. ptr  gaflight_criteria_new < bytePtr
flightListPtr =. ptr gaflight_client_list_flights clientPtr;criteriaPtr;callOptPtr;<<e

NB. A list of flights is a list of pointers to 'info'
flightPtrCount =. ret '"/usr/local/lib/libarrow-flight-glib.dylib" g_list_length * * '&cd <flightListPtr
NB. firstFlightPtr =. ptr '"/usr/local/lib/libarrow-glib.dylib" g_list_nth * * i'&cd flightListPtr;0 NB. Turn this into a function, interate on flightPtrCount
NB. get flight info pointer from pointer
NB. infoPtr =. < {. memr (> firstFlightPtr),0,1,4
infoPtr =. ptr '"/usr/local/lib/libarrow-glib.dylib" g_list_nth_data * * i'&cd flightListPtr;3 NB. Turn this into a function, interate on flightPtrCount

desPtr =. ptr gaflight_info_get_descriptor < infoPtr
ret gaflight_info_get_total_records < infoPtr
ret gaflight_info_get_total_bytes < infoPtr
desCharPtr =. ptr gaflight_descriptor_to_string < desPtr
readString desCharPtr

endpointListPtr =. ptr gaflight_info_get_endpoints < infoPtr
endpointCount =. ret '"/usr/local/lib/libarrow-flight-glib.dylib" g_list_length * * '&cd < endpointListPtr

NB. A list of 'endpoints' is a list of points to locations and a ticket
NB. firstEndpointPtrPtr =. ptr '"/usr/local/lib/libarrow-glib.dylib" g_list_nth * * i'&cd endpointListPtr;0 NB. Turn this into a function, interate on flightPtrCount
NB. firstEndpointPtr =. < {. memr (> firstEndpointPtrPtr),0,1,4
firstEndpointPtr =. ptr '"/usr/local/lib/libarrow-glib.dylib" g_list_nth_data * * i'&cd endpointListPtr;0 NB. Turn this into a function, interate on flightPtrCount
locsPtr =. ptr gaflight_endpoint_get_locations < firstEndpointPtr

NB. This works, so properties work
NB. endpoint->'ticket', info->'info', flight->'data'
NB. p0 =. ptr gaflight_info_get_type ''
p0 =. ptr gaflight_endpoint_get_type ''
fs0 =. ptr gaflight_stream_reader_get_type ''

namePtr =. writeString 'ticket'
typeNamePtr =. ptr '"/usr/local/lib/libarrow-glib.dylib" g_type_name * *'&cd  <p0
readString typeNamePtr
classPtr =. ptr '"/usr/local/lib/libarrow-glib.dylib" g_type_class_peek * *'&cd  <p0
paramSpecPtr =. ptr '"/usr/local/lib/libarrow-glib.dylib" g_object_class_find_property * * *'&cd classPtr;<namePtr
paramSpecNamePtr =. ptr '"/usr/local/lib/libarrow-glib.dylib" g_param_spec_get_name * *'&cd  <paramSpecPtr
readString paramSpecNamePtr
NB. The property is found.

NB. =========================================================
NB. Endpoint -> ticker exmaple
NB. Try to create a new ticket, and then shift the data between byte pointerrs with the 'data' property.

t0 =. ptr gaflight_ticket_get_type ''
ticketPtr =. ptr '"/usr/local/lib/libarrow-glib.dylib" g_type_create_instance * *'&cd  <t0

tnp=. writeString 'ticket'
'"/usr/local/lib/libarrow-glib.dylib" g_object_get n * * * *'&cd  firstEndpointPtr;tnp;ticketPtr;<<0
tp =. < 0&{:: 1 readInts ticketPtr 
e2q=. mema 4
FSReaderPtr =. ptr gaflight_client_do_get clientPtr;tp;callOptPtr;<<e2q
e3=. mema 4 
] fsChunkPtr =. ptr gaflight_record_batch_reader_read_next FSReaderPtr;<<e3
] rbPtr =. ptr gaflight_stream_chunk_get_data < fsChunkPtr NB. GArrowRecordBatch *
] ptr gaflight_stream_chunk_get_metadata	< fsChunkPtr  NB. (GAFlightStreamChunk *chunk); GArrowBuffer *
NB. see https://github.com/apache/arrow/blob/c2e198b84d6752733bdd20089195dc9c47df73a1/c_glib/arrow-glib/record-batch.cpp
e4=. mema 4
rbsPtr =. ptr garrow_record_batch_to_string rbPtr;<<e4
memr (>rbsPtr),0,_1,2


NB. =========================================================
NB. Ticker -> Byte pointer example
NB. Try to create a new ticket, and then shift the data between byte pointerrs with the 'data' property.

ticketlist =. ' (1, None, (b''iGd220525.csv'',))'
ticketListPtr=. writeString ticketlist
len =. # ticketlist
bytePtr =. ptr '"/usr/local/lib/libarrow-flight-glib.dylib" g_bytes_new * * i'&cd (ticketListPtr);len
ticketPtr =. ptr gaflight_ticket_new < bytePtr

NB. New byte pointer
ticketlist2 =. 'WRONG THING'
ticketListPtr2=. writeString ticketlist2
len2 =. # ticketlist2
bytePtr2 =. ptr '"/usr/local/lib/libarrow-flight-glib.dylib" g_bytes_new * * i'&cd (ticketListPtr2);len2

NB. Get property 
tnp=. writeString 'data'
'"/usr/local/lib/libarrow-glib.dylib" g_object_get n * * * *'&cd  ticketPtr;tnp;bytePtr2;<<0
bplen2 =. writeInts ret '"/usr/local/lib/libarrow-glib.dylib" g_bytes_get_size * *'&cd < bytePtr2
dataPtr2 =. ptr '"/usr/local/lib/libarrow-glib.dylib" g_bytes_get_data * * *'&cd bytePtr2;<bplen2
memr (memr (>dataPtr2),0,1,4),0,_1,2


NB. =========================================================
NB. This actually works, wtf.
NB. Doesn't pull anything from the endpoint, just creates a ticket directly.
NB. ticker init 4:
NB. try a raw string copied from python server output
ticketlist =. ' (1, None, (b''iGd220525.csv'',))' 
tnp=. writeString ticketlist
len =. # ticketlist
bytePtr =. ptr '"/usr/local/lib/libarrow-flight-glib.dylib" g_bytes_new * * i'&cd (tnp);len
ticketPtr =. ptr gaflight_ticket_new <bytePtr
e2=. mema 4
[  FSReaderPtr =. ptr gaflight_client_do_get clientPtr;ticketPtr;callOptPtr;<<e2
NB.   FSReaderPtr =. ptr gaflight_client_do_get clientPtr;ticketPtr;(<0);<<e2 NB. Example with null callOption


NB. Can only run this when a non-null pointer is returned to FSReaderPtr
e3=. mema 4 
] fsChunkPtr =. ptr gaflight_record_batch_reader_read_next FSReaderPtr;<<e3
] rbPtr =. ptr gaflight_stream_chunk_get_data < fsChunkPtr NB. GArrowRecordBatch *
] ptr gaflight_stream_chunk_get_metadata	< fsChunkPtr  NB. (GAFlightStreamChunk *chunk); GArrowBuffer *
NB. see https://github.com/apache/arrow/blob/c2e198b84d6752733bdd20089195dc9c47df73a1/c_glib/arrow-glib/record-batch.cpp
e4=. mema 4
rbsPtr =. ptr garrow_record_batch_to_string rbPtr;<<e4
memr (>rbsPtr),0,_1,2

NB. reader is stateful
NB. eventually run into some type issues on a column, but otherwise works.
NB. Types:
NB. QUALITYTIER: null
NB. QUALITYTIERTYPE: null
e5=. mema 4
tblPtr =. ptr gaflight_record_batch_reader_read_all FSReaderPtr;<<e3
33 { readTable tblPtr
33 { readSchemaNames tblPtr
readData tblPtr
ncols =. tableNCols tblPtr
chunkedArrayPts =.  <"0 ptr"1 garrow_table_get_column_data tblPtr ;"0 i. ncols
,. > readChunkedArray each chunkedArrayPts
> readChunks each  33 { |. chunkedArrayPts
chunkedArrayPt=. > 33 { |. chunkedArrayPts
nChunks =. ret@garrow_chunked_array_get_n_chunks < chunkedArrayPt
arrayPts =. readChunk each <"1 (<chunkedArrayPt),.(<"0 i. nChunks)
readArray each 1{. arrayPts
'arrayPt' =. >  1{ arrayPts
indexType =. readArrayTypeIndex arrayPt NB. This is where the error is, column 33 zero-indexed
arrayType =. readArrayType arrayPt
length =. readArrayLength arrayPt
getValueFunc =. typeGetValue&typeIndexLookup indexType NB. lookup functions
fRun =. getValueFunc,', arrayPt;<'
results =. ; ret@". each (fRun&,)@": each <"0 i.length
  NB. width =. readArrayBitWidth arrayPt
  NB. lengthPt =. writeArrayWidth length;width
  NB. getValuesFunc =. typeGetValues&typeIndexLookup indexType NB. lookup functions
  NB. arrayValuesPt =.  ptr ". getValuesFunc,', (arrayPt);<lengthPt'
  NB. Jtype =.  ". typeJMemr&typeIndexLookup indexType
  NB. results =. memr (ret arrayValuesPt),0,length,Jtype
  NB. memf > lengthPt
  results



healthcheck

reader.read

gaflight_descriptor_to_string

gaflight_call_options_add_header
gaflight_call_options_clear_headers
gaflight_call_options_foreach_header

gaflight_client_close
gaflight_client_list_flights
gaflight_client_get_flight_info
gaflight_client_do_get

gaflight_criteria_new
gaflight_descriptor_to_string
gaflight_path_descriptor_new
gaflight_path_descriptor_get_paths

gaflight_command_descriptor_new
gaflight_command_descriptor_get_command
gaflight_ticket_new
gaflight_endpoint_new
gaflight_endpoint_get_locations

gaflight_info_new
gaflight_info_get_schema
gaflight_info_get_descriptor
gaflight_info_get_endpoints
gaflight_info_get_total_records
gaflight_info_get_total_bytes

gaflight_stream_chunk_get_data
gaflight_stream_chunk_get_metadata
gaflight_record_batch_reader_read_next
gaflight_record_batch_reader_read_all

garrow_record_batch_reader_import
garrow_record_batch_reader_new
garrow_record_batch_reader_get_schema
garrow_record_batch_file_reader_new
GArrowRecordBatchReader

gaflight_data_stream_get_type
gaflight_servable_get_type
gaflight_record_batch_stream_get_type
