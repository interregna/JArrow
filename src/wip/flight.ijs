
NB. =========================================================
NB. Arrow flight
NB. python3 flightclient.py list localhost:5005
NB. python3 flightclient.py put localhost:5005 iGd220525.csv
NB. python3 flightclient.py do localhost:5005 shutdown

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
bytePtr =. ptr g_bytes_new critPtr; # criteria
criteriaPtr =. ptr  gaflight_criteria_new < bytePtr
infoListPtr =. ptr gaflight_client_list_flights clientPtr;criteriaPtr;callOptPtr;<<e

NB. A list of flights is a list of pointers to 'info'
flightPtrCount =. ret g_list_length < infoListPtr
infoPtr =. ptr g_list_nth_data infoListPtr; 0 NB. Turn this into a function, interate on flightPtrCount

flightInfo =: {{
'infoPtr' =. y 
desPtr =. ptr gaflight_info_get_descriptor < infoPtr
desCharPtr =. ptr gaflight_descriptor_to_string < desPtr
description =. getString desCharPtr
recordcount =. ret gaflight_info_get_total_records < infoPtr
byteCount =.  ret gaflight_info_get_total_bytes < infoPtr
'Flight Info: ',description,LF,'Record count: ',(": recordcount),LF,'Byte count: ',(": byteCount),LF
}}



getEndpoints =: {{
NB. Args an info pointer.
NB. Return a list of 'endpoints', each a ticket and list of locations
'infoPtr' =. y
endpointListPtr =. ptr gaflight_info_get_endpoints < infoPtr
endpointCount =. ret g_list_length <endpointListPtr
indices =. <"0 i. endpointCount
endpointPtrs =. ptr@g_list_nth_data each <"1 (<endpointListPtr),.indices
endpointPtrs
}}

getTicket =: {{
NB. Arg an endpoint
NB. Return a pointer to a ticket.
'endpointPtr' =. y
t0 =. ptr gaflight_ticket_get_type ''
ticketPtrInst =. ptr g_type_create_instance  <t0
g_object_get endpointPtr;(setString 'ticket');ticketPtrInst;<<0
ticketPtr =. ptr 1 getInts ticketPtrInst
ticketPtr
}}

getTickets =:{{getTicket each y}}


getEndPointReader =:{{
'clientPtr ticketPtr callOptPtr' =. y
NB. if no client or call option, make one from the ticket
e=. mema 4
FSReaderPtr =. ptr gaflight_client_do_get clientPtr;ticketPtr;callOptPtr;<<e
FSReaderPtr
}}

fsReadAllTable =:{{
'FSReaderPtr' =. y
e=. mema 4
tblPtr =. ptr gaflight_record_batch_reader_read_all FSReaderPtr;<<e
tblPtr
}}

fsChunkRecordBatch =: {{
NB. Watch filestream reader is stateful, and this function changes the state.
'FSReaderPtr' =. y
e=. mema 4
fsChunkPtr =. ptr gaflight_record_batch_reader_read_next FSReaderPtr;<<e
if. > fsChunkPtr do.  NB. fsChunkPtr is a null pointer (<0) when there are no more batches.
 NB. ptr gaflight_stream_chunk_get_metadata	< fsChunkPtr  NB. (GAFlightStreamChunk *chunk); GArrowBuffer *
 rbPtr =. ptr gaflight_stream_chunk_get_data < fsChunkPtr NB. GArrowRecordBatch *
else.
 rbPtr =. < 0
end.
rbPtr
}}

readRecordBatchString =: {{
'recordBatchPtr' =. y
e=. mema 4
getString  ptr garrow_record_batch_to_string recordBatchPtr;<<e
}}


NB. =========================================================
NB. Demo:
flightInfo infoPtr
getEndpoints infoPtr
readRecordBatchString 
tblPtr =. fsReadAllTable getEndPointReader clientPtr;(getTicket > {.  getEndpoints infoPtr);<callOptPtr
readTableSchema tblPtr

NB. =========================================================
NB. Testing and examples.

readTableSchema tblPtr
readTableSchemaTypes tblPtr
readTable tblPtr
readColumn tblPtr;86
readsTable tblPtr





NB. =========================================================


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