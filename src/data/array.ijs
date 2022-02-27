NB. =========================================================
NB. Basic Data Type
NB.  https://arrow.apache.org/docs/c_glib/arrow-glib/basic-array-classes.html
NB. =========================================================

basicArrayBindings =: lib 0 : 0
* 	garrow_equal_options_new	(void); GArrowEqualOptions *
i *	garrow_equal_options_is_approx	(GArrowEqualOptions *options); gboolean
* * * *	garrow_array_import	(gpointer c_abi_array, GArrowDataType *data_type, GError **error); GArrowArray *
i * * * *	garrow_array_export	(GArrowArray *array, gpointer *c_abi_array, gpointer *c_abi_schema, GError **error); gboolean
i * *	garrow_array_equal	(GArrowArray *array, GArrowArray *other_array); gboolean
i * * *	garrow_array_equal_options	(GArrowArray *array, GArrowArray *other_array, GArrowEqualOptions *options); gboolean
i * *	garrow_array_equal_approx	(GArrowArray *array, GArrowArray *other_array); gboolean
i * x * x x *	garrow_array_equal_range	(GArrowArray *array, gint64 start_index, GArrowArray *other_array, gint64 other_start_index, gint64 end_index, GArrowEqualOptions *options); gboolean
i * x	garrow_array_is_null	(GArrowArray *array, gint64 i); gboolean
i * x	garrow_array_is_valid	(GArrowArray *array, gint64 i); gboolean
x *	garrow_array_get_length	(GArrowArray *array); gint64
x *	garrow_array_get_offset	(GArrowArray *array); gint64
x *	garrow_array_get_n_nulls	(GArrowArray *array); gint64
* *	garrow_array_get_null_bitmap	(GArrowArray *array); GArrowBuffer *
* *	garrow_array_get_value_data_type	(GArrowArray *array); GArrowDataType *
i *	garrow_array_get_value_type	(GArrowArray *array); GArrowType
* * x x	garrow_array_slice	(GArrowArray *array, gint64 offset, gint64 length); GArrowArray *
*c * *	garrow_array_to_string	(GArrowArray *array, GError **error); gchar *
* * * *	garrow_array_view	(GArrowArray *array, GArrowDataType *return_type, GError **error); GArrowArray *
* * * *	garrow_array_diff_unified	(GArrowArray *array, GArrowArray *other_array); gchar *
* * * *	garrow_array_concatenate	(GArrowArray *array, GList *other_arrays, GError **error); GArrowArray *
* l	garrow_null_array_new	(gint64 length); GArrowNullArray *
* *	garrow_primitive_array_get_data_buffer	(GArrowPrimitiveArray *array); GArrowBuffer *
*c x * * x	garrow_boolean_array_new	(gint64 length, GArrowBuffer *data, GArrowBuffer *null_bitmap, gint64 n_nulls); GArrowBooleanArray *
i * x	garrow_boolean_array_get_value	(GArrowBooleanArray *array, gint64 i); gboolean
*i * *	garrow_boolean_array_get_values	(GArrowBooleanArray *array, gint64 *length); gboolean *
* x * * x	garrow_int8_array_new	(gint64 length, GArrowBuffer *data, GArrowBuffer *null_bitmap, gint64 n_nulls); GArrowInt8Array *
*l * x	garrow_int8_array_get_value	(GArrowInt8Array *array, gint64 i); gint8
*l * *x	garrow_int8_array_get_values	(GArrowInt8Array *array, gint64 *length); const gint8 *
* x * * x	garrow_uint8_array_new	(gint64 length, GArrowBuffer *data, GArrowBuffer *null_bitmap, gint64 n_nulls); GArrowUInt8Array *
l * x	garrow_uint8_array_get_value	(GArrowUInt8Array *array, gint64 i); guint8
*l *i *x	garrow_uint8_array_get_values	(GArrowUInt8Array *array, gint64 *length); const guint8 *
* * * x	garrow_int16_array_new	(gint64 length, GArrowBuffer *data, GArrowBuffer *null_bitmap, gint64 n_nulls); GArrowInt16Array *
i * x	garrow_int16_array_get_value	(GArrowInt16Array *array, gint64 i); gint16  NB. FIX
* * *	garrow_int16_array_get_values	(GArrowInt16Array *array, gint64 *length); const gint16 *
* x * * x	garrow_uint16_array_new	(gint64 length, GArrowBuffer *data, GArrowBuffer *null_bitmap, gint64 n_nulls); GArrowUInt16Array *  NB. FIX
i * x	garrow_uint16_array_get_value	(GArrowUInt16Array *array, gint64 i); guint16  NB. FIX
* * *	garrow_uint16_array_get_values	(GArrowUInt16Array *array, gint64 *length); const guint16 *  NB. FIX
i x * * x	garrow_int32_array_new	(gint64 length, GArrowBuffer *data, GArrowBuffer *null_bitmap, gint64 n_nulls); GArrowInt32Array *
i * x	garrow_int32_array_get_value	(GArrowInt32Array *array, gint64 i); gint32
*i * *x	garrow_int32_array_get_values	(GArrowInt32Array *array, gint64 *length); const gint32 *
* x * * x	garrow_uint32_array_new	(gint64 length, GArrowBuffer *data, GArrowBuffer *null_bitmap, gint64 n_nulls); GArrowUInt32Array *
i * x	garrow_uint32_array_get_value	(GArrowUInt32Array *array, gint64 i); guint32
*i * *x	garrow_uint32_array_get_values	(GArrowUInt32Array *array, gint64 *length); const guint32 *
*x x * * x	garrow_int64_array_new	(gint64 length, GArrowBuffer *data, GArrowBuffer *null_bitmap, gint64 n_nulls); GArrowInt64Array *
x * x	garrow_int64_array_get_value	(GArrowInt64Array *array, gint64 i); gint64
*x * *x	garrow_int64_array_get_values	(GArrowInt64Array *array, gint64 *length); const gint64 *
*x x * * x	garrow_uint64_array_new	(gint64 length, GArrowBuffer *data, GArrowBuffer *null_bitmap, gint64 n_nulls); GArrowUInt64Array *
x * x	garrow_uint64_array_get_value	(GArrowUInt64Array *array, gint64 i); guint64
*x * *x	garrow_uint64_array_get_values	(GArrowUInt64Array *array, gint64 *length); const guint64 *
* x * * x	garrow_float_array_new	(gint64 length, GArrowBuffer *data, GArrowBuffer *null_bitmap, gint64 n_nulls); GArrowFloatArray *
d * x	garrow_float_array_get_value	(GArrowFloatArray *array, gint64 i); gfloat
*d * *x	garrow_float_array_get_values	(GArrowFloatArray *array, gint64 *length); const gfloat *
* x * * x	garrow_double_array_new	(gint64 length, GArrowBuffer *data, GArrowBuffer *null_bitmap, gint64 n_nulls); GArrowDoubleArray *
d * x	garrow_double_array_get_value	(GArrowDoubleArray *array, gint64 i); gdouble
*d * *x	garrow_double_array_get_values	(GArrowDoubleArray *array, gint64 *length); const gdouble *
* x * * * x	garrow_base_binary_array_new	(gint64 length, GArrowBuffer *value_offsets, GArrowBuffer *value_data, GArrowBuffer *null_bitmap, gint64 n_nulls); GArrowArray *
* * x	garrow_base_binary_array_get_value	(GArrowArray *array, gint64 i); GBytes *
* *	garrow_base_binary_array_get_data_buffer	(GArrowArray *array); GArrowBuffer *
* *	garrow_base_binary_array_get_offsets_buffer	(GArrowArray *array); GArrowBuffer *
* x * * * x	garrow_binary_array_new	(gint64 length, GArrowBuffer *value_offsets, GArrowBuffer *value_data, GArrowBuffer *null_bitmap, gint64 n_nulls); GArrowBinaryArray *
* * x	garrow_binary_array_get_value	(GArrowBinaryArray *array, gint64 i); GBytes *
* *	garrow_binary_array_get_buffer	(GArrowBinaryArray *array); GArrowBuffer *
* *	garrow_binary_array_get_data_buffer	(GArrowBinaryArray *array); GArrowBuffer *
* *	garrow_binary_array_get_offsets_buffer	(GArrowBinaryArray *array); GArrowBuffer *
* x * * * x	garrow_large_binary_array_new	(gint64 length, GArrowBuffer *value_offsets, GArrowBuffer *value_data, GArrowBuffer *null_bitmap, gint64 n_nulls); GArrowLargeBinaryArray *
* * x	garrow_large_binary_array_get_value	(GArrowLargeBinaryArray *array, gint64 i); GBytes *
* *	garrow_large_binary_array_get_buffer	(GArrowLargeBinaryArray *array); GArrowBuffer *
* *	garrow_large_binary_array_get_data_buffer	(GArrowLargeBinaryArray *array); GArrowBuffer *
* *	garrow_large_binary_array_get_offsets_buffer	(GArrowLargeBinaryArray *array); GArrowBuffer *
*c * x	garrow_base_string_array_get_value	(GArrowArray *array, gint64 i); gchar *
* x * * * x	garrow_string_array_new	(gint64 length, GArrowBuffer *value_offsets, GArrowBuffer *value_data, GArrowBuffer *null_bitmap, gint64 n_nulls); GArrowStringArray *
*c * x	garrow_string_array_get_string	(GArrowStringArray *array, gint64 i); gchar *
* x * * * x	garrow_large_string_array_new	(gint64 length, GArrowBuffer *value_offsets, GArrowBuffer *value_data, GArrowBuffer *null_bitmap, gint64 n_nulls); GArrowLargeStringArray *
* * x	garrow_large_string_array_get_string	(GArrowLargeStringArray *array, gint64 i); gchar *
* x * * x	garrow_date32_array_new	(gint64 length, GArrowBuffer *data, GArrowBuffer *null_bitmap, gint64 n_nulls); GArrowDate32Array *
i * x	garrow_date32_array_get_value	(GArrowDate32Array *array, gint64 i); gint32
*i * *x	garrow_date32_array_get_values	(GArrowDate32Array *array, gint64 *length); const gint32 *
* x * * x	garrow_date64_array_new	(gint64 length, GArrowBuffer *data, GArrowBuffer *null_bitmap, gint64 n_nulls); GArrowDate64Array *
x * x	garrow_date64_array_get_value	(GArrowDate64Array *array, gint64 i); gint64
*x * *x	garrow_date64_array_get_values	(GArrowDate64Array *array, gint64 *length); const gint64 *
* * x * * x	garrow_timestamp_array_new	(GArrowTimestampDataType *data_type, gint64 length, GArrowBuffer *data, GArrowBuffer *null_bitmap, gint64 n_nulls); GArrowTimestampArray *
x * x	garrow_timestamp_array_get_value	(GArrowTimestampArray *array, gint64 i); gint64
*x * *x	garrow_timestamp_array_get_values	(GArrowTimestampArray *array, gint64 *length); const gint64 *
*i * x * * x	garrow_time32_array_new	(GArrowTime32DataType *data_type, gint64 length, GArrowBuffer *data, GArrowBuffer *null_bitmap, gint64 n_nulls); GArrowTime32Array *
i * x	garrow_time32_array_get_value	(GArrowTime32Array *array, gint64 i); gint32
*i * *x	garrow_time32_array_get_values	(GArrowTime32Array *array, gint64 *length); const gint32 *
*x * x * * x	garrow_time64_array_new	(GArrowTime64DataType *data_type, gint64 length, GArrowBuffer *data, GArrowBuffer *null_bitmap, gint64 n_nulls); GArrowTime64Array *
x *x x	garrow_time64_array_get_value	(GArrowTime64Array *array, gint64 i); gint64
*x * x	garrow_time64_array_get_values	(GArrowTime64Array *array, gint64 *length); const gint64 *
* * x * * x	garrow_fixed_size_binary_array_new	(GArrowFixedSizeBinaryDataType *data_type, gint64 length, GArrowBuffer *data, GArrowBuffer *null_bitmap, gint64 n_nulls); GArrowFixedSizeBinaryArray *
i *	garrow_fixed_size_binary_array_get_byte_width	(GArrowFixedSizeBinaryArray *array); gint32
* * x	garrow_fixed_size_binary_array_get_value	(GArrowFixedSizeBinaryArray *array, gint64 i); GBytes *
* *	garrow_fixed_size_binary_array_get_values_bytes	(GArrowFixedSizeBinaryArray *array); GBytes *
*c * x	garrow_decimal128_array_format_value	(GArrowDecimal128Array *array, gint64 i); gchar *
* * x	garrow_decimal128_array_get_value	(GArrowDecimal128Array *array, gint64 i); GArrowDecimal128 *
*c * x	garrow_decimal256_array_format_value	(GArrowDecimal256Array *array, gint64 i); gchar *
* * x	garrow_decimal256_array_get_value	(GArrowDecimal256Array *array, gint64 i); GArrowDecimal256 *
)

