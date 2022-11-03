
NB. =========================================================
NB. Arrow flight
NB. python3 flightclient.py list localhost:5005
NB. python3 flightclient.py put localhost:5005 iGd220525.csv
NB. python3 flightclient.py do localhost:5005 shutdown

NB. A list of flights is a list of pointers to 'info'
flightInfoList =:{{
infoListPtr =. y
flightPtrCount =. ret g_list_length < infoListPtr
infoPtrs =.( ptr@g_list_nth_data)"1 (<infoListPtr),.  <"0 i.flightPtrCount NB. Turn this into a function, interate on flightPtrCount
}}

flightInfo =: {{
'infoPtr' =. y 
desPtr =. ptr gaflight_info_get_descriptor < infoPtr
desCharPtr =. ptr gaflight_descriptor_to_string < desPtr
description =. getString desCharPtr
recordcount =. ret gaflight_info_get_total_records < infoPtr
byteCount =.  ret gaflight_info_get_total_bytes < infoPtr
readOptionsPtr =. makeReadOptions''
e=. < mema 4
schema =. getString ret ptr garrow_schema_to_string <  ptr gaflight_info_get_schema infoPtr;readOptionsPtr;<e
res =. >a:
res=. res, 'Flight Info:'
res=. res, '[+] Desscription: ',description,LF,'[+] Record count: ',(": recordcount)
res=. res, '[+] Byte count: ',(": byteCount),LF
res=. res, '[+] Schema : ', schema, LF
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
< endpointPtrs
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
e=. < mema 4
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
'Not a valid flightstream chunk pointer.' assert *  > fsChunkPtr
NB. ptr gaflight_stream_chunk_get_metadata	< fsChunkPtr
fsChunkPtr =. ptr gaflight_record_batch_reader_read_next FSReaderPtr;<<e
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
e=. mema 4
getString  ptr garrow_record_batch_to_string recordBatchPtr;<<e
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

NB. List Flights
getClientFlights =.  {{
'clientPtr criteria' =. y 	NB. '' is default
e=. mema 4 
critPtr =. setString criteria
bytePtr =. ptr g_bytes_new critPtr; # criteria
callOptPtr =. ptr gaflight_call_options_new ''
criteriaPtr =. ptr  gaflight_criteria_new < bytePtr
flightListPtr =. ptr gaflight_client_list_flights clientPtr;criteriaPtr;callOptPtr;<<e
flightListPtr
}}"1


endPointsFlightstreamReader =. {{
endpointPtr =. y
callOptPtr =. ptr gaflight_call_options_new ''
NB. flightStreamReaderPtrs =. getEndpointReader"1  clientPtr ;"0 1 (; getTicket each endpointPtrs) ;"0 0 <callOptPtr
flightStreamReaderPtr =. getEndpointReader"1  clientPtr; (getTicket endpointPtr) ; <callOptPtr
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
NB. =========================================================

clientPtr =. createClient@connectLocation 'grpc+tcp://localhost:5005'
flightListPtr =. getClientFlights clientPtr;''
infoPtr =. flightInfoList flightListPtr
flightInfo"0  infoPtr

NB. Each connection has a list of potential endpoints.
endpointPtrs =. getEndpoints infoPtr NB. Each info pointer has multiple potential endpoints


NB. =========================================================
NB. Once you return an endpoint you can return either individual recordbatches or the entire table.
NB. =========================================================

NB. Create an endpointFlightReader for each endpoint and a table for each flightstreamreader
tblPtrs1 =. {. each flightStreamReadAllTable@{. each endPointsFlightstreamReader@{.  each endpointPtrs

NB. Or create recordbatch pointers and then create tables pointers.
tblPtrs2 =.  recordBatchTable each flightStreamRecordBatch each endPointsFlightstreamReader@{. each endpointPtrs

flightInfo 0{ infoPtr
readsTable 0{:: tblPtrs1
,.  readTableSchema each tblPtrs1
,.  readTableSchema each tblPtrs2
readCol (0{::tblPtrs1); 0
readsTable 0{:: tblPtrs1

NB. =========================================================

0 : 0
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