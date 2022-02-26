NB. =========================================================
NB. Array Builder
NB. https://arrow.apache.org/docs/c_glib/arrow-glib/array-builder-classes.html
NB. =========================================================

arrayBuilderBindings =: lib 0 : 0
ADD TYPES
garrow_array_builder_append_value(GArrowArrayBuilder *builder, VALUE value, GError **error, const gchar *context); gboolean
garrow_array_builder_append_values(VALUE *values, gint64 values_length, const gboolean *is_valids, gint64 is_valids_length, GError **error, const gchar *context, APPEND_FUNCTION append_function); gboolean
garrow_array_builder_append_values(GArrowArrayBuilder *builder, VALUE *values, gint64 values_length, const gboolean *is_valids, gint64 is_valids_length, GError **error, const gchar *context); gboolean
garrow_array_builder_append_values(GArrowArrayBuilder *builder, GBytes **values, gint64 values_length, const gboolean *is_valids, gint64 is_valids_length, GError **error, const gchar *context); gboolean
garrow_array_builder_append_values( GArrowArrayBuilder *builder, VALUE *values, gint64 values_length, const gboolean *is_valids, gint64 is_valids_length, GError **error, const gchar *context, GET_VALUE_FUNCTION get_value_function); gboolean
garrow_array_builder_append_values(GArrowArrayBuilder *builder, GBytes *values, const gboolean *is_valids, gint64 is_valids_length, GError **error, const gchar *context); gboolean
garrow_array_builder_finalize(GObject *object); static void
garrow_array_builder_set_property(GObject *object, guint prop_id, const GValue *value, GParamSpec *pspec); static void
garrow_array_builder_get_property(GObject *object, guint prop_id, GValue *value, GParamSpec *pspec); static void
garrow_array_builder_init(GArrowArrayBuilder *builder); static void
garrow_array_builder_class_init(GArrowArrayBuilderClass *klass); static void
garrow_array_builder_new(const std::shared_ptr<arrow::DataType> &type, GError **error, const char *context); static GArrowArrayBuilder *
garrow_array_builder_release_ownership(GArrowArrayBuilder *builder); void
garrow_array_builder_get_value_data_type(GArrowArrayBuilder *builder); GArrowDataType *
garrow_array_builder_get_value_type(GArrowArrayBuilder *builder); GArrowType
garrow_array_builder_finish(GArrowArrayBuilder *builder, GError **error); GArrowArray *
garrow_array_builder_reset(GArrowArrayBuilder *builder); void
garrow_array_builder_get_capacity(GArrowArrayBuilder *builder); gint64
garrow_array_builder_get_length(GArrowArrayBuilder *builder); gint64
garrow_array_builder_get_n_nulls(GArrowArrayBuilder *builder); gint64
garrow_array_builder_resize(GArrowArrayBuilder *builder, gint64 capacity, GError **error); gboolean
garrow_array_builder_reserve(GArrowArrayBuilder *builder, gint64 additional_capacity, GError **error); gboolean
garrow_array_builder_append_null(GArrowArrayBuilder *builder, GError **error); gboolean
garrow_array_builder_append_nulls(GArrowArrayBuilder *builder, gint64 n, GError **error); gboolean
garrow_array_builder_append_empty_value(GArrowArrayBuilder *builder, GError **error); gboolean
garrow_array_builder_append_empty_values(GArrowArrayBuilder *builder, gint64 n, GError **error); gboolean
garrow_null_array_builder_init(GArrowNullArrayBuilder *builder); static void
garrow_null_array_builder_class_init(GArrowNullArrayBuilderClass *klass); static void
garrow_null_array_builder_new(void); GArrowNullArrayBuilder *
garrow_null_array_builder_append_null(GArrowNullArrayBuilder *builder, GError **error); gboolean
garrow_null_array_builder_append_nulls(GArrowNullArrayBuilder *builder, gint64 n, GError **error); gboolean
garrow_boolean_array_builder_init(GArrowBooleanArrayBuilder *builder); static void
garrow_boolean_array_builder_class_init(GArrowBooleanArrayBuilderClass *klass); static void
garrow_boolean_array_builder_new(void); GArrowBooleanArrayBuilder *
garrow_boolean_array_builder_append(GArrowBooleanArrayBuilder *builder, gboolean value, GError **error); gboolean
garrow_boolean_array_builder_append_value(GArrowBooleanArrayBuilder *builder, gboolean value, GError **error); gboolean
garrow_boolean_array_builder_append_values(GArrowBooleanArrayBuilder *builder, const gboolean *values, gint64 values_length, const gboolean *is_valids, gint64 is_valids_length, GError **error); gboolean
garrow_boolean_array_builder_append_null(GArrowBooleanArrayBuilder *builder, GError **error); gboolean
garrow_boolean_array_builder_append_nulls(GArrowBooleanArrayBuilder *builder, gint64 n, GError **error); gboolean
garrow_int_array_builder_init(GArrowIntArrayBuilder *builder); static void
garrow_int_array_builder_class_init(GArrowIntArrayBuilderClass *klass); static void
garrow_int_array_builder_new(void); GArrowIntArrayBuilder *
garrow_int_array_builder_append(GArrowIntArrayBuilder *builder, gint64 value, GError **error); gboolean
garrow_int_array_builder_append_value(GArrowIntArrayBuilder *builder, gint64 value, GError **error); gboolean
garrow_int_array_builder_append_values(GArrowIntArrayBuilder *builder, const gint64 *values, gint64 values_length, const gboolean *is_valids, gint64 is_valids_length, GError **error); gboolean
garrow_int_array_builder_append_null(GArrowIntArrayBuilder *builder, GError **error); gboolean
garrow_int_array_builder_append_nulls(GArrowIntArrayBuilder *builder, gint64 n, GError **error); gboolean
garrow_uint_array_builder_init(GArrowUIntArrayBuilder *builder); static void
garrow_uint_array_builder_class_init(GArrowUIntArrayBuilderClass *klass); static void
garrow_uint_array_builder_new(void); GArrowUIntArrayBuilder *
garrow_uint_array_builder_append(GArrowUIntArrayBuilder *builder, guint64 value, GError **error); gboolean
garrow_uint_array_builder_append_value(GArrowUIntArrayBuilder *builder, guint64 value, GError **error); gboolean
garrow_uint_array_builder_append_values(GArrowUIntArrayBuilder *builder, const guint64 *values, gint64 values_length, const gboolean *is_valids, gint64 is_valids_length, GError **error); gboolean
garrow_uint_array_builder_append_null(GArrowUIntArrayBuilder *builder, GError **error); gboolean
garrow_uint_array_builder_append_nulls(GArrowUIntArrayBuilder *builder, gint64 n, GError **error); gboolean
garrow_int8_array_builder_init(GArrowInt8ArrayBuilder *builder); static void
garrow_int8_array_builder_class_init(GArrowInt8ArrayBuilderClass *klass); static void
garrow_int8_array_builder_new(void); GArrowInt8ArrayBuilder *
garrow_int8_array_builder_append(GArrowInt8ArrayBuilder *builder, gint8 value, GError **error); gboolean
garrow_int8_array_builder_append_value(GArrowInt8ArrayBuilder *builder, gint8 value, GError **error); gboolean
garrow_int8_array_builder_append_values(GArrowInt8ArrayBuilder *builder, const gint8 *values, gint64 values_length, const gboolean *is_valids, gint64 is_valids_length, GError **error); gboolean
garrow_int8_array_builder_append_null(GArrowInt8ArrayBuilder *builder, GError **error); gboolean
garrow_int8_array_builder_append_nulls(GArrowInt8ArrayBuilder *builder, gint64 n, GError **error); gboolean
garrow_uint8_array_builder_init(GArrowUInt8ArrayBuilder *builder); static void
garrow_uint8_array_builder_class_init(GArrowUInt8ArrayBuilderClass *klass); static void
garrow_uint8_array_builder_new(void); GArrowUInt8ArrayBuilder *
garrow_uint8_array_builder_append(GArrowUInt8ArrayBuilder *builder, guint8 value, GError **error); gboolean
garrow_uint8_array_builder_append_value(GArrowUInt8ArrayBuilder *builder, guint8 value, GError **error); gboolean
garrow_uint8_array_builder_append_values(GArrowUInt8ArrayBuilder *builder, const guint8 *values, gint64 values_length, const gboolean *is_valids, gint64 is_valids_length, GError **error); gboolean
garrow_uint8_array_builder_append_null(GArrowUInt8ArrayBuilder *builder, GError **error); gboolean
garrow_uint8_array_builder_append_nulls(GArrowUInt8ArrayBuilder *builder, gint64 n, GError **error); gboolean
garrow_int16_array_builder_init(GArrowInt16ArrayBuilder *builder); static void
garrow_int16_array_builder_class_init(GArrowInt16ArrayBuilderClass *klass); static void
garrow_int16_array_builder_new(void); GArrowInt16ArrayBuilder *
garrow_int16_array_builder_append(GArrowInt16ArrayBuilder *builder, gint16 value, GError **error); gboolean
garrow_int16_array_builder_append_value(GArrowInt16ArrayBuilder *builder, gint16 value, GError **error); gboolean
garrow_int16_array_builder_append_values(GArrowInt16ArrayBuilder *builder, const gint16 *values, gint64 values_length, const gboolean *is_valids, gint64 is_valids_length, GError **error); gboolean
garrow_int16_array_builder_append_null(GArrowInt16ArrayBuilder *builder, GError **error); gboolean
garrow_int16_array_builder_append_nulls(GArrowInt16ArrayBuilder *builder, gint64 n, GError **error); gboolean
garrow_uint16_array_builder_init(GArrowUInt16ArrayBuilder *builder); static void
garrow_uint16_array_builder_class_init(GArrowUInt16ArrayBuilderClass *klass); static void
garrow_uint16_array_builder_new(void); GArrowUInt16ArrayBuilder *
garrow_uint16_array_builder_append(GArrowUInt16ArrayBuilder *builder, guint16 value, GError **error); gboolean
garrow_uint16_array_builder_append_value(GArrowUInt16ArrayBuilder *builder, guint16 value, GError **error); gboolean
garrow_uint16_array_builder_append_values(GArrowUInt16ArrayBuilder *builder, const guint16 *values, gint64 values_length, const gboolean *is_valids, gint64 is_valids_length, GError **error); gboolean
garrow_uint16_array_builder_append_null(GArrowUInt16ArrayBuilder *builder, GError **error); gboolean
garrow_uint16_array_builder_append_nulls(GArrowUInt16ArrayBuilder *builder, gint64 n, GError **error); gboolean
garrow_int32_array_builder_init(GArrowInt32ArrayBuilder *builder); static void
garrow_int32_array_builder_class_init(GArrowInt32ArrayBuilderClass *klass); static void
garrow_int32_array_builder_new(void); GArrowInt32ArrayBuilder *
garrow_int32_array_builder_append(GArrowInt32ArrayBuilder *builder, gint32 value, GError **error); gboolean
garrow_int32_array_builder_append_value(GArrowInt32ArrayBuilder *builder, gint32 value, GError **error); gboolean
garrow_int32_array_builder_append_values(GArrowInt32ArrayBuilder *builder, const gint32 *values, gint64 values_length, const gboolean *is_valids, gint64 is_valids_length, GError **error); gboolean
garrow_int32_array_builder_append_null(GArrowInt32ArrayBuilder *builder, GError **error); gboolean
garrow_int32_array_builder_append_nulls(GArrowInt32ArrayBuilder *builder, gint64 n, GError **error); gboolean
garrow_uint32_array_builder_init(GArrowUInt32ArrayBuilder *builder); static void
garrow_uint32_array_builder_class_init(GArrowUInt32ArrayBuilderClass *klass); static void
garrow_uint32_array_builder_new(void); GArrowUInt32ArrayBuilder *
garrow_uint32_array_builder_append(GArrowUInt32ArrayBuilder *builder, guint32 value, GError **error); gboolean
garrow_uint32_array_builder_append_value(GArrowUInt32ArrayBuilder *builder, guint32 value, GError **error); gboolean
garrow_uint32_array_builder_append_values(GArrowUInt32ArrayBuilder *builder, const guint32 *values, gint64 values_length, const gboolean *is_valids, gint64 is_valids_length, GError **error); gboolean
garrow_uint32_array_builder_append_null(GArrowUInt32ArrayBuilder *builder, GError **error); gboolean
garrow_uint32_array_builder_append_nulls(GArrowUInt32ArrayBuilder *builder, gint64 n, GError **error); gboolean
garrow_int64_array_builder_init(GArrowInt64ArrayBuilder *builder); static void
garrow_int64_array_builder_class_init(GArrowInt64ArrayBuilderClass *klass); static void
garrow_int64_array_builder_new(void); GArrowInt64ArrayBuilder *
garrow_int64_array_builder_append(GArrowInt64ArrayBuilder *builder, gint64 value, GError **error); gboolean
garrow_int64_array_builder_append_value(GArrowInt64ArrayBuilder *builder, gint64 value, GError **error); gboolean
garrow_int64_array_builder_append_values(GArrowInt64ArrayBuilder *builder, const gint64 *values, gint64 values_length, const gboolean *is_valids, gint64 is_valids_length, GError **error); gboolean
garrow_int64_array_builder_append_null(GArrowInt64ArrayBuilder *builder, GError **error); gboolean
garrow_int64_array_builder_append_nulls(GArrowInt64ArrayBuilder *builder, gint64 n, GError **error); gboolean
garrow_uint64_array_builder_init(GArrowUInt64ArrayBuilder *builder); static void
garrow_uint64_array_builder_class_init(GArrowUInt64ArrayBuilderClass *klass); static void
garrow_uint64_array_builder_new(void); GArrowUInt64ArrayBuilder *
garrow_uint64_array_builder_append(GArrowUInt64ArrayBuilder *builder, guint64 value, GError **error); gboolean
garrow_uint64_array_builder_append_value(GArrowUInt64ArrayBuilder *builder, guint64 value, GError **error); gboolean
garrow_uint64_array_builder_append_values(GArrowUInt64ArrayBuilder *builder, const guint64 *values, gint64 values_length, const gboolean *is_valids, gint64 is_valids_length, GError **error); gboolean
garrow_uint64_array_builder_append_null(GArrowUInt64ArrayBuilder *builder, GError **error); gboolean
garrow_uint64_array_builder_append_nulls(GArrowUInt64ArrayBuilder *builder, gint64 n, GError **error); gboolean
garrow_float_array_builder_init(GArrowFloatArrayBuilder *builder); static void
garrow_float_array_builder_class_init(GArrowFloatArrayBuilderClass *klass); static void
garrow_float_array_builder_new(void); GArrowFloatArrayBuilder *
garrow_float_array_builder_append(GArrowFloatArrayBuilder *builder, gfloat value, GError **error); gboolean
garrow_float_array_builder_append_value(GArrowFloatArrayBuilder *builder, gfloat value, GError **error); gboolean
garrow_float_array_builder_append_values(GArrowFloatArrayBuilder *builder, const gfloat *values, gint64 values_length, const gboolean *is_valids, gint64 is_valids_length, GError **error); gboolean
garrow_float_array_builder_append_null(GArrowFloatArrayBuilder *builder, GError **error); gboolean
garrow_float_array_builder_append_nulls(GArrowFloatArrayBuilder *builder, gint64 n, GError **error); gboolean
garrow_double_array_builder_init(GArrowDoubleArrayBuilder *builder); static void
garrow_double_array_builder_class_init(GArrowDoubleArrayBuilderClass *klass); static void
garrow_double_array_builder_new(void); GArrowDoubleArrayBuilder *
garrow_double_array_builder_append(GArrowDoubleArrayBuilder *builder, gdouble value, GError **error); gboolean
garrow_double_array_builder_append_value(GArrowDoubleArrayBuilder *builder, gdouble value, GError **error); gboolean
garrow_double_array_builder_append_values(GArrowDoubleArrayBuilder *builder, const gdouble *values, gint64 values_length, const gboolean *is_valids, gint64 is_valids_length, GError **error); gboolean
garrow_double_array_builder_append_null(GArrowDoubleArrayBuilder *builder, GError **error); gboolean
garrow_double_array_builder_append_nulls(GArrowDoubleArrayBuilder *builder, gint64 n, GError **error); gboolean
garrow_binary_array_builder_init(GArrowBinaryArrayBuilder *builder); static void
garrow_binary_array_builder_class_init(GArrowBinaryArrayBuilderClass *klass); static void
garrow_binary_array_builder_new(void); GArrowBinaryArrayBuilder *
garrow_binary_array_builder_append(GArrowBinaryArrayBuilder *builder, const guint8 *value, gint32 length, GError **error); gboolean
garrow_binary_array_builder_append_value(GArrowBinaryArrayBuilder *builder, const guint8 *value, gint32 length, GError **error); gboolean
garrow_binary_array_builder_append_value_bytes(GArrowBinaryArrayBuilder *builder, GBytes *value, GError **error); gboolean
garrow_binary_array_builder_append_values(GArrowBinaryArrayBuilder *builder, GBytes **values, gint64 values_length, const gboolean *is_valids, gint64 is_valids_length, GError **error); gboolean
garrow_binary_array_builder_append_null(GArrowBinaryArrayBuilder *builder, GError **error); gboolean
garrow_binary_array_builder_append_nulls(GArrowBinaryArrayBuilder *builder, gint64 n, GError **error); gboolean
garrow_large_binary_array_builder_init(GArrowLargeBinaryArrayBuilder *builder); static void
garrow_large_binary_array_builder_class_init(GArrowLargeBinaryArrayBuilderClass *klass); static void
garrow_large_binary_array_builder_new(void); GArrowLargeBinaryArrayBuilder *
garrow_large_binary_array_builder_append_value(GArrowLargeBinaryArrayBuilder *builder, const guint8 *value, gint64 length, GError **error); gboolean
garrow_large_binary_array_builder_append_value_bytes(GArrowLargeBinaryArrayBuilder *builder, GBytes *value, GError **error); gboolean
garrow_large_binary_array_builder_append_values(GArrowLargeBinaryArrayBuilder *builder, GBytes **values, gint64 values_length, const gboolean *is_valids, gint64 is_valids_length, GError **error); gboolean
garrow_large_binary_array_builder_append_null(GArrowLargeBinaryArrayBuilder *builder, GError **error); gboolean
garrow_large_binary_array_builder_append_nulls(GArrowLargeBinaryArrayBuilder *builder, gint64 n, GError **error); gboolean
garrow_string_array_builder_init(GArrowStringArrayBuilder *builder); static void
garrow_string_array_builder_class_init(GArrowStringArrayBuilderClass *klass); static void
garrow_string_array_builder_new(void); GArrowStringArrayBuilder *
garrow_string_array_builder_append(GArrowStringArrayBuilder *builder, const gchar *value, GError **error); gboolean
garrow_string_array_builder_append_value(GArrowStringArrayBuilder *builder, const gchar *value, GError **error); gboolean
garrow_string_array_builder_append_string(GArrowStringArrayBuilder *builder, const gchar *value, GError **error); gboolean
garrow_string_array_builder_append_values(GArrowStringArrayBuilder *builder, const gchar **values, gint64 values_length, const gboolean *is_valids, gint64 is_valids_length, GError **error); gboolean
garrow_string_array_builder_append_strings(GArrowStringArrayBuilder *builder, const gchar **values, gint64 values_length, const gboolean *is_valids, gint64 is_valids_length, GError **error); gboolean
garrow_large_string_array_builder_init(GArrowLargeStringArrayBuilder *builder); static void
garrow_large_string_array_builder_class_init(GArrowLargeStringArrayBuilderClass *klass); static void
garrow_large_string_array_builder_new(void); GArrowLargeStringArrayBuilder *
garrow_large_string_array_builder_append_string(GArrowLargeStringArrayBuilder *builder, const gchar *value, GError **error); gboolean
garrow_large_string_array_builder_append_strings(GArrowLargeStringArrayBuilder *builder, const gchar **values, gint64 values_length, const gboolean *is_valids, gint64 is_valids_length, GError **error); gboolean
garrow_fixed_size_binary_array_builder_init( GArrowFixedSizeBinaryArrayBuilder *builder); static void
garrow_fixed_size_binary_array_builder_class_init( GArrowFixedSizeBinaryArrayBuilderClass *klass); static void
garrow_fixed_size_binary_array_builder_new( GArrowFixedSizeBinaryDataType *data_type); GArrowFixedSizeBinaryArrayBuilder *
garrow_fixed_size_binary_array_builder_append_value( GArrowFixedSizeBinaryArrayBuilder *builder, const guint8 *value, gint32 length, GError **error); gboolean
garrow_fixed_size_binary_array_builder_append_value_bytes( GArrowFixedSizeBinaryArrayBuilder *builder, GBytes *value, GError **error); gboolean
garrow_fixed_size_binary_array_builder_append_values( GArrowFixedSizeBinaryArrayBuilder *builder, GBytes **values, gint64 values_length, const gboolean *is_valids, gint64 is_valids_length, GError **error); gboolean
garrow_fixed_size_binary_array_builder_append_values_packed( GArrowFixedSizeBinaryArrayBuilder *builder, GBytes *values, const gboolean *is_valids, gint64 is_valids_length, GError **error); gboolean
garrow_date32_array_builder_init(GArrowDate32ArrayBuilder *builder); static void
garrow_date32_array_builder_class_init(GArrowDate32ArrayBuilderClass *klass); static void
garrow_date32_array_builder_new(void); GArrowDate32ArrayBuilder *
garrow_date32_array_builder_append(GArrowDate32ArrayBuilder *builder, gint32 value, GError **error); gboolean
garrow_date32_array_builder_append_value(GArrowDate32ArrayBuilder *builder, gint32 value, GError **error); gboolean
garrow_date32_array_builder_append_values(GArrowDate32ArrayBuilder *builder, const gint32 *values, gint64 values_length, const gboolean *is_valids, gint64 is_valids_length, GError **error); gboolean
garrow_date32_array_builder_append_null(GArrowDate32ArrayBuilder *builder, GError **error); gboolean
garrow_date32_array_builder_append_nulls(GArrowDate32ArrayBuilder *builder, gint64 n, GError **error); gboolean
garrow_date64_array_builder_init(GArrowDate64ArrayBuilder *builder); static void
garrow_date64_array_builder_class_init(GArrowDate64ArrayBuilderClass *klass); static void
garrow_date64_array_builder_new(void); GArrowDate64ArrayBuilder *
garrow_date64_array_builder_append(GArrowDate64ArrayBuilder *builder, gint64 value, GError **error); gboolean
garrow_date64_array_builder_append_value(GArrowDate64ArrayBuilder *builder, gint64 value, GError **error); gboolean
garrow_date64_array_builder_append_values(GArrowDate64ArrayBuilder *builder, const gint64 *values, gint64 values_length, const gboolean *is_valids, gint64 is_valids_length, GError **error); gboolean
garrow_date64_array_builder_append_null(GArrowDate64ArrayBuilder *builder, GError **error); gboolean
garrow_date64_array_builder_append_nulls(GArrowDate64ArrayBuilder *builder, gint64 n, GError **error); gboolean
garrow_timestamp_array_builder_init(GArrowTimestampArrayBuilder *builder); static void
garrow_timestamp_array_builder_class_init(GArrowTimestampArrayBuilderClass *klass); static void
garrow_timestamp_array_builder_new(GArrowTimestampDataType *data_type); GArrowTimestampArrayBuilder *
garrow_timestamp_array_builder_append(GArrowTimestampArrayBuilder *builder, gint64 value, GError **error); gboolean
garrow_timestamp_array_builder_append_value(GArrowTimestampArrayBuilder *builder, gint64 value, GError **error); gboolean
garrow_timestamp_array_builder_append_values(GArrowTimestampArrayBuilder *builder, const gint64 *values, gint64 values_length, const gboolean *is_valids, gint64 is_valids_length, GError **error); gboolean
garrow_timestamp_array_builder_append_null(GArrowTimestampArrayBuilder *builder, GError **error); gboolean
garrow_timestamp_array_builder_append_nulls(GArrowTimestampArrayBuilder *builder, gint64 n, GError **error); gboolean
garrow_time32_array_builder_init(GArrowTime32ArrayBuilder *builder); static void
garrow_time32_array_builder_class_init(GArrowTime32ArrayBuilderClass *klass); static void
garrow_time32_array_builder_new(GArrowTime32DataType *data_type); GArrowTime32ArrayBuilder *
garrow_time32_array_builder_append(GArrowTime32ArrayBuilder *builder, gint32 value, GError **error); gboolean
garrow_time32_array_builder_append_value(GArrowTime32ArrayBuilder *builder, gint32 value, GError **error); gboolean
garrow_time32_array_builder_append_values(GArrowTime32ArrayBuilder *builder, const gint32 *values, gint64 values_length, const gboolean *is_valids, gint64 is_valids_length, GError **error); gboolean
garrow_time32_array_builder_append_null(GArrowTime32ArrayBuilder *builder, GError **error); gboolean
garrow_time32_array_builder_append_nulls(GArrowTime32ArrayBuilder *builder, gint64 n, GError **error); gboolean
garrow_time64_array_builder_init(GArrowTime64ArrayBuilder *builder); static void
garrow_time64_array_builder_class_init(GArrowTime64ArrayBuilderClass *klass); static void
garrow_time64_array_builder_new(GArrowTime64DataType *data_type); GArrowTime64ArrayBuilder *
garrow_time64_array_builder_append(GArrowTime64ArrayBuilder *builder, gint64 value, GError **error); gboolean
garrow_time64_array_builder_append_value(GArrowTime64ArrayBuilder *builder, gint64 value, GError **error); gboolean
garrow_time64_array_builder_append_values(GArrowTime64ArrayBuilder *builder, const gint64 *values, gint64 values_length, const gboolean *is_valids, gint64 is_valids_length, GError **error); gboolean
garrow_time64_array_builder_append_null(GArrowTime64ArrayBuilder *builder, GError **error); gboolean
garrow_time64_array_builder_append_nulls(GArrowTime64ArrayBuilder *builder, gint64 n, GError **error); gboolean
garrow_binary_dictionary_array_builder_init(GArrowBinaryDictionaryArrayBuilder *builder); static void
garrow_binary_dictionary_array_builder_class_init(GArrowBinaryDictionaryArrayBuilderClass *klass); static void
garrow_binary_dictionary_array_builder_new(void); GArrowBinaryDictionaryArrayBuilder *
garrow_binary_dictionary_array_builder_append_null(GArrowBinaryDictionaryArrayBuilder *builder, GError **error); gboolean
garrow_binary_dictionary_array_builder_append_value(GArrowBinaryDictionaryArrayBuilder *builder, const guint8 *value, gint32 length, GError **error); gboolean
garrow_binary_dictionary_array_builder_append_value_bytes(GArrowBinaryDictionaryArrayBuilder *builder, GBytes *value, GError **error); gboolean
garrow_binary_dictionary_array_builder_append_array(GArrowBinaryDictionaryArrayBuilder *builder, GArrowBinaryArray *array, GError **error); gboolean
garrow_binary_dictionary_array_builder_append_indices(GArrowBinaryDictionaryArrayBuilder *builder, const gint64 *values, gint64 values_length, const gboolean *is_valids, gint64 is_valids_length, GError **error); gboolean
garrow_binary_dictionary_array_builder_get_dictionary_length(GArrowBinaryDictionaryArrayBuilder *builder); gint64
garrow_binary_dictionary_array_builder_finish_delta(GArrowBinaryDictionaryArrayBuilder* builder, GArrowArray **out_indices, GArrowArray **out_delta, GError **error); gboolean
garrow_binary_dictionary_array_builder_insert_memo_values(GArrowBinaryDictionaryArrayBuilder *builder, GArrowBinaryArray *values, GError **error); gboolean
garrow_binary_dictionary_array_builder_reset_full(GArrowBinaryDictionaryArrayBuilder *builder); void
garrow_string_dictionary_array_builder_init(GArrowStringDictionaryArrayBuilder *builder); static void
garrow_string_dictionary_array_builder_class_init(GArrowStringDictionaryArrayBuilderClass *klass); static void
garrow_string_dictionary_array_builder_new(void); GArrowStringDictionaryArrayBuilder *
garrow_string_dictionary_array_builder_append_null(GArrowStringDictionaryArrayBuilder *builder, GError **error); gboolean
garrow_string_dictionary_array_builder_append_string(GArrowStringDictionaryArrayBuilder *builder, const gchar *value, GError **error); gboolean
garrow_string_dictionary_array_builder_append_array(GArrowStringDictionaryArrayBuilder *builder, GArrowStringArray *array, GError **error); gboolean
garrow_string_dictionary_array_builder_append_indices(GArrowStringDictionaryArrayBuilder *builder, const gint64 *values, gint64 values_length, const gboolean *is_valids, gint64 is_valids_length, GError **error); gboolean
garrow_string_dictionary_array_builder_get_dictionary_length(GArrowStringDictionaryArrayBuilder *builder); gint64
garrow_string_dictionary_array_builder_finish_delta(GArrowStringDictionaryArrayBuilder* builder, GArrowArray **out_indices, GArrowArray **out_delta, GError **error); gboolean
garrow_string_dictionary_array_builder_insert_memo_values(GArrowStringDictionaryArrayBuilder *builder, GArrowStringArray *values, GError **error); gboolean
garrow_string_dictionary_array_builder_reset_full(GArrowStringDictionaryArrayBuilder *builder); void
garrow_list_array_builder_dispose(GObject *object); static void
garrow_list_array_builder_init(GArrowListArrayBuilder *builder); static void
garrow_list_array_builder_class_init(GArrowListArrayBuilderClass *klass); static void
garrow_list_array_builder_new(GArrowListDataType *data_type, GError **error); GArrowListArrayBuilder *
garrow_list_array_builder_append(GArrowListArrayBuilder *builder, GError **error); gboolean
garrow_list_array_builder_append_value(GArrowListArrayBuilder *builder, GError **error); gboolean
garrow_list_array_builder_append_null(GArrowListArrayBuilder *builder, GError **error); gboolean
garrow_list_array_builder_get_value_builder(GArrowListArrayBuilder *builder); GArrowArrayBuilder *
garrow_large_list_array_builder_dispose(GObject *object); static void
garrow_large_list_array_builder_init(GArrowLargeListArrayBuilder *builder); static void
garrow_large_list_array_builder_class_init(GArrowLargeListArrayBuilderClass *klass); static void
garrow_large_list_array_builder_new(GArrowLargeListDataType *data_type, GError **error); GArrowLargeListArrayBuilder *
garrow_large_list_array_builder_append_value(GArrowLargeListArrayBuilder *builder, GError **error); gboolean
garrow_large_list_array_builder_append_null(GArrowLargeListArrayBuilder *builder, GError **error); gboolean
garrow_large_list_array_builder_get_value_builder(GArrowLargeListArrayBuilder *builder); GArrowArrayBuilder *
garrow_struct_array_builder_dispose(GObject *object); static void
garrow_struct_array_builder_init(GArrowStructArrayBuilder *builder); static void
garrow_struct_array_builder_class_init(GArrowStructArrayBuilderClass *klass); static void
garrow_struct_array_builder_new(GArrowStructDataType *data_type, GError **error); GArrowStructArrayBuilder *
garrow_struct_array_builder_append(GArrowStructArrayBuilder *builder, GError **error); gboolean
garrow_struct_array_builder_append_value(GArrowStructArrayBuilder *builder, GError **error); gboolean
garrow_struct_array_builder_append_null(GArrowStructArrayBuilder *builder, GError **error); gboolean
garrow_struct_array_builder_get_field_builder(GArrowStructArrayBuilder *builder, gint i); GArrowArrayBuilder *
garrow_struct_array_builder_get_field_builders(GArrowStructArrayBuilder *builder); GList *
garrow_map_array_builder_dispose(GObject *object); static void
garrow_map_array_builder_init(GArrowMapArrayBuilder *builder); static void
garrow_map_array_builder_class_init(GArrowMapArrayBuilderClass *klass); static void
garrow_map_array_builder_new(GArrowMapDataType *data_type, GError **error); GArrowMapArrayBuilder *
garrow_map_array_builder_append_value(GArrowMapArrayBuilder *builder, GError **error); gboolean
garrow_map_array_builder_append_values(GArrowMapArrayBuilder *builder, const gint32 *offsets, gint64 offsets_length, const gboolean *is_valids, gint64 is_valids_length, GError **error); gboolean
garrow_map_array_builder_append_null(GArrowMapArrayBuilder *builder, GError **error); gboolean
garrow_map_array_builder_append_nulls(GArrowMapArrayBuilder *builder, gint64 n, GError **error); gboolean
garrow_map_array_builder_get_key_builder(GArrowMapArrayBuilder *builder); GArrowArrayBuilder *
garrow_map_array_builder_get_item_builder(GArrowMapArrayBuilder *builder); GArrowArrayBuilder *
garrow_map_array_builder_get_value_builder(GArrowMapArrayBuilder *builder); GArrowArrayBuilder *
garrow_decimal128_array_builder_init(GArrowDecimal128ArrayBuilder *builder); static void
garrow_decimal128_array_builder_class_init(GArrowDecimal128ArrayBuilderClass *klass); static void
garrow_decimal128_array_builder_new(GArrowDecimal128DataType *data_type); GArrowDecimal128ArrayBuilder *
garrow_decimal128_array_builder_append(GArrowDecimal128ArrayBuilder *builder, GArrowDecimal128 *value, GError **error); gboolean
garrow_decimal128_array_builder_append_value(GArrowDecimal128ArrayBuilder *builder, GArrowDecimal128 *value, GError **error); gboolean
garrow_decimal128_array_builder_append_values(GArrowDecimal128ArrayBuilder *builder, GArrowDecimal128 **values, gint64 values_length, const gboolean *is_valids, gint64 is_valids_length, GError **error); gboolean
garrow_decimal128_array_builder_append_null(GArrowDecimal128ArrayBuilder *builder, GError **error); gboolean
garrow_decimal256_array_builder_init(GArrowDecimal256ArrayBuilder *builder); static void
garrow_decimal256_array_builder_class_init(GArrowDecimal256ArrayBuilderClass *klass); static void
garrow_decimal256_array_builder_new(GArrowDecimal256DataType *data_type); GArrowDecimal256ArrayBuilder *
garrow_decimal256_array_builder_append_value(GArrowDecimal256ArrayBuilder *builder, GArrowDecimal256 *value, GError **error); gboolean
garrow_decimal256_array_builder_append_values(GArrowDecimal256ArrayBuilder *builder, GArrowDecimal256 **values, gint64 values_length, const gboolean *is_valids, gint64 is_valids_length, GError **error); gboolean
garrow_array_builder_new_raw(arrow::ArrayBuilder *arrow_builder, GType type); ArrowArrayBuilder *
garrow_array_builder_get_raw(GArrowArrayBuilder *builder); arrow::ArrayBuilder *
)