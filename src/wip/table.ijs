tablesGetSchema=: (ptr@garrow_table_get_schema@<@<)&.>
schemas_equal=: (<./)@(ret@(garrow_schema_equal"1)@(({.;<@{.@}.)"1)@(2&(]\)))
tablesEqualMetadata=: (<./)@(ret@(garrow_table_equal_metadata"1)@(({.;{.@}.;1:)"1)@(2&(]\)))
tablesSchemasEqual=: schemas_equal@;@:tablesGetSchema 

NB. readCSVData each 1 {. csvlist
NB. garrow_table_combine_chunks
NB. garrow_table_concatenate
NB. GArrowTable * garrow_table_concatenate (GArrowTable *table, GList *other_tables, GArrowTableConcatenateOptions *options, GError **error);
NB. GArrowTable * garrow_table_slice (GArrowTable *table, gint64 offset, gint64 length);
NB. GArrowTable * garrow_table_combine_chunks (GArrowTable *table, GError **error);

tabConcatOptPtr =. ptr garrow_table_concatenate_options_new ''

setPropertyBoolean tabConcatOptPtr;'unify-schemas';0
setPropertyBoolean tabConcatOptPtr;'promote-nullability';0

getPropertyBoolean  tabConcatOptPtr;'unify-schemas'
getPropertyBoolean  tabConcatOptPtr;'promote-nullability'

NB. =========================================================
csvlist =. 1 dir '/'
tblPrt =. ; readCSV_parrow_ each csvlist
NB. readTable 2 { tblPrt
tablesEqualMetadata tblPrt
tablesSchemasEqual tblPrt

e=. initError ''
first =. ({. tblPrt)
restPtr =. newList }. tblPrt
[ concatPtr =. ptr garrow_table_concatenate first; restPtr; tabConcatOptPtr ; <e
checkError e


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


spt =. getSchemaPt readCSV > 7 { csvlist
readCSVBatch"1 [ 18 {. csvlist,.<spt



$ each readsTable ({. tblPrt)
NB. (<'ENDDATE') i.~ {. readsTable concatPtr
NB. ~. 1 41 {::  readsTable concatPtr
NB. readTable ptr garrow_table_slice (({. tblPrt);3;10)