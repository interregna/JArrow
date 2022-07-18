NB. =========================================================
NB. Fast read numbers (e.g. batch read values)


readArrayLength=:{{ret garrow_array_get_length < y}}
writeArrayLength=.{{<lengthPt [ (3 (3!:4) length) memw (] lengthPt =. mema 2),0,8,2 [ length =. y}}

readArray=:{{
  'arrayPt' =. y
  indexType =. readArrayTypeIndex arrayPt
  arrayType =. readArrayType arrayPt
  length =. readArrayLength arrayPt
  getValueFunc =. typeGetValue&typeIndexLookup indexType NB. lookup functions
  fRun =. getValueFunc,', arrayPt;<'
  results =. ; ret@". each (fRun&,)@": each <"0 i.length

  NB. width =. readArrayBitWidth arrayPt
  NB. lengthPt =. writeArrayLength length
  NB. getValuesFunc =. typeGetValues&typeIndexLookup indexType NB. lookup functions
  NB. arrayValuesPt =.  ptr ". getValuesFunc,', (arrayPt);<lengthPt'
  NB. Jtype =.  ". typeJMemr&typeIndexLookup indexType
  NB. results =. memr (ret arrayValuesPt),0,length,Jtype
  NB. memf > lengthPt
  results
}}


vs =. {{
'tablePointer colIndex' =. tp2;y
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

width =. readArrayBitWidth arrayPointer NB. "value" data only NB. FIX!!
writeArrayLength=.{{<lengthPt [ length memw (] lengthPt =. mema 1),0,1,4 [ length =. y}}
lengthPointer =. writeArrayLength length

getValuesFunc =. typeGetValues&typeIndexLookup indexType NB. lookup functions
arrayValuesPointer =.  ptr ". getValuesFunc,', arrayPointer;<lengthPointer'

if. width ~: 64 do.
 type =. typeJ&typeIndexLookup indexType NB. lookup type functions  
 f =. (3!:4)`(3!:5)@. ((('int';'float')&I.) < type)
 memxarg =. ((_1,_1,_2,_1,_1)&({~))@:(('uint16';'int16';'int32';'float';'float32')&i.) < arrayType
 memsize=. ((2,4,1)&({~))@:((16,32,64)&I.) width
 results2 =. memxarg f memr (0{::arrayValuesPointer),0,(length * memsize),2
else.
 xarg =. 'non-converted'
 Jtype =.  ". typeJMemr&typeIndexLookup indexType
 results2 =. memr (0{::arrayValuesPointer),0,length,Jtype
end.
NB. _1 (3!:4) memr (0{::arrayValuesPointer),0,length,2
(results -: results2); arrayType;width;length;results2; results
}}

(,~({"0)@:i.@#@{.) readsParquetTable t2path
(vs"0) (i.16),18 NB. Do not read strings or booleans yet.

16 NB. Strings ignore for now.

17 NB. Booleans are width 1 byte.
NB. Correct is 1 1 0 0 1 0 1 0
memr (0{::arrayValuesPointer),0,(length),1
0 (3!:4) memr (0{::arrayValuesPointer),0,length,2
a. i. y =. memr (0{::arrayValuesPointer),0,length,2

NB. =========================================================


NB. =========================================================
NB. IPC
NB. =========================================================

NB. Example for reading CSV
NB. cmd + F9, F9

NB. fnPtr =. setChar '/test.csv'
filenamePtr =. setChar TempPath , 'test.csv'
e=. << mema 4
fInputStreamPtr =. garrow_file_input_stream_new (<filenamePtr);e
'Check file exists and is permissioned.' assert * > ptr fInputStreamPtr

NB. Example adding column names:
readOptionPt =. garrow_csv_read_options_new ''
NB. '"/usr/local/lib/libarrow-glib.dylib" garrow_csv_read_options_add_column_name n * *'&cd (< ptr rdOptPt ),(<< setChar 'col1')

NB. ptr i32 =. '"/usr/local/lib/libarrow-glib.dylib" garrow_int32_data_type_get_type *'&cd ''
NB. '"/usr/local/lib/libarrow-glib.dylib" garrow_csv_read_options_add_column_type n * * *'&cd (< ptr rdOptPt ),(< setChar 'col1');(< ptr i32)

csvReaderPtr =. garrow_csv_reader_new (ptr fInputStreamPtr);(ptr readOptionPt);e
gaTablePtr =. garrow_csv_reader_read (ptr csvReaderPtr);e
readTable (ptr gaTablePtr)
readSchemaString ptr gaTablePtr
readSchema ptr gaTablePtr
readColumn (ptr gaTablePtr);0
readDataColumn (ptr gaTablePtr);1

NB. Is it necessary to close file?
memf >>e

NB. CSV options ...
'"/usr/local/lib/libarrow-glib.dylib" garrow_csv_read_options_set_column_names n * * i'&cd 
(< ptr rdOptPt),(<< setChar 'col1'),< 1
NB. cd errors
cder'' 
cderx''
'"/usr/local/lib/libarrow-glib.dylib" garrow_csv_read_options_add_column_name n * *'&cd  rdOptPt;<<setChar 'colname'

garrow_csv_reader_new
garrow_csv_reader_read

readCSV =: {{
'USE_THREADS';'BLOCK_SIZE';'N_SKIP_ROWS';'DELIMITER';'IS_QUOTED';'QUOTE_CHARACTER';' IS_DOUBLE_QUOTED';'IS_ESCAPED';'ESCAPE_CHARACTER';'ALLOW_NEWLINES_IN_VALUES';'IGNORE_EMPTY_LINES';'CHECK_UTF8';'ALLOW_NULL_STRINGS';'GENERATE_COLUMN_NAMES'
}}


NB. =========================================================
NB. Test for write parquet
t1path =. TempPath,'test1.parquet'
tablePtr =. readParquet t1path
readSchemaString tablePtr

e=. << mema 4
pqtWtrPtr =. gparquet_writer_properties_new ''
schemaPtr =. getSchemaPt tablePtr
fnPtr =. setChar TempPath,'out1.parquet'
pqtFileWriterPtr =. gparquet_arrow_file_writer_new_path (ptr schemaPtr);(ptr fnPtr);(ptr pqtWtrPtr); e

gparquet_arrow_file_writer_write_table (ptr pqtFileWriterPtr);(ptr tablePtr); 1000; e
gparquet_arrow_file_writer_close (ptr pqtFileWriterPtr); e
readTable readParquet TempPath,'out1.parquet'

NB. =========================================================
NB. Test for memory mapping ("feather")
e=. << mema 4
fnPtr =. setChar TempPath,'test.feather'
fosPtr =. garrow_file_output_stream_new (<fnPtr);1;e
ptr fosPtr
NB. Align on metadata prefix:
garrow_output_stream_align (ptr fosPtr);4;e
rbPtr =. garrow_record_batch_new  (GArrowSchema *schema, guint32 n_rows, GList *columns, GError **error) NB. FIX
woPtr =. garrow_write_options_new '' NB. properties https://arrow.apache.org/docs/c_glib/arrow-glib/ipc-options-classes.html#garrow-write-options-new
garrow_output_stream_write_record_batch (ptr fosPtr);(ptr rbPtr);(ptr woPtr);e


NB. =========================================================
NB. Trying to identify version, but doesn't work.

NB. cder''
NB. cderx''
NB. https://code.jsoftware.com/wiki/Guides/DLLs/Error_Messages

'"/usr/local/lib/libarrow-glib.dylib" GARROW_VERSION_CHECK i i i i'&cd 6;0;0
cder''
cderx''

'"/usr/local/lib/libarrow-glib.dylib" GARROW_VERSION_MAJOR > i'&cd ''
cder''
cderx''



NB. Work:
'filereader';
 'tensor'; [ ]
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


NB. Arrow files ("Feather")
readFeatherSchema =. {{}}
readFeatherData =. {{}}
readFeatherTable =. {{}}
schemaFields =. {{}}
writeFeather =. {{}}
writeFeatherFromTable =. {{}}


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
