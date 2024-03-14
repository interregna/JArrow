syspools =. (8&T.)@(''&[)
delpools =. ([(55&T.))^:(1&T.)@(''&[) 					NB. pool clear: 	 delpools y clears all worker threads and pools
getpools =. ((2&T.)"0)@i. 							NB. pool stats:       'getpools 6' means get stats on first six pools
setpools =. getpools@((#@;)"_)@:({{([(0&T.))^:({: y) ({.y)}}"1)@(,.~(i.@#))@([delpools)	NB. pool threadcount: 'setpools 0 2 2 3' creates 0 threads in pool 0, 2 thread in pool 1, 2 threads in pool 2, 3 threads in pool 3.



syspools''
getpools''
setpools 26

0&T.@'' ::] ^:_'' NB.eat all the cores
NPAR=. 1 T.''
peach0=: >@: ((t.'')"_1)
peach1=: {{ > ([: u {&y) t.''"_1 i.#y }}


tablesGetSchema=: (ptr@garrow_table_get_schema@<@<)&.>
schemas_equal=: (<./)@(ret@(garrow_schema_equal"1)@(({.;<@{.@}.)"1)@(2&(]\)))
tablesEqualMetadata=: (<./)@(ret@(garrow_table_equal_metadata"1)@(({.;{.@}.;1:)"1)@(2&(]\)))
tablesSchemasEqual=: schemas_equal@;@:tablesGetSchema 
filesbydate =. (((\:)@:((1&{)"1))@(2&dir) { (1&dir))

NB. readCSVData each 1 {. csvlist
NB. garrow_table_combine_chunks
NB. garrow_table_concatenate
NB. GArrowTable * garrow_table_concatenate (GArrowTable *table, GList *other_tables, GArrowTableConcatenateOptions *options, GError **error);
NB. GArrowTable * garrow_table_slice (GArrowTable *table, gint64 offset, gint64 length);
NB. GArrowTable * garrow_table_combine_chunks (GArrowTable *table, GError **error);

tabConcatOptPtr =. ptr garrow_table_concatenate_options_new ''

setPropertyBoolean tabConcatOptPtr;'unify-schemas';0
setPropertyBoolean tabConcatOptPtr;'promote-nullability';1

NB. getPropertyBoolean  tabConcatOptPtr;'unify-schemas'
NB. getPropertyBoolean  tabConcatOptPtr;'promote-nullability'

NB. =========================================================
NB. csvlist =. filesbydate '/Volumes/flotta/scapa/data/JPM/csv/iGd*.csv'
csvlist =. 1 dir '/Users/johnference/Downloads/csv/iGd*.csv'


6!:2 'tblPrt =. ; (readCSV_parrow_@:>)"0 t. (0) csvlist' NB. Parallel read individual csvs

readCSV_parrow_  csvlist


NB. readTable 2 { tblPrt
tablesEqualMetadata tblPrt
tablesSchemasEqual tblPrt


readCSVBatch=: {{
'filepath schemaPtr'=. y
filenamePtr=. setString (jpath filepath)
e=. initError ''
fInputStreamPtr=. ptr garrow_file_input_stream_new filenamePtr;<e
checkError e
'Check file exists and permissions.' assert * > fInputStreamPtr
readOptionPtr=. ptr garrow_csv_read_options_new ''
garrow_csv_read_options_add_schema readOptionPtr;<schemaPtr
e=. initError ''
csvReaderPtr=. ptr garrow_csv_reader_new (fInputStreamPtr);(readOptionPtr);<e
checkError e
e=. initError ''
tablePtr=. ptr garrow_csv_reader_read csvReaderPtr;<e
checkError e
removeObject"0 csvReaderPtr,readOptionPtr,fInputStreamPtr
memf > filenamePtr
tablePtr
}}

printCSVSchema > 7 { csvlist
schemaPtr =. scheemaReadFile '/Volumes/flotta/scapa/data/JPM/arrow/CHHY.arrowschema'
NB. > (<@(;@{., TAB&,@;@}. ))"1 |: readCSVSchema > 7 { csvlist
tablePts =. readCSVBatch"1 [ csvlist,.<schemaPtr


readTable ptr garrow_table_slice (({. tblPrt);3;10)


e=. initError ''
first =. ({. tablePts)
restPtr =. newList }. tablePts
[ concatPtr =. ptr garrow_table_concatenate first; restPtr; tabConcatOptPtr ; <e
checkError e




$ each readsTable concatPtr
readTableColName concatPtr;0
readTableSchema concatPtr
printTableSchema concatPtr
tableNRows concatPtr
tableNCols concatPtr


removeObject"0 tablePts 
removeObject"0 tp


<./ 1 {:: {. readCol concatPtr;60

(+/%#) (1 {:: {. readCol concatPtr;55) - (1 {:: {. readCol concatPtr;54)

(+/%#)  (1 {:: {. readCol concatPtr;70)
(+/%#)  (1 {:: {. readCol concatPtr;71)
(+/%#)  (1 {:: {. readCol concatPtr;72)
(+/%#)  (1 {:: {. readCol concatPtr;73)




readsTable ptr garrow_table_slice concatPtr;2e7;400

NB. (<'ENDDATE') i.~ {. readsTable concatPtr
NB. ~. 1 41 {::  readsTable concatPtr
NB. 