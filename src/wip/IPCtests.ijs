load'web/gethttp'
source=. 'https://cdn.jsdelivr.net/npm/vega-datasets@2.5.2/data/flights-200k.arrow'
filename=. '~/Documents/flights200k.arrows' NB. This is a typo on Vega's end, it's an 'arrows' file, not an arrow file.
filename fwrite~ gethttp source
NB. Stream IPC to table tests
$ each readsTable tp=. fileInputStreamTable filename

readArrowTable
readIPCTable

NB. IPC format for streaming, but from a file on disk (.arrows file)
readFileBufferTable=. readArrowsTable=. readIPCFileStreamTable=. fileInputStreamTable

NB. =========================================================
NB. File IPC to recordbatch to table test

arrowFP=. '~/Documents/example_recordbatch.arrow' NB. works, created with garrow_record_batch_writer_write_record_batch
$ each readsTable recordBatchTable recordBatchFileReader arrowFP

arrowFP=. '~/Documents/example_table.arrow' NB. works, created with garrow_record_batch_writer_write_table
$ each readsTable recordBatchTable recordBatchFileReader arrowFP




load'web/gethttp'
source=. 'https://raw.githubusercontent.com/jpatokal/openflights/master/data/airports.dat'
filename=. jpath '~/Documents/airports.csv'
fexist filename
ferase filename
filename fwrite~ 'ID,Name,City,Country,IATA,ICAO,Latitude,Longitude,Altitude,Timezone,DST,TZ,Type,Source',LF
filename fappend~ gethttp source
readsCSVTable filename

filename=. jpath '~/Documents/barley.json'
filename fwrite~ (('},',LF);('}',LF))&(rplc~) }:@}. gethttp quote 'https://cdn.jsdelivr.net/npm/vega-datasets@2.5.2/data/barley.json' NB. Make this into a json-line file.
readsTable readJson filename

source=. 'https://cdn.jsdelivr.net/npm/vega-datasets@2.5.2/data/flights-200k.arrow'
filename=. jpath '~/Documents/flights200k.arrows' NB. This is a typo on Vega's end, it's an 'arrows' file, not an arrow file.
ferase filename
filename fwrite~ gethttp source
NB. Stream IPC to table tests
$ each readsTable tp=. fileInputStreamTable filename
printTableSchema tp
removeObject tp

bis=. byteInputStream (fread jpath filename)
$ each readsTable tp=. recordBatchStreamReaderTable bis
removeObject bis
removeObject tp

recordBatchStreamReader filename

tp=. fileInputStreamTable filename
printTableSchema tp
readTableSchema tp
readsTable tp
removeObject tp


source=. 'https://cdn.jsdelivr.net/npm/superstore-arrow/superstore.arrow'
filename=. jpath '~/Documents/superstores.arrow'
ferase filename
(filename) fwrite~ (gethttp source)
$ each readsTable tp=. fileInputStreamTable filename
printTableSchema tp
removeObject tp
bis=. byteInputStream (fread jpath filename)
$ each readsTable tp=. recordBatchStreamReaderTable bis
removeObject bis
removeObject tp
$ each > recordBatchStreamReader filename

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
arrowFP=. '~/Documents/example_table.arrow'
writeTableFile arrowFP;0;< tblPtr1

NB. Write into an arrow file
NB. Write with: garrow_record_batch_writer_write_record_batch
arrowFP=. '~/Documents/example_recordbatch.arrow'
writeRecordBatchFile arrowFP;0;(< recordBatchPtrs) NB. Only writes the first recordbatch for now.

NB. Write into an arrows stream
NB. Write with: garrow_output_stream_write_record_batch
arrowFP=. '~/Documents/example.arrows'
writeRecordBatchStream arrowFP;0;(<recordBatchPtrs)





garrow_record_batch_reader_export (GArrowRecordBatchReader *reader, GError **error); NB. gpointer





NB. =========================================================

NB. =========================================================
NB. Tests
filename=. '~/Documents/scrabble_games.arrows'
fexist (jpath filename)
res=. recordBatchStreamReader filename NB. uses garrow_record_batch_reader_read_next
(1e2) 6!:2 '$ > recordBatchStreamReader filename'

filename=. '~/Documents/example.arrows'
tp=. fileInputStreamTable filename  NB. uses garrow_record_batch_reader_read_all
readsTable tp
removeObject tp
(1e3) 6!:2 'removeObject fileInputStreamTable filename'

filename=. jpath '~/Documents/example.arrows'
bis=. byteInputStream fread filename
tp=. recordBatchStreamReaderTable bis NB. uses garrow_record_batch_reader_read_all
readsTable tp
removeObject bis
removeObject tp

NB. fileInputStreamTable -> fileInputStream
NB. bufferInputStreamPtr -> inputStreamTable

(1e3) 6!:2 'test2 0'

$ each readsTable tp =. fileInputStreamTable y
removeObject tp
bis=. byteInputStream (fread jpath y)
$ each readsTable tp=. recordBatchStreamReaderTable bis
removeObject bis
removeObject tp
(1e3) 6!:2 'removeObject fileInputStreamTable y'
(1e3) 6!:2 'removeObject byteInputStream (fread jpath y)'
