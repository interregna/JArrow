
NB. =========================================================
NB. Arrow flight
NB. python3 flightclient.py put localhost:5005 iGd220525.csv
NB. python3 flightclient.py list localhost:5005
NB. python3 flightclient.py do localhost:5005 shutdown

setString=:{{
l1 =. >:@# string =. , y
string memw (] stringPt =. mema l1),0,l1,2
<stringPt
}}

setInts=:{{
l =. (# , y)
(,y) memw (] Pt =. mema l * 2^2+IF64),0,l,4
<Pt
}}

getString=:{{memr (> y),0,_1,2}}

getInts=:{{memr (> y),0,x,4}}

NB. test
e=. mema 4 NB. pointer to int32 for error codes
uriPt =. setString 'grpc+tcp://localhost:5005'
locPtr =. ptr gaflight_location_new uriPt;<<e

getString ptr gaflight_location_to_string <locPtr
getString  ptr gaflight_location_get_scheme <locPtr

clientOptPtr =. ptr gaflight_client_options_new ''
clientPtr =. ptr gaflight_client_new locPtr;(clientOptPtr);<<e
callOptPtr =. ptr gaflight_call_options_new ''

NB. List Flights
criteria =. ''
critPtr =. setString criteria
bytePtr =. ptr '"/usr/local/lib/libarrow-flight-glib.dylib" g_bytes_new * * i'&cd critPtr; # criteria
criteriaPtr =. ptr  gaflight_criteria_new < bytePtr
infoListPtr =. ptr gaflight_client_list_flights clientPtr;criteriaPtr;callOptPtr;<<e

NB. A list of flights is a list of pointers to 'info'
flightPtrCount =. ret '"/usr/local/lib/libarrow-flight-glib.dylib" g_list_length * * '&cd < infoListPtr
infoPtr =. ptr '"/usr/local/lib/libarrow-glib.dylib" g_list_nth_data * * i'&cd infoListPtr; 0 NB. Turn this into a function, interate on flightPtrCount


desPtr =. ptr gaflight_info_get_descriptor < infoPtr
ret gaflight_info_get_total_records < infoPtr
ret gaflight_info_get_total_bytes < infoPtr
desCharPtr =. ptr gaflight_descriptor_to_string < desPtr
getString desCharPtr


NB. A list of 'endpoints' is a ticket and list of locations
endpointListPtr =. ptr gaflight_info_get_endpoints < infoPtr
endpointCount =. ret '"/usr/local/lib/libarrow-flight-glib.dylib" g_list_length * * '&cd <endpointListPtr
endpointPtr =. ptr '"/usr/local/lib/libarrow-glib.dylib" g_list_nth_data * * i'&cd endpointListPtr;0 NB. Turn this into a function, interate on flightPtrCount
NB. locsPtr =. ptr gaflight_endpoint_get_locations < endpointPtr
NB. p0 =. ptr gaflight_endpoint_get_type ''
NB. getString ptr '"/usr/local/lib/libarrow-glib.dylib" g_type_name * *'&cd  <p0
NB. classPtr =. ptr '"/usr/local/lib/libarrow-glib.dylib" g_type_class_peek * *'&cd  <p0
NB. paramSpecPtr =. ptr '"/usr/local/lib/libarrow-glib.dylib" g_object_class_find_property * * *'&cd classPtr;< setString 'ticket'
NB. getString ptr '"/usr/local/lib/libarrow-glib.dylib" g_param_spec_get_name * *'&cd  <paramSpecPtr

NB. The property is found.

NB. =========================================================
NB. Endpoint -> ticker exmaple
NB. Try to create a new ticket, and then shift the data between byte pointerrs with the 'data' property.

t0 =. ptr gaflight_ticket_get_type ''
ticketPtr =. ptr '"/usr/local/lib/libarrow-glib.dylib" g_type_create_instance * *'&cd  <t0
'"/usr/local/lib/libarrow-glib.dylib" g_object_get n * * * *'&cd  endpointPtr;(setString 'ticket');ticketPtr;<<0
tp =. ptr 1 getInts ticketPtr

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

NB. reader is stateful
efs=. mema 4
tblPtr =. ptr gaflight_record_batch_reader_read_all FSReaderPtr;<<efs
readTable tblPtr
readsTable tblPtr
readColumn tblPtr;1



NB. reader is stateful
e5=. mema 4
tblPtr =. ptr gaflight_record_batch_reader_read_all FSReaderPtr;<<e3
readData tblPtr



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
