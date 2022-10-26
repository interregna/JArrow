NB. =========================================================
NB. Example of gettting a property:
NB. Also works with set
NB. =========================================================
pnp1=. writeString 'approx'
'"/usr/local/lib/libarrow-glib.dylib" g_object_set * * * b *'&cd  eaP;pnp1;1;<<0

bp =. mema 8
'"/usr/local/lib/libarrow-glib.dylib" g_object_get * * * * *'&cd  eaP;pnp1;(<bp);<<0
memr bp,0,1,4

pnp2=. writeString 'nans-equal'
p2p =. mema 8
'"/usr/local/lib/libarrow-glib.dylib" g_object_get * * * * *'&cd  eaP;pnp2;(<p2p);<<0
1 readInts p2p

'"/usr/local/lib/libarrow-glib.dylib" g_object_set * * * b *'&cd  eaP;pnp2;1;<<0
'"/usr/local/lib/libarrow-glib.dylib" g_object_get * * * * *'&cd  eaP;pnp2;(<p2p);<<0
1 readInts p2p

ticketlist =. ' (1, None, (b''iGd220525.csv'',))'
ticketListPtr=. writeString ticketlist
len =. # ticketlist
bytePtr =. ptr '"/usr/local/lib/libarrow-flight-glib.dylib" g_bytes_new * * i'&cd (ticketListPtr);len
ticketPtr =. ptr gaflight_ticket_new < bytePtr

NB. New byte pointer
ticketlist2 =. 'WRONG THING'
ticketListPtr2=. writeString ticketlist2
len2 =. # ticketlist2
bytePtr2 =. ptr '"/usr/local/lib/libarrow-flight-glib.dylib" g_bytes_new * * i'&cd (ticketListPtr2);len2

NB. Get property 
tnp=. writeString 'data'
'"/usr/local/lib/libarrow-glib.dylib" g_object_get n * * * *'&cd  ticketPtr;tnp;bytePtr2;<<0
bplen2 =. writeInts ret '"/usr/local/lib/libarrow-glib.dylib" g_bytes_get_size * *'&cd < bytePtr2
dataPtr2 =. ptr '"/usr/local/lib/libarrow-glib.dylib" g_bytes_get_data * * *'&cd bytePtr2;<bplen2
memr (memr (>dataPtr2),0,1,4),0,_1,2
NB. =========================================================

pqf =. '~/movies_201k.parquet'
fexist pqf
fsize pqf
schema readParquet pqf
readsTable readParquet pqf

NB. =========================================================
NB. Parquet columns direct to nouns
NB. This should write into mutable buffers only, this will crash, won't work currently.

load'jmf'
require'jmf'

