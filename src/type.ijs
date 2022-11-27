NB. =========================================================
NB. Type
NB. =========================================================

NB. Definition of NULL value replacement for read files.
NULL=: __

garrow_na_array_get_valueSHIM=: NULL&[

garrow_na_array_get_valuesSHIM=: {{(1 getInts > {: y) # NULL}}

NB. garrow_string_array_get_stringSHIM =: <@getString@>@{.@garrow_string_array_get_string
garrow_string_array_get_stringSHIM=: <@<@getStringFree@{.@garrow_string_array_get_string
garrow_boolean_array_get_valueSHIM=: (3&u:)@(7&u:)@>@{.@garrow_boolean_array_get_value

getBufferData=: {{
bufferPtr=. y
NB. cap =. ret garrow_buffer_get_capacity < bufferPtr
NB. val =. ret garrow_buffer_get_size < bufferPtr
gbPtr=. ptr garrow_buffer_get_data < bufferPtr
gbsize=. ret g_bytes_get_size < gbPtr
dataPtr=. ptr g_bytes_get_data gbPtr; < pt=. setInts gbsize
NB. g_bytes_unref < gbPtr
NB. dataPtr=. ptr g_bytes_unref_to_data gbPtr; < pt=. setInts gbsize
memf > pt
dataPtr
}}

setBufferData=: {{
dataPtr =. y
ptr garrow_buffer_new_bytes < dataPtr
}}

NB. Read variable length strings directly from buffer.
garrow_string_array_get_stringsSHIM=: {{
'arrayPt'=. > {. y
bufferPtr =. ptr garrow_binary_array_get_data_buffer < arrayPt NB. Two pointers for binary arrays: 1) data and 2) offsets
dataPtr=. getBufferData bufferPtr
offsetPtr=. getBufferData ptr garrow_binary_array_get_offsets_buffer < arrayPt
locLen=. (4&*)@>: ret garrow_array_get_length < arrayPt
loc=. _2&(3!:4) memr (>offsetPtr),0,locLen,2
dat=. getString dataPtr
res=. ((0&|:)@,:@(}:,.(}.-}:)) loc) <;.0 dat
removeObject"0 bufferPtr
NB. g_bytes_unref < dataPtr
res
}}

byteSHIM=: {{
'arrayPt lengthPtr'=. y
resPtr=. ptr v arrayPt;<lengthPtr
length =. 1 getInts lengthPtr
bitWidth=. ret garrow_fixed_width_data_type_get_bit_width < ptr garrow_array_get_value_data_type <arrayPt
bytes=. memr (>resPtr),0,(length * bitWidth <.@% 8),2
res=. u bytes
res
}}

garrow_uint16_array_get_valuesSHIM=: (_1&ic byteSHIM garrow_uint16_array_get_values)
garrow_int16_array_get_valuesSHIM=: (_1&ic byteSHIM garrow_int16_array_get_values)
garrow_uint32_array_get_valuesSHIM=: (_2&ic byteSHIM garrow_uint32_array_get_values)
garrow_int32_array_get_valuesSHIM=: (_2&ic byteSHIM garrow_int32_array_get_values)
garrow_float_array_get_valuesSHIM=: (_1&fc byteSHIM garrow_float_array_get_values)
garrow_date32_array_get_valuesSHIM=: (_2&ic byteSHIM garrow_date32_array_get_values)
garrow_time32_array_get_valuesSHIM=: (_2&ic byteSHIM garrow_time32_array_get_values)

garrow_dictionary_array_get_indicesSHIM=: {{
indicesArrayPtr =. ptr@garrow_dictionary_array_get_indices@{. y
res =. readArray indicesArrayPtr
removeObject indicesArrayPtr
res
}}

NB. or use garrow_dictionary_array_get_dictionary for values

deTAB =. #~ ((+.) (1: |. (> </\)))@(TAB&~:)

'typeGArrowName typeName typeGetValue typeGetValues typeNew typeJ typeJMemr typeDescription' =: (<"1)@|:@(>@(((9{a.)&cut)&.>)@}.@((10{a.)&cut))@deTAB 0 : 0
GARROW_TYP			name		getValue				getValues				typeNew			typeJMemrJtype	Jmemr	description
GARROW_TYPE_NA		null		garrow_na_array_get_valueSHIM		garrow_na_array_get_valuesSHIM		garrow_null_data_type_new		null		0	A degenerate NULL type represented as 0 bytes/bits.
GARROW_TYPE_BOOLEAN		bool		garrow_boolean_array_get_valueSHIM		garrow_boolean_array_get_values		garrow_boolean_data_type_new	bool		1	A boolean value represented as 1-bit.
GARROW_TYPE_UINT8		uint8		garrow_uint8_array_get_value		garrow_uint8_array_get_values		garrow_uint8_data_type_new		int		4	Little-endian 8-bit unsigned integer.
GARROW_TYPE_INT8		int8		garrow_int8_array_get_value		garrow_int8_array_get_values		garrow_int8_data_type_new		int		4	Little-endian 8-bit signed integer.
GARROW_TYPE_UINT16		uint16		garrow_uint16_array_get_value		garrow_uint16_array_get_valuesSHIM		garrow_uint16_data_type_new	int		4	Little-endian 16-bit unsigned integer.
GARROW_TYPE_INT16		int16		garrow_int16_array_get_value		garrow_int16_array_get_valuesSHIM		garrow_int16_data_type_new		int		4	Little-endian 16-bit signed integer.
GARROW_TYPE_UINT32		uint32		garrow_uint32_array_get_value		garrow_uint32_array_get_valuesSHIM		garrow_uint32_data_type_new	int		4	Little-endian 32-bit unsigned integer.
GARROW_TYPE_INT32		int32		garrow_int32_array_get_value		garrow_int32_array_get_valuesSHIM		garrow_int32_data_type_new		int		4	Little-endian 32-bit signed integer.
GARROW_TYPE_UINT64		uint64		garrow_uint64_array_get_value		garrow_uint64_array_get_values		garrow_uint64_data_type_new	int		4	Little-endian 64-bit unsigned integer.
GARROW_TYPE_INT64		int64		garrow_int64_array_get_value		garrow_int64_array_get_values		garrow_int64_data_type_new		int		4	Little-endian 64-bit signed integer.
GARROW_TYPE_HALF_FLOAT		float16		NA				NA				NA			float		8	2-byte floating point value.
GARROW_TYPE_FLOAT		float		garrow_float_array_get_value		garrow_float_array_get_valuesSHIM		garrow_float_data_type_new		float		8	4-byte floating point value.
GARROW_TYPE_DOUBLE		double		garrow_double_array_get_value		garrow_double_array_get_values		garrow_double_data_type_new	float		8	8-byte floating point value.
GARROW_TYPE_STRING		utf8		garrow_string_array_get_stringSHIM		garrow_string_array_get_stringsSHIM		garrow_string_data_type_new	char		2	UTF-8 variable-length string.
GARROW_TYPE_BINARY		binary		garrow_binary_array_get_value		NA				garrow_binary_data_type_new	byte		2	Variable-length bytes (no guarantee of UTF-8-ness).
GARROW_TYPE_FIXED_SIZE_BINARY	w:[n]		garrow_fixed_size_binary_array_get_value	garrow_fixed_size_binary_array_get_values_bytes	garrow_fixed_size_binary_data_type_new	byte		2	Fixed-size binary. Each value occupies the same number of bytes.
GARROW_TYPE_DATE32		date32		garrow_date32_array_get_value		garrow_date32_array_get_valuesSHIM		garrow_date32_data_type_new	int		4	int32 days since the UNIX epoch.
GARROW_TYPE_DATE64		date64		garrow_date64_array_get_value		garrow_date64_array_get_values		garrow_date64_data_type_new	int		4	int64 milliseconds since the UNIX epoch.
GARROW_TYPE_TIMESTAMP		timestamp		garrow_timestamp_array_get_value		garrow_timestamp_array_get_values		garrow_timestamp_data_type_new	int		4	Exact timestamp encoded with int64 since UNIX epoch. Default unit millisecond.
GARROW_TYPE_TIME32		time32		garrow_time32_array_get_value		garrow_time32_array_get_valuesSHIM		garrow_time32_data_type_new	int		4	Exact time encoded with int32, supporting seconds or milliseconds
GARROW_TYPE_TIME64		time64		garrow_time64_array_get_value		garrow_time64_array_get_values		garrow_time64_data_type_new	int		4	Exact time encoded with int64, supporting micro- or nanoseconds
GARROW_TYPE_INTERVAL_MONTHS	intervalmonths	NA				NA				NA			char		4	YEAR_MONTH interval in SQL style.
GARROW_TYPE_INTERVAL_DAY_TIME	intervaldaystime	NA				NA				NA			char		4	DAY_TIME interval in SQL style.
GARROW_TYPE_DECIMAL128		int128		garrow_decimal128_array_get_value		NA				garrow_decimal128_data_type_new	float		8	Precision- and scale-based decimal type with 128-bit. Storage type depends on the parameters.
GARROW_TYPE_DECIMAL256		int256		garrow_decimal256_array_get_value		NA				garrow_decimal256_data_type_new	float		8	Precision- and scale-based decimal type with 256-bit. Storage type depends on the parameters.
GARROW_TYPE_LIST		list		garrow_list_array_get_value		garrow_list_array_get_values		NA			NA		0	A list of some logical data type.
GARROW_TYPE_STRUCT		struct		garrow_struct_array_get_field		garrow_struct_array_get_fields		NA			NA		0	Struct of logical types.
GARROW_TYPE_SPARSE_UNION		sparseunion		NA				NA				NA			NA		0	Sparse unions of logical types.
GARROW_TYPE_DENSE_UNION		denseunion		NA				NA				NA			NA		0	Dense unions of logical types.
GARROW_TYPE_DICTIONARY		dictionary		NA				garrow_dictionary_array_get_indicesSHIM		NA			int		4	Dictionary aka Category type.
GARROW_TYPE_MAP		map		NA				NA				NA			NA		0	A repeated struct logical type.
GARROW_TYPE_EXTENSION		extension		NA				NA				NA			NA		0	Custom data type, implemented by user.
GARROW_TYPE_FIXED_SIZE_LIST	flist		NA				NA				NA			NA		0	Fixed size list of some logical type.
GARROW_TYPE_DURATION		duration		NA				NA				NA			NA		0	Measure of elapsed time in either seconds, milliseconds, microseconds or nanoseconds.
GARROW_TYPE_LARGE_STRING		large_utf8		garrow_large_string_array_get_string		NA				garrow_large_string_data_type_new	char		2	64bit offsets UTF-8 variable-length string.
GARROW_TYPE_LARGE_BINARY		large_binary		garrow_large_binary_array_get_value		NA				garrow_large_binary_data_type_new	char		2	64bit offsets Variable-length bytes (no guarantee of UTF-8-ness).
GARROW_TYPE_LARGE_LIST		large_list		garrow_large_list_array_get_value		garrow_large_list_array_get_values				NA			NA		0	A list of some logical data type with 64-bit offsets.
)

typeIndexLookup=: {{> x {~ y}}
typeNameIndex=: (typeName&i.)@<
typeNameLookup=: {{> x {~ typeNameIndex y}}
NB. typeNameIndex each typeName

NB. Examples:
NB. typeNameIndex 'float'
NB. typeGetValue&typeNameLookup 'float'
NB. typeNameIndex 'utf8'
NB. typeDescription typeNameLookup 'utf8'
NB. typeGetValue&typeNameLookup 'utf8'
NB. typeNew&typeNameLookup 'float'

NB. Date from Unix epoch 1970-01-01
NB. fromdate32 0, 18262
fromdate32 =. {{
a=. 719468.75 + , y
c=. <. 36524.25 %~ a
d=. <. a - 36524.25 * c
db=. <. 365.25 %~ ( d+0.75) 
da=. <. 1.75 + d - 365.25 * db
mm =. <. 30.6 %~ (da - 0.59)
((c*100)+db+mm >: 10),.(1+12 | mm+2),.<. 0.41 + da - 30.6 * mm
}}

fromdatetime64 =. (6!:16)
