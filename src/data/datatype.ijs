NB. =========================================================
NB. Basic Data Type
NB. https://arrow.apache.org/docs/c_glib/arrow-glib/basic-data-type-classes.html
NB. =========================================================

basicDatatypeBindings =: lib 0 : 0
* * *	garrow_data_type_import	(gpointer c_abi_schema, GError **error); GArrowDataType *
* * *	garrow_data_type_export	(GArrowDataType *data_type, GError **error); gpointer	
i * *	garrow_data_type_equal	(GArrowDataType *data_type, GArrowDataType *other_data_type); gboolean
*c *	garrow_data_type_to_string	(GArrowDataType *data_type); gchar *
i *	garrow_data_type_get_id	(GArrowDataType *data_type); GArrowType
*c *	garrow_data_type_get_name	(GArrowDataType *data_type); gchar *
i *	garrow_fixed_width_data_type_get_bit_width	(GArrowFixedWidthDataType *data_type); gint
*	garrow_null_data_type_new	(void); GArrowNullDataType *
*	garrow_boolean_data_type_new	(void); GArrowBooleanDataType *
i *	garrow_integer_data_type_is_signed	(GArrowIntegerDataType *data_type); gboolean
*	garrow_int8_data_type_new	(void);GArrowInt8DataType *
*	garrow_uint8_data_type_new	(void); GArrowUInt8DataType *
*	garrow_int16_data_type_new	(void); GArrowInt16DataType *
*	garrow_uint16_data_type_new	(void); GArrowUInt16DataType *
*	garrow_int32_data_type_new	(void); GArrowInt32DataType *
*	garrow_uint32_data_type_new	(void); GArrowUInt32DataType *
*	garrow_int64_data_type_new	(void); GArrowInt64DataType *
*	garrow_uint64_data_type_new	(void); GArrowUInt64DataType *
*	garrow_float_data_type_new	(void); GArrowFloatDataType *
*	garrow_double_data_type_new	(void); GArrowDoubleDataType *
*	garrow_binary_data_type_new	(void); GArrowBinaryDataType *
* i	garrow_fixed_size_binary_data_type_new	(gint32 byte_width); GArrowFixedSizeBinaryDataType *
i *	garrow_fixed_size_binary_data_type_get_byte_width	(GArrowFixedSizeBinaryDataType *data_type); gint32
*	garrow_large_binary_data_type_new	(void); GArrowLargeBinaryDataType *
*	garrow_string_data_type_new	(void); GArrowStringDataType *
*	garrow_large_string_data_type_new	(void); GArrowLargeStringDataType *
*	garrow_date32_data_type_new	(void); GArrowDate32DataType *
*	garrow_date64_data_type_new	(void); GArrowDate64DataType *
* i	garrow_timestamp_data_type_new	(GArrowTimeUnit unit); GArrowTimestampDataType *
i *	garrow_timestamp_data_type_get_unit	(GArrowTimestampDataType *timestamp_data_type); GArrowTimeUnit
i *	garrow_time_data_type_get_unit	(GArrowTimeDataType *time_data_type); GArrowTimeUnit
* i *	garrow_time32_data_type_new	(GArrowTimeUnit unit, GError **error); GArrowTime32DataType *
* i *	garrow_time64_data_type_new	(GArrowTimeUnit unit, GError **error); GArrowTime64DataType *
* i i	garrow_decimal_data_type_new	(gint32 precision, gint32 scale); GArrowDecimalDataType *
i *	garrow_decimal_data_type_get_precision	(GArrowDecimalDataType *decimal_data_type); gint32
i *	garrow_decimal_data_type_get_scale	(GArrowDecimalDataType *decimal_data_type); gint32
i	garrow_decimal128_data_type_max_precision	(); gint32
* i i	garrow_decimal128_data_type_new	(gint32 precision, gint32 scale); GArrowDecimal128DataType *
i	garrow_decimal256_data_type_max_precision	(); gint32
* i i	garrow_decimal256_data_type_new	(gint32 precision, gint32 scale); GArrowDecimal256DataType *
*c *	garrow_extension_data_type_get_extension_name	(GArrowExtensionDataType *data_type); gchar *
* * *	garrow_extension_data_type_wrap_array	(GArrowExtensionDataType *data_type, GArrowArray *storage); GArrowExtensionArray *
* * *	garrow_extension_data_type_wrap_chunked_array	(GArrowExtensionDataType *data_type, GArrowChunkedArray *storage); GArrowChunkedArray *
*	garrow_extension_data_type_registry_default	(void); GArrowExtensionDataTypeRegistry *
i * * *	garrow_extension_data_type_registry_register	(GArrowExtensionDataTypeRegistry *registry, GArrowExtensionDataType *data_type, GError **error); gboolean
i * *c *	garrow_extension_data_type_registry_unregister	(GArrowExtensionDataTypeRegistry *registry, const gchar *name, GError **error); gboolean
* * *c	garrow_extension_data_type_registry_lookup	(GArrowExtensionDataTypeRegistry *registry, const gchar *name); GArrowExtensionDataType *
)


