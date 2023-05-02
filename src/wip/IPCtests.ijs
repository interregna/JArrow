NB. =========================================================
NB. .arrow file IPC to recordbatch to table test
NB. IPC format for on-disk seekable files (.arrow file), includes footer
NB. Arrow file created with garrow_record_batch_writer_write_record_batch
filename=. '~/Desktop/af/example_recordbatch.arrow' NB. works, created with garrow_record_batch_writer_write_record_batch
readTable tp=. recordBatchTable {. readFileRecordBatches filename
printTableSchema tp
removeObject tp

NB. Arrow file created with garrow_record_batch_writer_write_table
filename=. '~/Desktop/af/example_table.arrow' NB. works, created with garrow_record_batch_writer_write_table
readsTable tp=. recordBatchTable {. readFileRecordBatches filename
printTableSchema tp
removeObject tp

filename=. '~/Desktop/af/airports.arrow'
readsTable tp=. recordBatchTable {. readFileRecordBatches filename
printTableSchema tp
removeObject tp

filename=. '~/Desktop/af/barley.arrow'
readsTable tp=. recordBatchTable {. readFileRecordBatches filename
printTableSchema tp
removeObject tp

load'web/gethttp'
NB. =========================================================
NB. .arrows file IPC to recordbatch to table test
NB. IPC format for on-disk streams (.arrows file), excludes footer
source=. 'https://cdn.jsdelivr.net/npm/vega-datasets@2.5.2/data/flights-200k.arrow'
filename=. '~/Desktop/af/flights200k.arrows' NB. This is a typo on Vega's end, it's an 'arrows' file, not an arrow file.
NB. ferase filename
filename fwrite~ gethttp source
NB. Stream IPC to table tests
NB. IPC format for streaming (.arrows file)
readTable tp=. recordBatchTable@readFileStreamRecordBatches filename
readTable tp=. readFileStreamTable filename
printTableSchema tp
removeObject tp

NB. superstore
source=. 'https://cdn.jsdelivr.net/npm/superstore-arrow/superstore.arrow' 
filename=. jpath '~/Desktop/af/superstores.arrows' NB. Also a typo, should be .arrows (streaming)
ferase filename
(filename) fwrite~ (gethttp source)
readTable tp=. recordBatchTable@readFileStreamRecordBatches filename
readTable tp=. readFileStreamTable filename
printTableSchema tp
removeObject tp

NB. scrabble
filename=. '~/Desktop/af/scrabble.arrows'
fexist (jpath filename)
readTable tp=. recordBatchTable@readFileStreamRecordBatches filename
readTable tp=. readFileStreamTable filename
printTableSchema tp
removeObject tp

NB. credit
filename=. '~/Desktop/af/example.arrows'
fexist (jpath filename)
readTable tp=. recordBatchTable@readFileStreamRecordBatches filename
readTable tp=. readFileStreamTable filename
printTableSchema tp
removeObject tp


NB. =========================================================
NB. CSV in to table and out to .arrow
source=. 'https://raw.githubusercontent.com/jpatokal/openflights/master/data/airports.dat'
filename=. jpath '~/Desktop/af/airports.csv'
fexist filename
ferase filename
filename fwrite~ 'ID,Name,City,Country,IATA,ICAO,Latitude,Longitude,Altitude,Timezone,DST,TZ,Type,Source',LF
filename fappend~ gethttp source
readsCSVTable filename
writeTableFile (jpath '~/Desktop/af/airports.arrow') ;0; < tp=. readCSV filename
printTableSchema tp
removeObject tp


NB. Json in to table and out to .arrow
filename=. jpath '~/Desktop/af/barley.json'
filename fwrite~ (('},',LF);('}',LF))&(rplc~) }:@}. gethttp quote 'https://cdn.jsdelivr.net/npm/vega-datasets@2.5.2/data/barley.json' NB. Make this into a json-line file.
readsJsonTable filename
readsTable readJson filename
writeTableFile (jpath '~/Desktop/af/barley.arrow') ;0; < tp=. readJson filename
printTableSchema tp
removeObject tp


NB. * * u * * g_input_stream_read_bytes (GInputStream *stream,gsize count,GCancellable *cancellable, GError **error);GBytes *
NB. * * g_input_stream_clear_pending (GInputStream *stream);void



NB. =========================================================
NB. Test writing with several methods:
NB. =========================================================

clientPtr=. createClient@connectLocation 'grpc+tcp://localhost:5005'
flightInfoPtrs=. getClientFlightInfo clientPtr; ''   NB. This could be filtered with search criteria.
flightInfo flightInfoPtrs
endpointPtrs=. <@getEndpoints flightInfoPtrs

NB. Select  first flightInfo (e.g. ticket) and first endpoint for that flightInfo. These methaphors are painful.
endpointPtr=. 0 { 0{:: endpointPtrs

NB. Get table pointers:
tblPtr1=. flightStreamReadAllTable endPointsFlightstreamReader clientPtr;<endpointPtr
$ each readsTable tblPtr1

NB. Get recordbatch  pointers:
recordBatchPtrs=. flightStreamRecordBatch endPointsFlightstreamReader clientPtr;<endpointPtr
# recordBatchPtrs

NB. Write into an arrow file
NB. Write with: garrow_record_batch_writer_write_table
arrowFP=. '~/Desktop/af/example_table.arrow'
writeTableFile arrowFP;0;< tblPtr1

NB. Write into an arrow file
NB. Write with: garrow_record_batch_writer_write_record_batch
arrowFP=. '~/Desktop/af/example_recordbatch.arrow'
writeRecordBatchFile arrowFP;0;(< recordBatchPtrs) NB. Only writes the first recordbatch for now.

NB. Write into an arrows stream
NB. Write with: garrow_output_stream_write_record_batch
arrowFP=. '~/Desktop/af/example.arrows'
writeRecordBatchStream arrowFP;0;(<recordBatchPtrs)