NB. =========================================================
NB. Composite Array
NB. https://arrow.apache.org/docs/c_glib/arrow-glib/composite-data-type-classes.html
NB. =========================================================

compositeArrayBindings =: lib 0 : 0
* * x * * * x	garrow_base_list_array_new	(GArrowDataType *data_type, gint64 length, GArrowBuffer *value_offsets, GArrowArray *values, GArrowBuffer *null_bitmap, gint64 n_nulls); GArrowArray *
* *	garrow_base_list_array_get_value_type	(GArrowArray *array); GArrowDataType *
* * x	garrow_base_list_array_get_value	(GArrowArray *array , gint64 i); GArrowArray *
* *	garrow_base_list_array_get_values	(GArrowArray *array); GArrowArray *
c i x	garrow_base_list_array_get_value_offset	(GArrowArray *array, gint64 i); typename LIST_ARRAY_CLASS::offset_type
c * x	garrow_base_list_array_get_value_length	(GArrowArray *array, gint64 i); typename LIST_ARRAY_CLASS::offset_type
*c * *x	garrow_base_list_array_get_value_offsets	(GArrowArray *array, gint64 *n_offsets); const typename LIST_ARRAY_CLASS::offset_type *
* * x * * * * x	garrow_list_array_new	(GArrowDataType *data_type, gint64 length, GArrowBuffer *value_offsets, GArrowArray *values, GArrowBuffer *null_bitmap, gint64 n_nulls); GArrowListArray *
* *	garrow_list_array_get_value_type	(GArrowListArray *array); GArrowDataType *
* * x	garrow_list_array_get_value	(GArrowListArray *array, gint64 i); GArrowArray *
* *	garrow_list_array_get_values	(GArrowListArray *array); GArrowArray *
i * x	garrow_list_array_get_value_offset	(GArrowListArray *array, gint64 i); gint32
i * x	garrow_list_array_get_value_length	(GArrowListArray *array, gint64 i); gint32
*i * x	garrow_list_array_get_value_offsets	(GArrowListArray *array, gint64 *n_offsets); const gint32 *
* * i * * * x	garrow_large_list_array_new	(GArrowDataType *data_type, gint64 length, GArrowBuffer *value_offsets, GArrowArray *values, GArrowBuffer *null_bitmap, gint64 n_nulls); GArrowLargeListArray *
* *	garrow_large_list_array_get_value_type	(GArrowLargeListArray *array); GArrowDataType *
* * x	garrow_large_list_array_get_value	(GArrowLargeListArray *array , gint64 i); GArrowArray *
* *	garrow_large_list_array_get_values	(GArrowLargeListArray *array); GArrowArray *
x * x	garrow_large_list_array_get_value_offset	(GArrowLargeListArray *array, gint64 i); gint64
x * x	garrow_large_list_array_get_value_length	(GArrowLargeListArray *array, gint64 i); gint64
*x * *x	garrow_large_list_array_get_value_offsets	(GArrowLargeListArray *array, gint64 *n_offsets); const gint64 *
* * x * * x	garrow_struct_array_new	(GArrowDataType *data_type, gint64 length, GList *fields, GArrowBuffer *null_bitmap, gint64 n_nulls); GArrowStructArray *
* *	garrow_struct_array_get_fields_internal	(GArrowStructArray *array); static GPtrArray *
* * i	garrow_struct_array_get_field	(GArrowStructArray *array, gint i); GArrowArray *
* *	garrow_struct_array_get_fields	(GArrowStructArray *array) GList *
* * *	garrow_struct_array_flatten	(GArrowStructArray *array, GError **error); GList *
* * * * * 	garrow_map_array_new	(GArrowArray *offsets, GArrowArray *keys, GArrowArray *items, GError **error); GArrowMapArray *
* *	garrow_map_array_get_keys	(GArrowMapArray *array); GArrowArray *
* *	garrow_map_array_get_items	(GArrowMapArray *array); GArrowArray *
* * i	garrow_union_array_get_field	(GArrowUnionArray *array, gint i); GArrowArray *
* * * *	garrow_sparse_union_array_new	(GArrowInt8Array *type_ids, GList *fields, GError **error); GArrowSparseUnionArray *
* * * * 	garrow_sparse_union_array_new_data_type	(GArrowSparseUnionDataType *data_type, GArrowInt8Array *type_ids, GList *fields, GError **error); GArrowSparseUnionArray *
* * * * *	garrow_dense_union_array_new	(GArrowInt8Array *type_ids, GArrowInt32Array *value_offsets, GList *fields, GError **error); GArrowDenseUnionArray *
* * * * * *	garrow_dense_union_array_new_data_type	(GArrowDenseUnionDataType *data_type, GArrowInt8Array *type_ids, GArrowInt32Array *value_offsets, GList *fields, GError **error); GArrowDenseUnionArray *
* * * * *	garrow_dictionary_array_new	(GArrowDataType *data_type, GArrowArray *indices, GArrowArray *dictionary, GError **error); GArrowDictionaryArray *
* *	garrow_dictionary_array_get_indices	(GArrowDictionaryArray *array); GArrowArray *
* *	garrow_dictionary_array_get_dictionary	(GArrowDictionaryArray *array); GArrowArray *
* *	garrow_dictionary_array_get_dictionary_data_type	(GArrowDictionaryArray *array); GArrowDictionaryDataType *
) 