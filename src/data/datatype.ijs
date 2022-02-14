NB. =========================================================
NB. Basic Data Type
NB. https://arrow.apache.org/docs/c_glib/arrow-glib/basic-data-type-classes.html
NB. =========================================================

basicDatatypeBindings =: lib 0 : 0
n *	garrow_data_type_finalize	(GObject *object); static void
n * i * *	garrow_data_type_set_property	(GObject *object, guint prop_id, const GValue *value, GParamSpec *pspec); static void
n * i * *	garrow_data_type_get_property	(GObject *object, guint prop_id, GValue *value, GParamSpec *pspec); static void
n *	garrow_data_type_init	(GArrowDataType *object); static void
n *	garrow_data_type_class_init	(GArrowDataTypeClass *klass); static void
c * *	garrow_data_type_equal	(GArrowDataType *data_type, GArrowDataType *other_data_type); gboolean
*c *	garrow_data_type_to_string	(GArrowDataType *data_type); gchar *
i *	garrow_data_type_get_id	(GArrowDataType *data_type); GArrowType
*c *	garrow_data_type_get_name	(GArrowDataType *data_type); gchar *
n *	garrow_fixed_width_data_type_init	(GArrowFixedWidthDataType *object); static void
n *	garrow_fixed_width_data_type_class_init	(GArrowFixedWidthDataTypeClass *klass); static void
i *	garrow_fixed_width_data_type_get_bit_width	(GArrowFixedWidthDataType *data_type); gint
n *	garrow_null_data_type_init	(GArrowNullDataType *object); static void
n *	garrow_null_data_type_class_init	(GArrowNullDataTypeClass *klass); static void
*	garrow_null_data_type_new	(void); GArrowNullDataType *
n *	garrow_boolean_data_type_init	(GArrowBooleanDataType *object); static void
n *	garrow_boolean_data_type_class_init	(GArrowBooleanDataTypeClass *klass); static void
*	garrow_boolean_data_type_new	(void); GArrowBooleanDataType *
n *	garrow_numeric_data_type_init	(GArrowNumericDataType *object); static void
n *	garrow_numeric_data_type_class_init	(GArrowNumericDataTypeClass *klass); static void
n *	garrow_integer_data_type_init	(GArrowIntegerDataType *object); static void
n *	garrow_integer_data_type_class_init	(GArrowIntegerDataTypeClass *klass); static void
c *	garrow_integer_data_type_is_signed	(GArrowIntegerDataType *data_type); gboolean
n *	garrow_int8_data_type_init	(GArrowInt8DataType *object); static void
n *	garrow_int8_data_type_class_init	(GArrowInt8DataTypeClass *klass); static void
*	garrow_int8_data_type_new	(void);GArrowInt8DataType *
n *	garrow_uint8_data_type_init	(GArrowUInt8DataType *object); static void
n *	garrow_uint8_data_type_class_init	(GArrowUInt8DataTypeClass *klass); static void
*	garrow_uint8_data_type_new	(void); GArrowUInt8DataType *
n *	garrow_int16_data_type_init	(GArrowInt16DataType *object); static void
n *	garrow_int16_data_type_class_init	(GArrowInt16DataTypeClass *klass); static void
*	garrow_int16_data_type_new	(void); GArrowInt16DataType *
n *	garrow_uint16_data_type_init	(GArrowUInt16DataType *object); static void
n *	garrow_uint16_data_type_class_init	(GArrowUInt16DataTypeClass *klass); static void
*	garrow_uint16_data_type_new	(void); GArrowUInt16DataType *
n *	garrow_int32_data_type_init	(GArrowInt32DataType *object); static void
n *	garrow_int32_data_type_class_init	(GArrowInt32DataTypeClass *klass); static void
*	garrow_int32_data_type_new	(void); GArrowInt32DataType *
n *	garrow_uint32_data_type_init	(GArrowUInt32DataType *object); static void
n *	garrow_uint32_data_type_class_init	(GArrowUInt32DataTypeClass *klass); static void
*	garrow_uint32_data_type_new	(void); GArrowUInt32DataType *
n *	garrow_int64_data_type_init	(GArrowInt64DataType *object); static void
n *	garrow_int64_data_type_class_init	(GArrowInt64DataTypeClass *klass); static void
*	garrow_int64_data_type_new	(void); GArrowInt64DataType *
n *	garrow_uint64_data_type_init	(GArrowUInt64DataType *object); static void
n *	garrow_uint64_data_type_class_init	(GArrowUInt64DataTypeClass *klass); static void
*	garrow_uint64_data_type_new	(void); GArrowUInt64DataType *
n *	garrow_floating_point_data_type_init	(GArrowFloatingPointDataType *object); static void
n *	garrow_floating_point_data_type_class_init	(GArrowFloatingPointDataTypeClass *klass); static void
n *	garrow_float_data_type_init	(GArrowFloatDataType *object); static void
n *	garrow_float_data_type_class_init	(GArrowFloatDataTypeClass *klass); static void
*	garrow_float_data_type_new	(void); GArrowFloatDataType *
n *	garrow_double_data_type_init	(GArrowDoubleDataType *object); static void
n *	garrow_double_data_type_class_init	(GArrowDoubleDataTypeClass *klass); static void
*	garrow_double_data_type_new	(void); GArrowDoubleDataType *
n *	garrow_binary_data_type_init	(GArrowBinaryDataType *object); static void
n *	garrow_binary_data_type_class_init	(GArrowBinaryDataTypeClass *klass); static void
*	garrow_binary_data_type_new	(void); GArrowBinaryDataType *
n *	garrow_fixed_size_binary_data_type_init	(GArrowFixedSizeBinaryDataType *object); static void
n *	garrow_fixed_size_binary_data_type_class_init	(GArrowFixedSizeBinaryDataTypeClass *klass); static void
* i	garrow_fixed_size_binary_data_type_new	(gint32 byte_width); GArrowFixedSizeBinaryDataType *
i *	garrow_fixed_size_binary_data_type_get_byte_width	(GArrowFixedSizeBinaryDataType *data_type); gint32
n *	garrow_large_binary_data_type_init	(GArrowLargeBinaryDataType *object); static void
n *	garrow_large_binary_data_type_class_init	(GArrowLargeBinaryDataTypeClass *klass); static void
*	garrow_large_binary_data_type_new	(void); GArrowLargeBinaryDataType *
n *	garrow_string_data_type_init	(GArrowStringDataType *object); static void
n *	garrow_string_data_type_class_init	(GArrowStringDataTypeClass *klass); static void
*	garrow_string_data_type_new	(void); GArrowStringDataType *
n *	garrow_large_string_data_type_init	(GArrowLargeStringDataType *object); static void
n *	garrow_large_string_data_type_class_init	(GArrowLargeStringDataTypeClass *klass); static void
*	garrow_large_string_data_type_new	(void); GArrowLargeStringDataType *
n *	garrow_date32_data_type_init	(GArrowDate32DataType *object); static void
n *	garrow_date32_data_type_class_init	(GArrowDate32DataTypeClass *klass); static void
*	garrow_date32_data_type_new	(void); GArrowDate32DataType *
n *	garrow_date64_data_type_init	(GArrowDate64DataType *object); static void
n *	garrow_date64_data_type_class_init	(GArrowDate64DataTypeClass *klass); static void
*	garrow_date64_data_type_new	(void); GArrowDate64DataType *
n *	garrow_timestamp_data_type_init	(GArrowTimestampDataType *object); static void
n *	garrow_timestamp_data_type_class_init	(GArrowTimestampDataTypeClass *klass); static void
* i	garrow_timestamp_data_type_new	(GArrowTimeUnit unit); GArrowTimestampDataType *
i *	garrow_timestamp_data_type_get_unit	(GArrowTimestampDataType *timestamp_data_type); GArrowTimeUnit
n *	garrow_time_data_type_init	(GArrowTimeDataType *object); static void
n *	garrow_time_data_type_class_init	(GArrowTimeDataTypeClass *klass); static void
i *	garrow_time_data_type_get_unit	(GArrowTimeDataType *time_data_type); GArrowTimeUnit
n *	garrow_time32_data_type_init	(GArrowTime32DataType *object); static void
n *	garrow_time32_data_type_class_init	(GArrowTime32DataTypeClass *klass); static void
* i *	garrow_time32_data_type_new	(GArrowTimeUnit unit, GError **error); GArrowTime32DataType *
n *	garrow_time64_data_type_init	(GArrowTime64DataType *object); static void
n *	garrow_time64_data_type_class_init	(GArrowTime64DataTypeClass *klass); static void
* i *	garrow_time64_data_type_new	(GArrowTimeUnit unit, GError **error); GArrowTime64DataType *
n *	garrow_decimal_data_type_init	(GArrowDecimalDataType *object); static void
n *	garrow_decimal_data_type_class_init	(GArrowDecimalDataTypeClass *klass); static void
* i i	garrow_decimal_data_type_new	(gint32 precision, gint32 scale); GArrowDecimalDataType *
i *	garrow_decimal_data_type_get_precision	(GArrowDecimalDataType *decimal_data_type); gint32
i *	garrow_decimal_data_type_get_scale	(GArrowDecimalDataType *decimal_data_type); gint32
n *	garrow_decimal128_data_type_init	(GArrowDecimal128DataType *object); static void
n *	garrow_decimal128_data_type_class_init	(GArrowDecimal128DataTypeClass *klass); static void
i	garrow_decimal128_data_type_max_precision	(); gint32
* i i	garrow_decimal128_data_type_new	(gint32 precision, gint32 scale); GArrowDecimal128DataType *
n *	garrow_decimal256_data_type_init	(GArrowDecimal256DataType *object); static void
n *	garrow_decimal256_data_type_class_init	(GArrowDecimal256DataTypeClass *klass); static void
i	garrow_decimal256_data_type_max_precision	(); gint32
* i i	garrow_decimal256_data_type_new	(gint32 precision, gint32 scale); GArrowDecimal256DataType *
n *	garrow_extension_data_type_dispose	(GObject *object); static void
n * i * *	garrow_extension_data_type_set_property	(GObject *object, guint prop_id, const GValue *value, GParamSpec *pspec); static void
n * i * *	garrow_extension_data_type_get_property	(GObject *object, guint prop_id, GValue *value, GParamSpec *pspec); static void
n *	garrow_extension_data_type_init	(GArrowExtensionDataType *object); static void
n *	garrow_extension_data_type_class_init	(GArrowExtensionDataTypeClass *klass); static void
*c *	garrow_extension_data_type_get_extension_name	(GArrowExtensionDataType *data_type); gchar *
* * *	garrow_extension_data_type_wrap_array	(GArrowExtensionDataType *data_type, GArrowArray *storage); GArrowExtensionArray *
* * *	garrow_extension_data_type_wrap_chunked_array	(GArrowExtensionDataType *data_type, GArrowChunkedArray *storage); GArrowChunkedArray *
* *	garrow_extension_data_type_get_storage_data_type_raw	(GArrowExtensionDataType *data_type); static std::shared_ptr<arrow::DataType>
n *	garrow_extension_data_type_registry_finalize	(GObject *object); static void
n * i * *	garrow_extension_data_type_registry_set_property	(GObject *object, guint prop_id, const GValue *value, GParamSpec *pspec); static void
n *	garrow_extension_data_type_registry_init	(GArrowExtensionDataTypeRegistry *object); static void
n *	garrow_extension_data_type_registry_class_init	(GArrowExtensionDataTypeRegistryClass *klass); static void
*	garrow_extension_data_type_registry_default	(void); GArrowExtensionDataTypeRegistry *
c * * *	garrow_extension_data_type_registry_register	(GArrowExtensionDataTypeRegistry *registry, GArrowExtensionDataType *data_type, GError **error); gboolean
c * *c *	garrow_extension_data_type_registry_unregister	(GArrowExtensionDataTypeRegistry *registry, const gchar *name, GError **error); gboolean
* * *c	garrow_extension_data_type_registry_lookup	(GArrowExtensionDataTypeRegistry *registry, const gchar *name); GArrowExtensionDataType *
* *	garrow_data_type_new_raw	(std::shared_ptr<arrow::DataType> *arrow_data_type); ArrowDataType *
* *	garrow_data_type_get_raw	(GArrowDataType *data_type); std::shared_ptr<arrow::DataType>
* *	garrow_extension_data_type_registry_new_raw	(std::shared_ptr<arrow::ExtensionTypeRegistry> *arrow_registry); GArrowExtensionDataTypeRegistry *
* *	garrow_extension_data_type_registry_get_raw	( GArrowExtensionDataTypeRegistry *registry); std::shared_ptr<arrow::ExtensionTypeRegistry>
)


