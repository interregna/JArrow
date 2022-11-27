
NB. =========================================================
NB. Tests
y=. '~/Downloads/scrabble_games.arrows'
res=. recordBatchStreamReader y
recordBatchStreamReader y
(1e3) 6!:2 '$ > recordBatchStreamReader y'


y=. '~/Downloads/example.arrows'
tp=. fileInputStreamTable y
NB. $ each readsTable tp
removeObject tp
(1e3) 6!:2 'removeObject fileInputStreamTable y'

test2=.{{
y=. '~/Downloads/example.arrows' NB. Something about this file is causing memory leaks.
bis=. byteInputStream fread y
tp=. recordBatchStreamReaderTable bis
NB. $ each readsTable tp
removeObject bis
removeObject tp
}}

(1e3) 6!:2 'test2 0'

$ each readsTable tp =. fileInputStreamTable y
removeObject tp
bis=. byteInputStream (fread jpath y)
$ each readsTable tp=. recordBatchStreamReaderTable bis
removeObject bis
removeObject tp
(1e3) 6!:2 'removeObject fileInputStreamTable y'
(1e3) 6!:2 'removeObject byteInputStream (fread jpath y)'




NB. =========================================================
NB. File IPC to recordbatch to table test

arrowFP=. '~/Downloads/example_recordbatch.arrow' NB. works, created with garrow_record_batch_writer_write_record_batch
$ each readsTable recordBatchTable recordBatchFileReader arrowFP

arrowFP=. '~/Downloads/example_table.arrow' NB. works, created with garrow_record_batch_writer_write_table
$ each readsTable recordBatchTable recordBatchFileReader arrowFP




load'web/gethttp'
source=. 'https://raw.githubusercontent.com/jpatokal/openflights/master/data/airports.dat'
filename=. jpath '~/Downloads/airports.csv'
filename fwrite~ 'ID,Name,City,Country,IATA,ICAO,Latitude,Longitude,Altitude,Timezone,DST,TZ,Type,Source',LF
filename fappend~ gethttp source
readsCSVTable filename

filename=. jpath '~/Downloads/barley.json'
filename fwrite~ (('},',LF);('}',LF))&(rplc~) }:@}. gethttp quote 'https://cdn.jsdelivr.net/npm/vega-datasets@2.5.2/data/barley.json' NB. Make this into a json-line file.
readsTable readJson filename

source=. 'https://cdn.jsdelivr.net/npm/vega-datasets@2.5.2/data/flights-200k.arrow'
filename=. '~/Downloads/flights-200k.arrows' NB. This is a typo on Vega's end, it's an 'arrows' file, not an arrow file.
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
filename=. '~/Downloads/superstore.arrow'
filename fwrite~ gethttp source
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
arrowFP=. '~/Downloads/example_table.arrow'
writeTableFile arrowFP;0;< tblPtr1

NB. Write into an arrow file
NB. Write with: garrow_record_batch_writer_write_record_batch
arrowFP=. '~/Downloads/example_recordbatch.arrow'
writeRecordBatchFile arrowFP;0;(< recordBatchPtrs) NB. Only writes the first recordbatch for now.

NB. Write into an arrows stream
NB. Write with: garrow_output_stream_write_record_batch
arrowFP=. '~/Downloads/example.arrows'
writeRecordBatchStream arrowFP;0;(<recordBatchPtrs)