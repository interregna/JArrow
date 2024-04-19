
NB. =========================================================
NB. Arrow flight
NB. python3 flightserver.py
NB. python3 flightclient.py list localhost:5005
NB. python3 flightclient.py put localhost:5005 iGd220525.csv
NB. python3 flightclient.py do localhost:5005 shutdown

flightInfo =: {{
'infoPtr' =. y 
desPtr =. ptr gaflight_info_get_descriptor < infoPtr
desCharPtr =. ptr gaflight_descriptor_to_string < desPtr
description =. getString desCharPtr
recordcount =. ret gaflight_info_get_total_records < infoPtr
byteCount =.  ret gaflight_info_get_total_bytes < infoPtr
readOptionsPtr =. makeReadOptions''
e=. initError ''
schema =. getString ret ptr garrow_schema_to_string <  ptr gaflight_info_get_schema infoPtr;readOptionsPtr;<e
res =. >a:
res=. res, '[+] Flight Info:',LF
res=. res, '[+]  Description: ',description,LF
res=. res, '[+]  Record count: ',(": recordcount),LF
res=. res, '[+]  Byte count: ',(": byteCount),LF
res=. res, '[+]  Schema: ', schema, LF
res
}}"0

getEndpoints =: {{
NB. Args an info pointer.
NB. Return a list of 'endpoints', each a ticket and list of locations
'infoPtr' =. y
endpointListPtr =. ptr gaflight_info_get_endpoints < infoPtr
endpointCount =. ret g_list_length <endpointListPtr
indices =. <"0 i. endpointCount
endpointPtrs =. (ptr@g_list_nth_data)"1 (<endpointListPtr),.indices
endpointPtrs
}}"0

getTicket =: {{
NB. Arg an endpoint
NB. Return a pointer to a ticket.
'endpointPtr' =. {. y
t0 =. ptr gaflight_ticket_get_type ''
ticketPtrInst =. ptr g_type_create_instance  <t0
g_object_get endpointPtr;(setString 'ticket');ticketPtrInst;<<0
ticketPtr =. ptr 1 getInts ticketPtrInst
ticketPtr
}}"0

getEndpointReader =:{{
'clientPtr ticketPtr callOptPtr' =. y
NB. if no client or call option, make one from the ticket
e=. initError ''
FSReaderPtr =. ptr gaflight_client_do_get clientPtr;ticketPtr;callOptPtr;<e
FSReaderPtr
}}"1

flightStreamReadAllTable =:{{
'FSReaderPtr' =. y
e=. mema 4
tblPtr =. ptr gaflight_record_batch_reader_read_all FSReaderPtr;<<e
tblPtr
}}"0

flightStreamRecordBatch =: {{
'FSReaderPtr' =. y
e=. mema 4
rbPtrs =. > a:
fsChunkPtr =. ptr gaflight_record_batch_reader_read_next FSReaderPtr;<<e
'Not a valid flightstream chunk pointer.' assert *  > fsChunkPtr
NB. ptr gaflight_stream_chunk_get_metadata	< fsChunkPtr
while. > fsChunkPtr do. 
rbPtr =. ptr gaflight_stream_chunk_get_data < fsChunkPtr 
'Not a valid recordbatch pointer.' assert * > rbPtr
rbPtrs =. rbPtrs, rbPtr
fsChunkPtr =. ptr gaflight_record_batch_reader_read_next FSReaderPtr;<<e
end.
rbPtrs
}}

readRecordBatchString =: {{
'recordBatchPtr' =. y
e=. initError ''
res =. getString  ptr garrow_record_batch_to_string recordBatchPtr;<e
checkError e
res
}}

connectLocation =. {{
locationString =. y
uriPt =. setString y
e=. mema 4 
locPtr =. ptr gaflight_location_new uriPt;<<e
echo '[+ scheme: ', getString  ptr gaflight_location_get_scheme <locPtr
echo '[+ location: ', getString ptr gaflight_location_to_string <locPtr
locPtr
}}

createClient =. {{
locPtr =. y
e=. mema 4 
clientOptPtr =. ptr gaflight_client_options_new ''
callOptPtr =. ptr gaflight_call_options_new ''
clientPtr =. ptr gaflight_client_new locPtr;(clientOptPtr);<<e
clientPtr 
}}

NB. NB. List Flights
NB. getClientFlights =.  {{
NB. 'clientPtr criteria' =. y 	NB. '' is default
NB. e=. mema 4 
NB. critPtr =. setString criteria
NB. bytePtr =. ptr g_bytes_new critPtr; # criteria
NB. callOptPtr =. ptr gaflight_call_options_new ''
NB. criteriaPtr =. ptr  gaflight_criteria_new < bytePtr
NB. flightListPtr =. ptr gaflight_client_list_flights clientPtr;criteriaPtr;callOptPtr;<<e
NB. flightListPtr
NB. }}"1
NB.
NB. NB. A list of flights is a list of pointers to 'info'
NB. flightInfoList =:{{
NB. infoListPtr =. y
NB. flightPtrCount =. ret g_list_length < infoListPtr
NB. infoPtrs =.( ptr@g_list_nth_data)"1 (<infoListPtr),.  <"0 i.flightPtrCount NB. Turn this into a function, iterate on flightPtrCount
NB. }}

NB. List Flights
getClientFlightInfo =. {{
'clientPtr criteria' =. y 	NB. '' is default
e=. initError ''
critPtr =. setString criteria
bytePtr =. ptr g_bytes_new critPtr; # criteria
callOptPtr =. ptr gaflight_call_options_new ''
criteriaPtr =. ptr  gaflight_criteria_new < bytePtr
infoListPtr =. ptr gaflight_client_list_flights clientPtr;criteriaPtr;callOptPtr;<e
checkError e
flightPtrCount =. ret g_list_length < infoListPtr
infoPtrs =. (ptr@g_list_nth_data)"1 (<infoListPtr),.  <"0 i.flightPtrCount NB. Turn this into a function, interate on flightPtrCount
}}"1


endPointsFlightstreamReader =. {{
'clientPtr endpointPtr' =. y
callOptPtr =. ptr gaflight_call_options_new ''
NB. flightStreamReaderPtrs =. getEndpointReader"1  clientPtr ;"0 1 (; getTicket each endpointPtrs) ;"0 0 <callOptPtr
ticketPtr =. ptr  getTicket endpointPtr
flightStreamReaderPtr =. getEndpointReader clientPtr; ticketPtr ; <callOptPtr
flightStreamReaderPtr 
}}

recordBatchTable =: {{
rbPtrs =. y
schemaPtr =. ptr garrow_record_batch_get_schema < {. rbPtrs
rbList =.  setInts > > {. rbPtrs
recordBatchCount =. # > {. rbPtrs
e=. <mema 4
tablePtr =. ptr garrow_table_new_record_batches schemaPtr;rbList;recordBatchCount;<e
tablePtr
}}

NB. =========================================================
NB. Demo flight client
NB. 
NB. Each client contains a list of flightInfo.
NB. Each flightinfo contains a ticket and list of endpoints.
NB.
NB. We get a list of flightInfo from a client, select one 'info' and one endpoint associated with that info.
NB. With a client and an endpoint, we can retrieve either a list of recordbatches or a table.
NB. =========================================================

clientPtr =. createClient@connectLocation 'grpc+tcp://localhost:5005'
flightInfoPtrs =. getClientFlightInfo clientPtr; 'example string'   NB. This could be filtered with search criteria.
flightInfo flightInfoPtrs
endpointPtrs =. <@getEndpoints flightInfoPtrs

NB. Select  first info and first endpoint for that info.
endpointPtr =. 0 { 0{:: endpointPtrs

NB. Create an endpointFlightReader for each endpoint and a table for each flightstreamreader
tblPtr1 =. flightStreamReadAllTable endPointsFlightstreamReader clientPtr;<endpointPtr

NB. Or create recordbatch pointers and then create tables pointers.
tblPtr2 =.  recordBatchTable flightStreamRecordBatch endPointsFlightstreamReader clientPtr;<endpointPtr

flightInfo 0{ infoPtr
readsTable tblPtrs1
readTableSchema tblPtr1
readTableSchema tblPtr2

readCol tblPtr1; 15
readCol tblPtr2; 13

NB. =========================================================

0 : 0
healthcheck

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

gaflight_stream_chunk_get_metadata

gaflight_data_stream_get_type
gaflight_servable_get_type
gaflight_record_batch_stream_get_type
)

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