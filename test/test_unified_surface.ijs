NB. Smoke test for the Unified public JArrow surface.

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

mustverb=: 3 : 0
  assert. 3 = 4!:0 < y
)

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

mustverb each ;: 'readArrowTable readArrowsTable recordBatchStreamReader writeArrowTable writeArrowsTable writeFeatherTable wcsv wjsonl ho hs hr hp hc sbo sbn sbc'

feather=: TEST_DIR, 'test1.feather'
arrow=: '/private/tmp/jarrow_unified_surface.arrow'
arrows=: '/private/tmp/jarrow_unified_surface.arrows'
csv=: '/private/tmp/jarrow_unified_surface.csv'
jsonl=: '/private/tmp/jarrow_unified_surface.jsonl'

h=: ho feather
check 0 < # hs h
check 0 < # hr h
check 1 = # 'points' hp h
hc h

tp=: readFeather feather
names=: readTableNames tp

eraseIfExists arrow
eraseIfExists arrows
eraseIfExists csv
eraseIfExists jsonl
check 1 -: writeArrowTable tp;arrow
check fexist arrow
arrowTable=: readArrowTable arrow
check names -: readTableNames arrowTable

check 1 -: writeArrowsTable tp;arrows
check fexist arrows

streamTable=: readArrowsTable arrows
check names -: readTableNames streamTable
streamRows=: recordBatchStreamReader arrows
check names -: {."1 streamRows

check 1 -: tp wcsv csv
check fexist csv
csvData=: 1!:1 < csv
check +./ '"team","pos","points"' E. csvData
check +./ '"A","G",17' E. csvData

check 1 -: tp wjsonl jsonl
check fexist jsonl
jsonlData=: 1!:1 < jsonl
check 0 < # jsonlData
check +./ '{"team":"A","pos":"G","points":17}' E. jsonlData

sh=: ho arrows
check names -: {."1 hr sh
hc sh

sb=: sbo arrows
batch=: sbn sb
check 0 -.@-: batch
sbc sb

removeObject"0 tp, arrowTable, streamTable

smoutput 'JArrow unified surface smoke ok'
