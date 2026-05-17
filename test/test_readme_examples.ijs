NB. Smoke test for documented README examples and writers.

NB. Resolve paths relative to this script via the J load stack.  Works
NB. both as a standalone addon install (~addons/data/arrow/test/...)
NB. and from a development clone (anywhere on disk).  Override loadfile
NB. with JARROW_TEST_LOADFILE for tests that want a non-default arrow.ijs.
TEST_DIR=: 3 : 0
  me =. > {: 4!:3 ''
  me {.~ >: me i: '/'
)
TEST_DIR=: TEST_DIR ''
PROJ_DIR=: TEST_DIR {.~ >: _2 { I. TEST_DIR = '/'

selectLoadfile=: 3 : 0
  if. 0 = 4!:0 <'JARROW_TEST_LOADFILE' do.
    JARROW_TEST_LOADFILE
  elseif. 2 < # ARGV do.
    > 2 { ARGV
  else.
    y
  end.
)

loadfile=: selectLoadfile PROJ_DIR, 'arrow/arrow.ijs'
load loadfile
coinsert 'parrow'

check=: 3 : 0
  assert. y
)

eraseIfExists=: 3 : 0
  try.
    ferase y
  catch.
    0
  end.
)

root=: TEST_DIR
tmp=: '/private/tmp/'

NB. README read examples.
pq1=: readParquetTable root,'test1.parquet'
check (,'a') -: (> (0 { ({."1 pq1)))
check (,'b') -: (> (1 { ({."1 pq1)))

pq2=: readsParquetTable root,'test2.parquet'
check (,'Column 1') -: (> (0 { (0 { pq2)))
check (,'StringCol') -: (> (16 { (0 { pq2)))

csv1=: readCSVTable root,'test1.csv'
check (,'ID') -: (> (0 { ({."1 csv1)))
check (,'y') -: (> (1 { ({."1 csv1)))

json1=: readsJsonTable root,'test1.json'
check (,'name') -: (> (0 { (0 { json1)))
check (,'date') -: (> (1 { (0 { json1)))

feather1=: readsFeatherTable root,'test1.feather'
check (,'team') -: (> (0 { (0 { feather1)))
check (,'points') -: (> (2 { (0 { feather1)))

NB. README writer examples.
arrow=: tmp,'jarrow_readme_example.arrow'
arrows=: tmp,'jarrow_readme_example.arrows'
featherOut=: tmp,'jarrow_readme_example.feather'
parquetOut=: tmp,'jarrow_readme_example.parquet'
csvOut=: tmp,'jarrow_readme_example.csv'
jsonlOut=: tmp,'jarrow_readme_example.jsonl'

eraseIfExists arrow
eraseIfExists arrows
eraseIfExists featherOut
eraseIfExists parquetOut
eraseIfExists csvOut
eraseIfExists jsonlOut

tp=: readFeather root,'test1.feather'
names=: readTableNames tp

pointsColumn=: ptr garrow_table_get_column_data tp;2
pointsArray=: ptr garrow_chunked_array_get_chunk pointsColumn;0
pointsSum=: afsum pointsArray
check 'Scalar(94)' -: getString ptr garrow_datum_to_string <pointsSum
removeObject"0 pointsSum, pointsArray, pointsColumn

check 1 -: writeArrowTable tp;arrow
check fexist arrow
arrowTable=: readArrowTable arrow
check names -: readTableNames arrowTable

check 1 -: writeArrowsTable tp;arrows
check fexist arrows
arrowsTable=: readArrowsTable arrows
check names -: readTableNames arrowsTable

check 1 -: writeFeatherTable tp;featherOut
check fexist featherOut
featherTable=: readArrowTable featherOut
check names -: readTableNames featherTable

check 1 -: writeParquet tp;parquetOut
check fexist parquetOut
parquetTable=: readParquetTable parquetOut
check (,'team') -: (> (0 { ({."1 parquetTable)))
check (,'points') -: (> (2 { ({."1 parquetTable)))

check 1 -: tp wcsv csvOut
check fexist csvOut
csvData=: 1!:1 < csvOut
check +./ '"team","pos","points"' E. csvData
check +./ '"A","G",17' E. csvData

check 1 -: tp wjsonl jsonlOut
check fexist jsonlOut
jsonlData=: 1!:1 < jsonlOut
check +./ '{"team":"A","pos":"G","points":17}' E. jsonlData

removeObject"0 tp, arrowTable, arrowsTable, featherTable

smoutput 'JArrow README examples smoke ok'
