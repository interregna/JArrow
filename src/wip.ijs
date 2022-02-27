NB. cder''
NB. cderx''
NB. https://code.jsoftware.com/wiki/Guides/DLLs/Error_Messages

'"/usr/local/lib/libarrow-glib.dylib" GARROW_VERSION_CHECK i i i i'&cd 6;0;0
cder''
cderx''

'"/usr/local/lib/libarrow-glib.dylib" GARROW_VERSION_MAJOR > i'&cd ''
cder''
cderx''

NB. =========================================================
NB. IPC
NB. =========================================================

init ''
lookup =. {{ ((<y) i.~ 1{"1 readerBindings) { readerBindings }}

NB. Example for reading CSV

NB. cmd + F9, F9

e=. << mema 4
fnPtr =. setChar '/test.csv'
fisPtr =. garrow_file_input_stream_new (<fnPtr);e
ptr fisPtr

NB. Example adding column names:
rdOptPt =. garrow_csv_read_options_new ''
NB. '"/usr/local/lib/libarrow-glib.dylib" garrow_csv_read_options_add_column_name n * *'&cd (< ptr rdOptPt ),(<< setChar 'col1')

NB. ptr i32 =. '"/usr/local/lib/libarrow-glib.dylib" garrow_int32_data_type_get_type *'&cd ''
NB. '"/usr/local/lib/libarrow-glib.dylib" garrow_csv_read_options_add_column_type n * * *'&cd (< ptr rdOptPt ),(< setChar 'col1');(< ptr i32)

csvRdrPtr =. garrow_csv_reader_new (ptr fisPtr);(ptr rdOptPt);e
gaTablePtr =. garrow_csv_reader_read (ptr csvRdrPtr);e
readSchemaString ptr gaTablePtr
readSchema ptr gaTablePtr
readColumn (ptr gaTablePtr);0
readDataColumn (ptr gaTablePtr);3

NB. Close file.

memf > ptr csvRdrPtr
memf ptr gaTablePtr

'"/usr/local/lib/libarrow-glib.dylib" garrow_csv_read_options_set_column_names n * * i'&cd 
(< ptr rdOptPt),(<< setChar 'col1'),< 1
cder''
cderx''
'"/usr/local/lib/libarrow-glib.dylib" garrow_csv_read_options_add_column_name n * *'&cd  rdOptPt;<<setChar 'colname'

NB. =========================================================
NB. Test for memory mapping:
e=. << mema 4
fnPtr =. setChar TempPath,'arrow.mmap'
fosPtr =. garrow_file_output_stream_new (<fnPtr);1;e
ptr fosPtr
NB. Align on metadata prefix:
garrow_output_stream_align (ptr fosPtr);4;e
rbPtr =. garrow_record_batch_new
woPtr =. garrow_write_options_new ''
garrow_output_stream_write_record_batch (ptr fosPtr);(ptr rbPtr);(ptr woPtr);e


NB. =========================================================
NB. Test for write parquet
e=. << mema 4
pqtWtrPtr =. gparquet_writer_properties_new ''

t1path =. TempPath,'test1.parquet'
tablePtr =. readParquet t1path
readSchemaString tablePtr

schemaPtr =. getSchemaPt tablePtr
fnPtr =. setChar TempPath,'testout.parquet'
pqtFileWriterPtr =. gparquet_arrow_file_writer_new_path (ptr schemaPtr);(ptr fnPtr);(ptr pqtWtrPtr); e

gparquet_arrow_file_writer_write_table (ptr pqtFileWriterPtr);(ptr tablePtr); 1000; e
gparquet_arrow_file_writer_close (ptr pqtFileWriterPtr); e


NB. =========================================================
NB. Read in written file:
t1path =. TempPath,'testout.parquet'
tp1 =. readParquet t1path
echo readSchemaString tp1
echo readSchema tp1
echo readData tp1
echo readTable tp1
echo readsTable tp1

NB. =========================================================
NB. Test
NB. =========================================================

NB. test.parquet created in python3:


tpath =. jpath '~temp/'
ppath =. tpath,'Jarrow.py'

ppath fwrite~ ('WD';tpath) rplc~ 0 : 0
import pandas as pd, pyarrow
import numpy as np
pd.DataFrame({'a':list(range(0,8)), 'b':list(range(8,0,-1))}).to_parquet('WD/test1.parquet')
pd.DataFrame(
{'Column 1':list(range(0,8)),
'Column Two':list(np.arange(100, 10, -90/8)),
'shortCol':np.array(np.arange(8), dtype=np.short),
'ushortCol':np.array(np.arange(8), dtype=np.ushort),
'intcCol':np.array(np.arange(8), dtype=np.intc),
'uintcCol':np.array(np.arange(100, 10, -90/8), dtype=np.uintc),
'int_Col':np.array(np.arange(100, 21, -79/8), dtype='int_'),
'uintCol':np.array(np.arange(100, 5, -95/8), dtype='uint'),
'int16Col':np.array(np.arange(300, 10, -290/8), dtype='int16'),
'int32Col':np.array(np.arange(500, 50, -450/8), dtype='int32'),
'int64Col':np.array(np.arange(100, 10, -90/8), dtype='int64'),
'uintCol':np.array(np.arange(100, 10, -90/8), dtype=np.uint),
'longlongCol':np.array(np.arange(100, 10, -90/8), dtype=np.longlong),
'ulonglongCol':np.array(np.arange(100, 10, -90/8), dtype=np.ulonglong),
'DoubleCol':np.array(np.arange(100, 10, -90/8), dtype=np.double),
'StringCol':pd.array(['This', ' is', 'some', 'text', None, 'data.', 'Eh','?'], dtype="string"),
'boolCol':np.array([1, 0.5, 0, None, 'a', '', True, False], dtype=bool),
}).to_parquet('WD/test2.parquet')
)



'filereader';
 'tensor';
 'array'; [x]
 'schema'; [x]
 'value'; [x]
 'table'; [x]
  'schema'; [x]
  'chunkedarray'; [x]
    'n chunks';   [x]
    'arrayindex';    
    'array'; [x]
     'arraytype'; [x] 
      'datatype';[x]
       'datatypename'; [x]
      'arraylength'; [x]

[+] Apache Parquet file format
[+] Apache Arrow IPC record batch file format
[+] Apache Arrow IPC record batch stream format

schemaPointer =. getSchemaPointer tp2
getSchemaFields < getSchemaPointer tp2
getSchemaFields
<"0 memr (0{:: ptr garrow_schema_get_fields < schemaPointer),0,fieldCount,4

readDataColumn tp2;<14
readSchema tp2

readDataColumn (tp2);13

tempPath =. jpath '~temp/'
ppath2 =. tempPath,'/test2.parquet'
tp2 =. readParquet ppath2



'tablePointer colIndex' =. (tp2);13
ncols =. tableNCols tablePointer
'Index is greater than number of columns. Note columns are zero-indexed.' assert colIndex < ncols
chunkedArrayPointers =. <"0 ptr"1 garrow_table_get_column_data (< tablePointer), < colIndex
> readChunks each chunkedArrayPointers

chunkedArrayPointer =. 0{:: chunkedArrayPointers
nChunks =. 0&{::@garrow_chunked_array_get_n_chunks < chunkedArrayPointer
arrayPointers =. readChunk each <"1 (<chunkedArrayPointer),.(<"0 i. nChunks)

arrayPointer =. 0{::arrayPointers
indexType =. readArrayTypeIndex arrayPointer
arrayType =. readArrayType arrayPointer
length =. readArrayLength arrayPointer
NB. width =. readArrayBitWidth arrayPointer
lengthPointer =. writeArrayWidth length;width
getValueFunc =. typeGetValue&typeIndexLookup indexType NB. lookup functions
fRun =. getValueFunc,', arrayPointer;<'
results =. ; 0&{::@". each (fRun&,)@": each <"0 i.length
results


indexType =. readArrayTypeIndex arrayPointer
arrayType =. readArrayType arrayPointer
length =. readArrayLength arrayPointer
NB. if. -. arrayType = 'string' do.
width =. readArrayBitWidth arrayPointer NB. "value" data only NB. FIX!!
lengthPointer =. writeArrayWidth length;width

getValuesFunc =. typeGetValues&typeIndexLookup indexType NB. lookup functions
arrayValuesPointer =.  ptr ". getValuesFunc,', arrayPointer;<lengthPointer'
Jtype =.  ". typeJMemr&typeIndexLookup indexType
results =. memr (0{::arrayValuesPointer),0,length,Jtype
results

3&u: 7&u: results

getValueFunc =. typeGetValue&typeIndexLookup indexType NB. lookup functions
frun =. getValueFunc,', arrayPointer;<'
results =. ; 0&{::@". each (frun&,)@": each <"0 i.length
results

'tablePointer' =. y =. tp2
schemaPointer =. getSchemaPointer tablePointer
memr (0{:: ptr garrow_schema_n_fields < schemaPointer),0,_1
}}

garrow_schema_n_fields

(3&u:)@(7&u:) results

NB. a: int64 x
NB. b: bool x
NB. c: double x
NB. d: string 
NB. byte: int8
NB. ubyte: uint8
NB. short: int16
NB. ushort: uint16
NB. intc: int32
NB. uintc: int64
NB. int_: int64
NB. uint: uint64
NB. int8: int8
NB. int16: int16
NB. int32: int32
NB. int64: int64
NB. longlong: int64
NB. ulonglong: uint64
NB. single: float
NB. double: double

NB. boxStrings??
NB. None mask??

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


NB. Arrow files
readArrowSchema =. {{}}
readArrowData =. {{}}
readArrowToTable =. {{}}
schemaFields =. {{}}
writeArrow =. {{}}
writeArrowFromTable =. {{}}

0 : 0
Arrow 
 'array'  [ ]
 'tensor' [ ]
 'value'  [ ]
 'type'   [ ]
 'schema' [x]
 'table' [x]
  'schema' [x]
   'field' [ ]
  'chunkedarray' [ ]
    'array' [ ]
     'arraytype'  
      'datatype'
 'computation'
 'buffer'
 'codec'
 'error'

Parquet
'filereader' [ ] -> table

)















e=. mema 4 NB. pointer to int32 for error codes
r=. (libParquet, gpafr) cd '/test.parquet'; <<e NB. New GParquetArrowFileReader

NB. 0{r is a pointer to the reader
NB. TODO do we need to free the reader manually?

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
NB. =========================================================
NB. =========================================================
NB. =========================================================
NB. =========================================================
NB. =========================================================
NB. =========================================================

garrow_data_type_get_type

a0 =. '"/usr/local/Cellar/apache-arrow-glib/4.0.1/lib/libparquet-glib.dylib"  garrow_data_type_get_type *'&cd ''

namePt =. writeChar 'colname'
fieldPt =. garrow_field_new namePt;<a0



'"/usr/local/Cellar/apache-arrow-glib/4.0.1/lib/libparquet-glib.dylib"  garrow_field_new * * *'&cd (0{::namePt);<a0

writeChar =. {{(<charPt);(#y) [ y memw (]charPt =. mema (# y)),0,(# y),2}}
readChar =. {{memr (>y),0,_1}}
freePt =. memf@>
writeInt =. {{<valPt [ y memw (]valPt =. mema 1),0,1,4}}

intPt =. writeInt 0
bufferPt =. garrow_buffer_new_bytes < intPt

dataPt=. writeInt 2
bufferPt garrow_buffer_new dataPt;<1

garrow_buffer_new dataPt;<1
garrow_buffer_new (const guint8 *data, gint64 size)



garrow_int16_array_new (gint64 length,
                        GArrowBuffer *data,
                        GArrowBuffer *null_bitmap,
                        gint64 n_nulls);


datatypePt =. ptr garrow_array_get_value_data_type < arrayPt


garrow_boolean_array_builder_new
a1=. (garrow_int8_data_type_new '')
a2=. (garrow_int16_data_type_new '')
a3=. (garrow_string_data_type_new '')

readChar writeChar


'type' =. y
typePt =. ". fun


typeGetValues&typeIndexLookup 3

'"/usr/local/Cellar/apache-arrow-glib/4.0.1/lib/libparquet-glib.dylib"  garrow_field_new * * *'&cd intPt;<a2


a1=. (garrow_int8_data_type_new '')
intPt =. writeInt 3
valPt =. garrow_field_new intPt;<a2
freePt 


writeChar 'colname'
writeName=: writeChar

namePt =. writeChar 'colname'
fieldPt =. garrow_field_new namePt;<a3

garrow_field_new namePt;<a3

writeParquet
schema;array_data;parquet_write_options]


'tablePointer colIndex' =. (tp2);13
ncols =. tableNCols tablePointer
'Index is greater than number of columns. Note columns are zero-indexed.' assert colIndex < ncols
chunkedArrayPointers =. <"0 ptr"1 garrow_table_get_column_data (< tablePointer), < colIndex
> readChunks each chunkedArrayPointers

chunkedArrayPointer =. 0{:: chunkedArrayPointers
nChunks =. 0&{::@garrow_chunked_array_get_n_chunks < chunkedArrayPointer
arrayPointers =. readChunk each <"1 (<chunkedArrayPointer),.(<"0 i. nChunks)

arrayPt =. arrayPointer =. 0{::arrayPointers



readArrayType=:{{
'arrayPt' =. y
dataTypePt =. ptr garrow_array_get_value_data_type < arrayPt
getChar (ret ptr garrow_data_type_get_name < dataTypePt)
}}
readArrayTypeIndex=:{{
'arrayPt' =. y
datatypePt =. ptr garrow_array_get_value_data_type < arrayPt
ret garrow_data_type_get_id < datatypePt
}}
readArrayBitWidth=:{{
'arrayPt' =. y
datatypePt =. ptr garrow_array_get_value_data_type < arrayPt
ret garrow_fixed_width_data_type_get_bit_width < datatypePt
}}








garrow_csv_read_options_set_property
lookup 'garrow_csv_read_options_set_property'
GARROW_CSV_READ_OPTIONS



garrow_csv_read_options_add_column_type

(<rdOptPt),e






lookup 'garrow_csv_read_options_add_column_name'

garrow_csv_read_options_get_column_names rdOptPt



'"/usr/local/lib/libparquet-glib.dylib"  garrow_csv_read_options_add_column_type n * * *'&cd


(GArrowCSVReadOptions *options, const gchar *column_name); void


garrow_csv_read_options_get_column_names
garrow_csv_read_options_init rdOptPt
garrow_csv_reader_dispose '"/usr/local/lib/libparquet-glib.dylib" garrow_csv_read_options_new *'&cd ''

garrow_csv_read_options_set_column_names (<rdOptPt)
garrow_csv_read_options_set_property 

columnNames =. 

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

a =. 'n-skip-rows'
b =. 'N skip rows'
c =. 'The number of header rows to skip'
d =. '(not including the row of column names, if any)'

AA =. setChar each a;b;c;d

paramspec AA,0;1;0;1

'"/usr/local/lib/libparquet-glib.dylib" g_param_spec_uint i i'&cd 1
'"/usr/local/lib/libarrow-glib.dylib" g_param_spec_internal i i'&cd 1

'"/usr/local/lib/libparquet-glib.dylib" G_PARAM_READABLE n i'&cd 1

'"/usr/local/lib/libglib-2.0.dylib" g_param_spec_internal * n'&cd ''
'"/usr/local/lib/libgio-2.0.dylib" g_param_spec_internal * n'&cd ''
'"/usr/local/lib/libparquet-glib.dylib" g_param_spec_internal * n'&cd ''

G_PARAM_READWRITE
G_MAXUINT
read_options.skip_rows,
static_cast<GParamFlags>(G_PARAM_READWRITE));


garrow_csv_reader_new
garrow_csv_reader_read



readCSV =: {{
'USE_THREADS';'BLOCK_SIZE';'N_SKIP_ROWS';'DELIMITER';'IS_QUOTED';'QUOTE_CHARACTER';' IS_DOUBLE_QUOTED';'IS_ESCAPED';'ESCAPE_CHARACTER';'ALLOW_NEWLINES_IN_VALUES';'IGNORE_EMPTY_LINES';'CHECK_UTF8';'ALLOW_NULL_STRINGS';'GENERATE_COLUMN_NAMES'
}}