viewnoun=: {{
s=. symget <y               NB. pointer to symbol table entry
sys=. memr s,0 2 4          NB. pointers to name, header
h=. 1{sys                   NB. header pointer
assert h = 15!:12 <y        NB. J 9.04
fheader=. memr h,0 7 4      NB. fixed header
'offset flag size type refcount len misc'=. fheader
rank =. 16b3f (17 b.) misc
shape=. memr h,56,rank,4    NB. shape
assert (h+offset) = 15!:14 <y  NB. J 9.04
data=. memr (h+offset),0,len,type
sys;fheader;shape;data
}}

t2path =. TempPath,'/test2.parquet'
tp2 =. readParquet t2path
'tablePointer colIndex' =. tp2;15
ncols =. tableNCols tablePointer
'Index is greater than number of columns. Note columns are zero-indexed.' assert colIndex < ncols
chunkedArrayPointers =. <"0 ptr"1 garrow_table_get_column_data (< tablePointer), < colIndex
NB. > readChunks each chunkedArrayPointers

chunkedArrayPointer =. 0{:: chunkedArrayPointers
nChunks =. 0&{::@garrow_chunked_array_get_n_chunks < chunkedArrayPointer
arrayPointers =. readChunk each <"1 (<chunkedArrayPointer),.(<"0 i. nChunks)

arrayPointer =. 0{::arrayPointers
indexType =. readArrayTypeIndex arrayPointer
arrayType =. readArrayType arrayPointer
length =. readArrayLength arrayPointer

getValueFunc =. typeGetValue&typeIndexLookup indexType NB. lookup functions
fRun =. getValueFunc,', arrayPointer;<'
results =. ; 0&{::@". each (fRun&,)@": each <"0 i.length

indexType =. readArrayTypeIndex arrayPointer
arrayType =. readArrayType arrayPointer
length =. readArrayLength arrayPointer
NB. if. -. arrayType = 'string' do.

width =. readArrayBitWidth arrayPointer
writeArrayLength=.{{<lengthPt [ length memw (] lengthPt =. mema 1),0,1,4 [ length =. y}}
lengthPointer =. writeArrayLength length

getValuesFunc =. typeGetValues&typeIndexLookup indexType NB. lookup functions
arrayValuesPointer =.  ptr ". getValuesFunc,', arrayPointer;<lengthPointer'

Jtype =.  ". typeJMemr&typeIndexLookup indexType
results2 =. memr (d2=. 0{::arrayValuesPointer),0,length,Jtype


h2=: allochdr_jmf_ 40
memsize =. 4 NB. unsure why
shape =. length
d2=. (0{::arrayValuesPointer)
hdr2=: (d2-h2),0,(length*memsize),Jtype,1,length,1,shape NB. shape will be different for tensors
hdr2 memw h2,0,(#hdr2), 4 NB. Write header
results3=. (15!:7) h2
results3

viewnoun 'results3'


NB. =========================================================
NB. IPC

memf >>e

NB. CSV options ...
'"/usr/local/lib/libarrow-glib.dylib" garrow_csv_read_options_set_column_names n * * i'&cd 
(< ptr rdOptPt),(<< setString 'col1'),< 1
NB. cd errors
cder'' 
cderx''
'"/usr/local/lib/libarrow-glib.dylib" garrow_csv_read_options_add_column_name n * *'&cd  rdOptPt;<<setString 'colname'

garrow_csv_reader_new
garrow_csv_reader_read

readCSV =: {{
'USE_THREADS';'BLOCK_SIZE';'N_SKIP_ROWS';'DELIMITER';'IS_QUOTED';'QUOTE_CHARACTER';' IS_DOUBLE_QUOTED';'IS_ESCAPED';'ESCAPE_CHARACTER';'ALLOW_NEWLINES_IN_VALUES';'IGNORE_EMPTY_LINES';'CHECK_UTF8';'ALLOW_NULL_STRINGS';'GENERATE_COLUMN_NAMES'
}}


NB. =========================================================
NB. Arrow 'IPC format' test

f1 =. jpath '~temp/test1.jsonl'
f2 =. jpath '~temp/test2.jsonl'
f3 =. jpath '~temp/test3.jsonl'

". each 'readJsonlSchema f'&,@": each <"0 >: i.3
readJsonlSchema f0
printJsonlSchema f0


readArrow=: {{
NB. Properties
NB. gint	max-recursion-depth	Read / Write
NB. gboolean	use-threads	Read / Write
NB. gint	alignment	Read / Write
NB. gboolean	allow-64bit	Read / Write
NB. GArrowCodec *	codec	Read / Write
NB. gint	max-recursion-depth	Read / Write
NB. gboolean	use-threads	Read / Write
NB. gboolean	write-legacy-ipc-format	Read / Write
'filepath'=. y
'File does not exist or is not permissioned for read.' assert fexist (jpath filepath)
filenamePtr=. setString (jpath filepath)
e=. < mema 4
fInputStreamPtr=. ptr garrow_file_input_stream_new filenamePtr;<e
'Check file exists and available will permissions.' assert * > ptr fInputStreamPtr
arrowReaderPtr=. ptr garrow_feather_file_reader_new fInputStreamPtr;<e
'Null pointer error' assert > arrowReaderPtr
tablePtr=. ptr garrow_feather_file_reader_read arrowReaderPtr;<e
tablePtr
}}

load'web/gethttp'
fp =. jpath '~/Downloads/scrabble.arrow'
fp fwrite~ gethttp 'https://gist.githubusercontent.com/TheNeuralBit/64d8cc13050c9b5743281dcf66059de5/raw/c146baf28a8e78cfe982c6ab5015207c4cbd84e3/scrabble.arrow'
fexist fp
y =. fp
readArrow 


NB. =========================================================
NB. Writing 
writeRecordBatch=: {{
'tablePtr filepath'=. y
e=. < mema 4
fnPtr=. setString filepath
fileOutputStreamrPtr=. ptr garrow_file_output_stream_new fnPtr;0;<e
garrow_output_stream_align fileOutputStreamrPtr;64;;<e

garrow_output_stream_write_record_batch
...
}}



jpath '~JPackageDev/jarrow/test'


NB. =========================================================
NB. Example for reqading and writing parquet
inpath =. TempPath,'test1.parquet'
outpath =. TempPath,'out3.parquet'
schema tablePtr =. readParquet inpath
writeParquet tablePtr;outpath
readsTable readParquet outpath


NB. =========================================================
NB. Test for memory mapping
e=. << mema 4
fnPtr =. setString TempPath,'test.arrow'
fosPtr =. garrow_file_output_stream_new (<fnPtr);1;e
ptr fosPtr
NB. Align on metadata prefix:
garrow_output_stream_align (ptr fosPtr);4;e
rbPtr =. garrow_record_batch_new  (GArrowSchema *schema, guint32 n_rows, GList *columns, GError **error) NB. FIX
woPtr =. garrow_write_options_new '' NB. properties https://arrow.apache.org/docs/c_glib/arrow-glib/ipc-options-classes.html#garrow-write-options-new
garrow_output_stream_write_record_batch (ptr fosPtr);(ptr rbPtr);(ptr woPtr);e


NB. https://code.jsoftware.com/wiki/Guides/DLLs/Error_Messages
cder''
cderx''

NB. Work:
'filereader';
 'tensor';

[+] Apache Parquet file format
[+] Apache Arrow IPC record batch file format
[+] Apache Arrow IPC record batch stream format

NB. Consider None mask.
NB. Consider reading all values at once rather than reading each value individually.
NB. Consider reading a set of rows in an array.

cp =. 0{:: garrow_string_array_get_string ap;1
memr cp,0,_1

cp =. 0{:: garrow_string_array_get_string ap;4
 memr cp,0,_1

readArrayType ap
readArrayLength ap
readArrayByteWidth ap
length memw (] lengthPointer =. mema width),0,1,4

garrow_array_get_length <ap
garrow_array_is_valid ap;<5
garrow_array_get_offset <ap
garrow_array_get_n_nulls <ap
garrow_array_get_null_bitmap <ap NB. GArrowBuffer *
$ 0{::garrow_array_is_null ap;<0
garrow_array_get_value_data_type <ap
garrow_array_get_value_type <ap


fptr =. garrow_schema_get_field_by_name sptr;''
garrow_schema_get_field_index sptr;''




t=.(libParquet,gpafrrt) cd (0{r) ; <<e
NB. 0{t is a pointer to the table

0&{::(libParquet,gatgnr) cd <(0{t) NB. number of rows = 8
0&{::(libParquet,gatgnc) cd <(0{t) NB. number of columns = 2

ts =. (libParquet,gatgs) cd <(0{t) NB. schema pointer
chunkedarray =. (libParquet,gatgcd) cd (0{t);1 NB. column 1 data
memr (0{::((libParquet,gacats) cd (0{chunkedarray) ; <<e)),0,_1 NB. Demonstrate reading column 1 data as a string.

nc =. (libParquet,gacagnc) cd <(0{chunkedarray) NB. get number of chunks.
array=. (libParquet,gacagc) cd (0{chunkedarray);0 NB. get array
arraytype =. (libParquet,gaagvdt) cd <(0{array) NB. get array data type
arraylength =. 0{::(libParquet,gaagl) cd <(0{array) NB. get array data length
memr (0{::((libParquet,gdtgn) cd < 0{arraytype)),0,_1 NB. get data type name
(libParquet,gai64agv) cd (0{array);0 NB. get array value in indexed position

l=. mema 8 NB. pointer to int64 for length
arraylength memw l,0,1,4
NB. memr l,0,1,4 NB. read back array length
ap =. (libParquet,gai64agvs) cd (0{array);<<l NB. pointer to array
memr (0{::ap),0,arraylength,4 


NB. =========================================================
NB. more CSV properties testing
NB. =========================================================

garrow_csv_read_options_set_property
lookup 'garrow_csv_read_options_set_property'
GARROW_CSV_READ_OPTIONS


garrow_csv_read_options_add_column_type

(<rdOptPt),

lookup 'garrow_csv_read_options_add_column_name'
garrow_csv_read_options_get_column_names rdOptPt

'"/usr/local/lib/libparquet-glib.dylib"  garrow_csv_read_options_add_column_type n * * *'&cd

(GArrowCSVReadOptions *options, const gchar *column_name)
garrow_csv_read_options_get_column_names
garrow_csv_read_options_init rdOptPt
garrow_csv_reader_dispose '"/usr/local/lib/libparquet-glib.dylib" garrow_csv_read_options_new *'&cd ''

garrow_csv_read_options_set_column_names (<rdOptPt)
garrow_csv_read_options_set_property NB. See above discussion on property settting.
(rdOptPt);1

garrow_csv_reader_new
garrow_csv_read_options_init < (rdOptPt)

garrow_csv_read_options_set_property (rdOptPt);1
garrow_csv_read_options_get_property
garrow_csv_read_options_get_instance_private

'"/usr/local/lib/libparquet-glib.dylib" g_param_spec_pool_new * i'&cd  < 1
'"/usr/local/lib/libparquet-glib.dylib" garrow_csv_read_options_init n *'&cd  <rdOptPt
'"/usr/local/lib/libparquet-glib.dylib" g_param_spec_pool_new * i'&cd  < 1

paramspec =. '"/usr/local/lib/libparquet-glib.dylib" g_param_spec_uint * *c *c *c i i i i'&cd


NB. Test various destructuring options.
a =. 'n-skip-rows'
b =. 'N skip rows'
c =. 'The number of header rows to skip'
d =. '(not including the row of column names, if any)'
AA =. setString each a;b;c;d

paramspec AA,0;1;0;1

read_options.skip_rows,
