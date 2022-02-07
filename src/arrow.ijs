init ''

NB. =========================================================
NB. Array
NB. =========================================================
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

readArrayLength=:{{ret garrow_array_get_length < y}}

writeArrayWidth=:{{<lengthPt [ length memw (] lengthPt =. mema width),0,1,4 [ 'length width' =. y}}

readArray=:{{
  'arrayPt' =. y
  indexType =. readArrayTypeIndex arrayPt
  arrayType =. readArrayType arrayPt
  length =. readArrayLength arrayPt
  lengthPt =. writeArrayWidth length;width
  getValueFunc =. typeGetValue&typeIndexLookup indexType NB. lookup functions
  fRun =. getValueFunc,', arrayPt;<'
  results =. ; ret@". each (fRun&,)@": each <"0 i.length
  NB. getValuesFunc =. typeGetValues&typeIndexLookup indexType NB. lookup functions
  NB. arrayValuesPt =.  ptr ". getValuesFunc,', (arrayPt);<lengthPt'
  NB. Jtype =.  ". typeJMemr&typeIndexLookup indexType
  NB. results =. memr (ret arrayValuesPt),0,length,Jtype
  NB. memf > lengthPt
  results
}}

NB. =========================================================
NB. chunkedArray
NB. =========================================================
readChunk=:{{
  'chunkedArrayPt index' =. y
  ptr@garrow_chunked_array_get_chunk chunkedArrayPt;index
}}

readChunks=:{{
  'chunkedArrayPt' =. y
  nChunks =. ret@garrow_chunked_array_get_n_chunks < chunkedArrayPt
  arrayPts =. readChunk each <"1 (<chunkedArrayPt),.(<"0 i. nChunks)
  readArray each arrayPts
}}

readChunkedArray=:{{
  'chunkedArrayPt' =. y
  NB. length =. > ptr@garrow_chunked_array_get_length < chunkedArrayPt
  NB. valuetype =. > ptr@garrow_chunked_array_get_value_type < chunkedArrayPt
  NB. nrows  =. > ptr@garrow_chunked_array_get_n_rows < chunkedArrayPt
  NB. nnulls =. > ptr@garrow_chunked_array_get_n_nulls < chunkedArrayPt
  NB. valuedatatype =. ptr@garrow_chunked_array_get_value_data_type < chunkedArrayPt
  NB. length;nrows;nnulls;valuetype;<valuedatatype
  readChunks chunkedArrayPt
}}

NB. =========================================================
NB. Field
NB. =========================================================
getFieldName=:{{
  fieldPt =. y
  getChar ptr garrow_field_get_name fieldPt
}}

getFieldDataType=:{{
  'fieldPt' =. y
  dataTypePt =. ptr garrow_field_get_data_type fieldPt
  getChar ret garrow_data_type_get_name < dataTypePt
}}

NB. getFieldNullable=:{{
NB. fieldPt=.y
NB. garrow_field_is_nullable fieldPt
NB. gboolean
NB. }}
NB. getFieldToString=:{{
NB. 'fieldPt'=.y
NB. garrow_field_to_string fieldPt
NB. gchar *
NB. gFree
NB. }}
NB. getFieldToStringMeta {{
NB. 'fieldPt'=.y
NB. garrow_field_to_string_metadata fieldPt;1
NB. gchar *
NB. gFree
NB. }}
NB. {{
NB. 'fieldPt'=.y
NB. garrow_field_has_metadata fieldPt
NB. gboolean
NB. }}

NB. =========================================================
NB. Schema
NB. =========================================================
getSchemaPt =: {{
  tablePt =. y
  ptr garrow_table_get_schema < tablePt
}}

getSchemaFieldPt =: {{
  'schemaPt index'=.y
  ptr garrow_schema_get_field schemaPt;index
}}

getSchemaName=:{{
  'schemaPt index'=.y
  fieldPts =. getSchemaFieldPt (<schemaPt),< index
  name =. getFieldName < fieldPts
  name
}}

getSchemaNames=:{{
  schemaPt =. y
  nFields =. ret garrow_schema_n_fields < schemaPt
  names =. getSchemaName each <"1 (<schemaPt),.<"0 i. nFields
  names
}}

getSchemaFields=:{{
  schemaPt =. y
  nFields =. ret garrow_schema_n_fields < schemaPt
  fieldPts =. getSchemaFieldPt each <"1 (<schemaPt),.<"0 i. nFields
  types =. getFieldDataType@< each fieldPts
  names =. getFieldName@< each fieldPts
  names,:types
}}

readSchemaString=:{{
  tablePt =. y
  schemaPt =. getSchemaPt tablePt
  getChar ret ptr garrow_schema_to_string < schemaPt
}}

readSchema=:{{
  tablePt =. y
  schemaPt =. getSchemaPt tablePt
  getSchemaFields schemaPt
}}

readSchemaColumnName=:{{
  'tablePt index'=.y
  getSchemaName (getSchemaPt tablePt);<index
}}

readSchemaNames=:{{
  tablePt =. y
  schemaPt =. getSchemaPt tablePt
  getSchemaNames schemaPt
}}

NB. =========================================================
NB. Table
NB. =========================================================
tableNRows=:{{ret garrow_table_get_n_rows (< y)}}
tableNCols=:{{ret garrow_table_get_n_columns (< y)}}

readData=:{{
  'tablePt' =. y
  ncols =. tableNCols tablePt
  chunkedArrayPts =. <"0 ptr"1 garrow_table_get_column_data (< tablePt),. <"0 i. ncols
  ,. > readChunkedArray each chunkedArrayPts
}}

readDataColumn=:{{
  'tablePt colIndex' =. y
  ncols =. tableNCols tablePt
  'Index is greater than number of columns. Note columns are zero-indexed.' assert colIndex < ncols
  chunkedArrayPts =. <"0 ptr"1 garrow_table_get_column_data (< tablePt), < colIndex
  ,. > readChunkedArray each chunkedArrayPts
}}

readColumn=:{{
  'tablePt colIndex' =. y
  ((<@readSchemaColumnName),.readDataColumn) (< tablePt),< colIndex
}}

readTable=:{{
  'tablePt' =. y
  (readSchemaNames,.readData) tablePt
}}

readsTable=:{{
  'tablePt' =. y
  ((,@readSchemaNames),:(,@:(,.&.>)@:readData)) tablePt
}}

NB. =========================================================
NB. Parquet
NB. =========================================================
readParquet=:{{
  'filepath'=.y
  e=. << mema 4
  r=. gparquet_arrow_file_reader_new_path filepath;e
  t=. gparquet_arrow_file_reader_read_table (ptr r);e
  memf >> e
  ptr t
}}

readParquetSchema=:{{
  'filepath'=.y
  readSchema@readParquet filepath
}}

readParquetData=:{{
  'filepath'=.y
  readData@readParquet filepath
}}

readParquetTable=:{{
  'filepath'=.y
  readTable@readParquet filepath
}}

readsParquetTable=:{{
  'filepath'=.y
  readsTable@readParquet filepath
}}

readParquetColumn =: {{
  'filepath index' =. y
  readColumn (readParquet filepath);<index
}}

writeParquet=: {{
  'filepath'=.y
}}

writeParquetFromTable=: {{
  'table writeOptions' =. y
}}