NB. =========================================================
NB. Composite Data Type
NB. https://arrow.apache.org/docs/c_glib/arrow-glib/composite-data-type-classes.html
NB. =========================================================

compositeDataTypeBindings =: lib 0 : 0
* *	garrow_list_data_type_new	(GArrowField *field);GArrowListDataType *
* *	garrow_list_data_type_get_value_field	(GArrowListDataType *list_data_type); GArrowField *
* *	garrow_list_data_type_get_field	(GArrowListDataType *list_data_type); GArrowField *
* *	garrow_large_list_data_type_new 	(GArrowField *field); GArrowLargeListDataType *
* *	garrow_large_list_data_type_get_field 	(GArrowLargeListDataType *large_list_data_type);GArrowField *
* *	garrow_struct_data_type_new	(GList *fields);GArrowStructDataType *
i *	garrow_struct_data_type_get_n_fields	(GArrowStructDataType *struct_data_type);gint
* *	garrow_struct_data_type_get_fields	(GArrowStructDataType *struct_data_type);GList *
* * i	garrow_struct_data_type_get_field	(GArrowStructDataType *struct_data_type, gint i); GArrowField *
* * *c	garrow_struct_data_type_get_field_by_name	(GArrowStructDataType *struct_data_type, const gchar *name); GArrowField *
i * *c	garrow_struct_data_type_get_field_index	(GArrowStructDataType *struct_data_type, const gchar *name); gint
* * *	garrow_map_data_type_new	(GArrowDataType *key_type, GArrowDataType *item_type); GArrowMapDataType *
* *	garrow_map_data_type_get_key_type	(GArrowMapDataType *map_data_type); GArrowDataType *
* *	garrow_map_data_type_get_item_type	(GArrowMapDataType *map_data_type); GArrowDataType *
i *	garrow_union_data_type_get_n_fields	(GArrowUnionDataType *union_data_type); gint
* *	garrow_union_data_type_get_fields	(GArrowUnionDataType *union_data_type); GList *
* * i	garrow_union_data_type_get_field	(GArrowUnionDataType *union_data_type, gint i); GArrowField *
* * *	garrow_union_data_type_get_type_codes	(GArrowUnionDataType *union_data_type, gsize *n_type_codes); gint8 *
* * * i	garrow_sparse_union_data_type_new	(GList *fields, gint8 *type_codes, gsize n_type_codes); GArrowSparseUnionDataType *
* * * i	garrow_dense_union_data_type_new	(GList *fields, gint8 *type_codes, gsize n_type_codes); GArrowDenseUnionDataType *
* * * i	garrow_dictionary_data_type_new	(GArrowDataType *index_data_type, GArrowDataType *value_data_type, gboolean ordered); GArrowDictionaryDataType *
* *	garrow_dictionary_data_type_get_index_data_type	(GArrowDictionaryDataType *dictionary_data_type); GArrowDataType *
* *	garrow_dictionary_data_type_get_value_data_type	(GArrowDictionaryDataType *dictionary_data_type); GArrowDataType *
i *	garrow_dictionary_data_type_is_ordered	(GArrowDictionaryDataType *dictionary_data_type); gboolean
)