NB. =========================================================
NB. Composite Data Type
NB. https://arrow.apache.org/docs/c_glib/arrow-glib/composite-data-type-classes.html
NB. =========================================================

compositeDataTypeBindings =: lib 0 : 0
n *	garrow_list_data_type_init	(GArrowListDataType *object); static void
n *	garrow_list_data_type_class_init	(GArrowListDataTypeClass *klass); static void
* *	garrow_list_data_type_new	(GArrowField *field); GArrowListDataType *
* *	garrow_list_data_type_get_value_field	(GArrowListDataType *list_data_type); GArrowField *
* *	garrow_list_data_type_get_field	(GArrowListDataType *list_data_type); GArrowField *
n *	garrow_large_list_data_type_init	(GArrowLargeListDataType *object); static void
n *	garrow_large_list_data_type_class_init	(GArrowLargeListDataTypeClass *klass); static void
* *	garrow_large_list_data_type_new	(GArrowField *field); GArrowLargeListDataType *
* *	garrow_large_list_data_type_get_field	(GArrowLargeListDataType *large_list_data_type); GArrowField *
n *	garrow_struct_data_type_init	(GArrowStructDataType *object); static void
n *	garrow_struct_data_type_class_init	(GArrowStructDataTypeClass *klass); static void
* *	garrow_struct_data_type_new	(GList *fields); GArrowStructDataType *
i *	garrow_struct_data_type_get_n_fields	(GArrowStructDataType *struct_data_type); gint
* *	garrow_struct_data_type_get_fields	(GArrowStructDataType *struct_data_type); GList *
* * i	garrow_struct_data_type_get_field	(GArrowStructDataType *struct_data_type , gint i); GArrowField *
* * *c	garrow_struct_data_type_get_field_by_name	(GArrowStructDataType *struct_data_type, const gchar *name); GArrowField *
i * *c	garrow_struct_data_type_get_field_index	(GArrowStructDataType *struct_data_type, const gchar *name); gint
n *	garrow_map_data_type_init	(GArrowMapDataType *object); static void
n *	garrow_map_data_type_class_init	(GArrowMapDataTypeClass *klass); static void
* * *	garrow_map_data_type_new	(GArrowDataType *key_type, GArrowDataType *item_type); GArrowMapDataType *
* *	garrow_map_data_type_get_key_type	(GArrowMapDataType *map_data_type); GArrowDataType *
* *	garrow_map_data_type_get_item_type	(GArrowMapDataType *map_data_type); GArrowDataType *
n *	garrow_union_data_type_init	(GArrowUnionDataType *object); static void
n *	garrow_union_data_type_class_init	(GArrowUnionDataTypeClass *klass); static void
i *	garrow_union_data_type_get_n_fields	(GArrowUnionDataType *union_data_type); gint
* *	garrow_union_data_type_get_fields	(GArrowUnionDataType *union_data_type); GList *
* * i	garrow_union_data_type_get_field	(GArrowUnionDataType *union_data_type , gint i); GArrowField *
* * *	garrow_union_data_type_get_type_codes	(GArrowUnionDataType *union_data_type, gsize *n_type_codes); gint8 *
n *	garrow_sparse_union_data_type_init	(GArrowSparseUnionDataType *object); static void
n *	garrow_sparse_union_data_type_class_init	(GArrowSparseUnionDataTypeClass *klass); static void
* * * i	garrow_sparse_union_data_type_new	(GList *fields , gint8 *type_codes , gsize n_type_codes); GArrowSparseUnionDataType *
n *	garrow_dense_union_data_type_init	(GArrowDenseUnionDataType *object); static void
n *	garrow_dense_union_data_type_class_init	(GArrowDenseUnionDataTypeClass *klass); static void
* * * i	garrow_dense_union_data_type_new	(GList *fields , gint8 *type_codes , gsize n_type_codes); GArrowDenseUnionDataType *
n *	garrow_dictionary_data_type_init	(GArrowDictionaryDataType *object); static void
n *	garrow_dictionary_data_type_class_init	(GArrowDictionaryDataTypeClass *klass); static void
* * * c	garrow_dictionary_data_type_new	(GArrowDataType *index_data_type, GArrowDataType *value_data_type, gboolean ordered); GArrowDictionaryDataType *
* *	garrow_dictionary_data_type_get_index_data_type	(GArrowDictionaryDataType *dictionary_data_type); GArrowDataType *
* *	garrow_dictionary_data_type_get_value_data_type	(GArrowDictionaryDataType *dictionary_data_type); GArrowDataType *
c *	garrow_dictionary_data_type_is_ordered	(GArrowDictionaryDataType *dictionary_data_type); gboolean
)