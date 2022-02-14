NB. =========================================================
NB. Compute
NB. https://arrow.apache.org/docs/c_glib/arrow-glib/compute.html
NB. =========================================================

computeBindings =: lib 0 : 0
ADD TYPES
garrow_numeric_array_sum(GArrowArrayType array, GError **error, const gchar *tag, typename ArrowType::c_type default_value); typename ArrowType::c_type
garrow_numeric_array_compare(GArrowArrayType array, VALUE value, GArrowCompareOptions *options, GError **error, const gchar *tag); GArrowBooleanArray *
garrow_take(arrow::Datum arrow_values, arrow::Datum arrow_indices, GArrowTakeOptions *options, GArrowTypeNewRaw garrow_type_new_raw, GError **error, const gchar *tag); auto
garrow_sort_key_equal_raw(const arrow::compute::SortKey &sort_key, const arrow::compute::SortKey &other_sort_key); bool
garrow_execute_context_finalize(GObject *object); static void
garrow_execute_context_init(GArrowExecuteContext *object); static void
garrow_execute_context_class_init(GArrowExecuteContextClass *klass); static void
garrow_execute_context_new(void)G_DEFINE_INTERFACE(GArrowFunctionOptions, garrow_function_options, G_TYPE_INVALID); GArrowExecuteContext *
garrow_function_options_default_init(GArrowFunctionOptionsInterface *iface); static void
garrow_function_finalize(GObject *object); static void
garrow_function_set_property(GObject *object, guint prop_id, const GValue *value, GParamSpec *pspec); static void
garrow_function_init(GArrowFunction *object); static void
garrow_function_class_init(GArrowFunctionClass *klass); static void
garrow_function_find(const gchar *name); GArrowFunction *
garrow_function_execute(GArrowFunction *function, GList *args, GArrowFunctionOptions *options, GArrowExecuteContext *context, GError **error); GArrowDatum *
garrow_cast_options_get_raw_function_options(GArrowFunctionOptions *options); static arrow::compute::FunctionOptions *
garrow_cast_options_function_options_interface_init(GArrowFunctionOptionsInterface *iface); static void
garrow_cast_options_dispose(GObject *object); static void
garrow_cast_options_finalize(GObject *object); static void
garrow_cast_options_set_property(GObject *object , guint prop_id , const GValue *value , GParamSpec *pspec); static void
garrow_cast_options_get_property(GObject *object , guint prop_id , GValue *value , GParamSpec *pspec); static void
garrow_cast_options_init(GArrowCastOptions *object); static void
garrow_cast_options_class_init(GArrowCastOptionsClass *klass); static void
garrow_cast_options_new(void); GArrowCastOptions *
garrow_scalar_aggregate_options_get_raw_function_options(GArrowFunctionOptions *options); static arrow::compute::FunctionOptions *
garrow_scalar_aggregate_options_function_options_interface_init(GArrowFunctionOptionsInterface *iface); static void
garrow_scalar_aggregate_options_finalize(GObject *object); static void
garrow_scalar_aggregate_options_set_property(GObject *object, guint prop_id, const GValue *value, GParamSpec *pspec); static void
garrow_scalar_aggregate_options_get_property(GObject *object, guint prop_id, GValue *value, GParamSpec *pspec); static void
garrow_scalar_aggregate_options_init(GArrowScalarAggregateOptions *object); static void
garrow_scalar_aggregate_options_class_init(GArrowScalarAggregateOptionsClass *klass); static void
garrow_scalar_aggregate_options_new(void); GArrowScalarAggregateOptions *
garrow_filter_options_get_raw_function_options(GArrowFunctionOptions *options); static arrow::compute::FunctionOptions *
garrow_filter_options_function_options_interface_init(GArrowFunctionOptionsInterface *iface); static void
garrow_filter_options_finalize(GObject *object); static void
garrow_filter_options_set_property(GObject *object, guint prop_id, const GValue *value, GParamSpec *pspec); static void
garrow_filter_options_get_property(GObject *object , guint prop_id , GValue *value , GParamSpec *pspec); static void
garrow_filter_options_init(GArrowFilterOptions *object); static void
garrow_filter_options_class_init(GArrowFilterOptionsClass *klass); static void
garrow_filter_options_new(void); GArrowFilterOptions *
garrow_take_options_get_raw_function_options(GArrowFunctionOptions *options); GArrowTakeOptionsPrivate;static arrow::compute::FunctionOptions *
garrow_take_options_function_options_interface_init(GArrowFunctionOptionsInterface *iface); static void
garrow_take_options_finalize(GObject *object); static void
garrow_take_options_init(GArrowTakeOptions *object); static void
garrow_take_options_class_init(GArrowTakeOptionsClass *klass); static void
garrow_take_options_new(void); GArrowTakeOptions *
garrow_compare_options_get_raw_function_options(GArrowFunctionOptions *options); static arrow::compute::FunctionOptions *
garrow_compare_options_function_options_interface_init(GArrowFunctionOptionsInterface *iface); static void
garrow_compare_options_finalize(GObject *object); static void
garrow_compare_options_set_property(GObject *object, guint prop_id, const GValue *value, GParamSpec *pspec); static void
garrow_compare_options_get_property(GObject *object, guint prop_id, GValue *value, GParamSpec *pspec); static void
garrow_compare_options_init(GArrowCompareOptions *object); static void
garrow_compare_options_class_init(GArrowCompareOptionsClass *klass); static void
garrow_compare_options_new(void); GArrowCompareOptions *
garrow_array_sort_options_get_raw_function_options(GArrowFunctionOptions *options); static arrow::compute::FunctionOptions *
garrow_array_sort_options_function_options_interface_init(GArrowFunctionOptionsInterface *iface); static void
garrow_array_sort_options_finalize(GObject *object); static void
garrow_array_sort_options_set_property(GObject *object, guint prop_id, const GValue *value, GParamSpec *pspec); static void
garrow_array_sort_options_get_property(GObject *object, guint prop_id, GValue *value, GParamSpec *pspec); static void
garrow_array_sort_options_init(GArrowArraySortOptions *object); static void
garrow_array_sort_options_class_init(GArrowArraySortOptionsClass *klass); static void
garrow_array_sort_options_new(GArrowSortOrder order); GArrowArraySortOptions *
garrow_array_sort_options_equal(GArrowArraySortOptions *options, GArrowArraySortOptions *other_options); gboolean
garrow_sort_key_finalize(GObject *object); static void
garrow_sort_key_set_property(GObject *object, guint prop_id, const GValue *value, GParamSpec *pspec); static void
garrow_sort_key_get_property(GObject *object, guint prop_id, GValue *value, GParamSpec *pspec); static void
garrow_sort_key_init(GArrowSortKey *object); static void
garrow_sort_key_class_init(GArrowSortKeyClass *klass); static void
garrow_sort_key_new(const gchar *name, GArrowSortOrder order); GArrowSortKey *
garrow_sort_key_equal(GArrowSortKey *sort_key, GArrowSortKey *other_sort_key); gboolean
garrow_sort_options_get_raw_function_options(GArrowFunctionOptions *options); static arrow::compute::FunctionOptions *
garrow_sort_options_function_options_interface_init(GArrowFunctionOptionsInterface *iface); static void
garrow_sort_options_finalize(GObject *object); static void
garrow_sort_options_init(GArrowSortOptions *object); static void
garrow_sort_options_class_init(GArrowSortOptionsClass *klass); static void
garrow_sort_options_new(GList *sort_keys); GArrowSortOptions *
garrow_sort_options_equal(GArrowSortOptions *options, GArrowSortOptions *other_options); gboolean
garrow_sort_options_get_sort_keys(GArrowSortOptions *options); GList *
garrow_sort_options_add_sort_key(GArrowSortOptions *options , GArrowSortKey *sort_key); void
garrow_sort_options_set_sort_keys(GArrowSortOptions *options , GList *sort_keys)}; void
garrow_array_cast(GArrowArray *array, GArrowDataType *target_data_type, GArrowCastOptions *options, GError **error); GArrowArray *
garrow_array_unique(GArrowArray *array, GError **error); GArrowArray *
garrow_array_dictionary_encode(GArrowArray *array, GError **error); GArrowDictionaryArray *
garrow_array_count(GArrowArray *array, GArrowScalarAggregateOptions *options, GError **error); gint64
garrow_array_count_values(GArrowArray *array, GError **error); GArrowStructArray *
garrow_boolean_array_invert(GArrowBooleanArray *array, GError **error); GArrowBooleanArray *
garrow_boolean_array_and(GArrowBooleanArray *left, GArrowBooleanArray *right, GError **error); GArrowBooleanArray *
garrow_boolean_array_or(GArrowBooleanArray *left, GArrowBooleanArray *right, GError **error); GArrowBooleanArray *
garrow_boolean_array_xor(GArrowBooleanArray *left, GArrowBooleanArray *right, GError **error); GArrowBooleanArray *
garrow_numeric_array_mean(GArrowNumericArray *array, GError **error); gdouble
garrow_int8_array_sum(GArrowInt8Array *array, GError **error); gint64
garrow_uint8_array_sum(GArrowUInt8Array *array, GError **error); guint64
garrow_int16_array_sum(GArrowInt16Array *array, GError **error); gint64
garrow_uint16_array_sum(GArrowUInt16Array *array, GError **error); guint64
garrow_int32_array_sum(GArrowInt32Array *array, GError **error); gint64
garrow_uint32_array_sum(GArrowUInt32Array *array, GError **error); guint64
garrow_int64_array_sum(GArrowInt64Array *array, GError **error); gint64
garrow_uint64_array_sum(GArrowUInt64Array *array, GError **error); guint64
garrow_float_array_sum(GArrowFloatArray *array, GError **error); gdouble
garrow_double_array_sum(GArrowDoubleArray *array, GError **error); gdouble
garrow_array_take(GArrowArray *array, GArrowArray *indices, GArrowTakeOptions *options, GError **error); GArrowArray *
garrow_array_take_chunked_array(GArrowArray *array, GArrowChunkedArray *indices, GArrowTakeOptions *options, GError **error); GArrowChunkedArray *
garrow_table_take(GArrowTable *table, GArrowArray *indices, GArrowTakeOptions *options, GError **error); GArrowTable *
garrow_table_take_chunked_array(GArrowTable *table, GArrowChunkedArray *indices, GArrowTakeOptions *options, GError **error); GArrowTable *
garrow_chunked_array_take(GArrowChunkedArray *chunked_array, GArrowArray *indices, GArrowTakeOptions *options, GError **error); GArrowChunkedArray *
garrow_chunked_array_take_chunked_array(GArrowChunkedArray *chunked_array, GArrowChunkedArray *indices, GArrowTakeOptions *options, GError **error); GArrowChunkedArray *
garrow_record_batch_take(GArrowRecordBatch *record_batch, GArrowArray *indices, GArrowTakeOptions *options, GError **error); GArrowRecordBatch *
garrow_int8_array_compare(GArrowInt8Array *array, gint8 value, GArrowCompareOptions *options, GError **error); GArrowBooleanArray *
garrow_uint8_array_compare(GArrowUInt8Array *array, guint8 value, GArrowCompareOptions *options, GError **error); GArrowBooleanArray *
garrow_int16_array_compare(GArrowInt16Array *array, gint16 value, GArrowCompareOptions *options, GError **error); GArrowBooleanArray *
garrow_uint16_array_compare(GArrowUInt16Array *array, guint16 value, GArrowCompareOptions *options, GError **error); GArrowBooleanArray *
garrow_int32_array_compare(GArrowInt32Array *array, gint32 value, GArrowCompareOptions *options, GError **error); GArrowBooleanArray *
garrow_uint32_array_compare(GArrowUInt32Array *array, guint32 value, GArrowCompareOptions *options, GError **error); GArrowBooleanArray *
garrow_int64_array_compare(GArrowInt64Array *array, gint64 value, GArrowCompareOptions *options, GError **error); GArrowBooleanArray *
garrow_uint64_array_compare(GArrowUInt64Array *array, guint64 value, GArrowCompareOptions *options, GError **error); GArrowBooleanArray *
garrow_float_array_compare(GArrowFloatArray *array, gfloat value, GArrowCompareOptions *options, GError **error); GArrowBooleanArray *
garrow_double_array_compare(GArrowDoubleArray *array, gdouble value, GArrowCompareOptions *options, GError **error); GArrowBooleanArray *
garrow_array_filter(GArrowArray *array, GArrowBooleanArray *filter, GArrowFilterOptions *options, GError **error); GArrowArray *
garrow_array_is_in(GArrowArray *left, GArrowArray *right, GError **error); GArrowBooleanArray *
garrow_array_is_in_chunked_array(GArrowArray *left , GArrowChunkedArray *right , GError **error); GArrowBooleanArray *
garrow_array_sort_indices(GArrowArray *array, GArrowSortOrder order, GError **error); GArrowUInt64Array *
garrow_array_sort_to_indices(GArrowArray *array, GError **error); GArrowUInt64Array *
garrow_chunked_array_sort_indices(GArrowChunkedArray *chunked_array , GArrowSortOrder order , GError **error); GArrowUInt64Array *
garrow_record_batch_sort_indices(GArrowRecordBatch *record_batch , GArrowSortOptions *options , GError **error); GArrowUInt64Array *
garrow_table_sort_indices(GArrowTable *table, GArrowSortOptions *options, GError **error); GArrowUInt64Array *
garrow_table_filter(GArrowTable *table, GArrowBooleanArray *filter, GArrowFilterOptions *options, GError **error); GArrowTable *
garrow_table_filter_chunked_array(GArrowTable *table , GArrowChunkedArray *filter , GArrowFilterOptions *options , GError **error); GArrowTable *
garrow_chunked_array_filter(GArrowChunkedArray *chunked_array, GArrowBooleanArray *filter, GArrowFilterOptions *options, GError **error); GArrowChunkedArray *
garrow_chunked_array_filter_chunked_array(GArrowChunkedArray *chunked_array, GArrowChunkedArray *filter, GArrowFilterOptions *options, GError **error); GArrowChunkedArray *
garrow_record_batch_filter(GArrowRecordBatch *record_batch, GArrowBooleanArray *filter, GArrowFilterOptions *options, GError **error); GArrowRecordBatch *
garrow_execute_context_get_raw(GArrowExecuteContext *context); arrow::compute::ExecContext *
garrow_function_options_get_raw(GArrowFunctionOptions *options); arrow::compute::FunctionOptions *
garrow_function_new_raw(std::shared_ptr<arrow::compute::Function> *arrow_function); GArrowFunction *
garrow_function_get_raw(GArrowFunction *function); std::shared_ptr<arrow::compute::Function>
garrow_cast_options_new_raw(arrow::compute::CastOptions *arrow_cast_options); GArrowCastOptions *
garrow_cast_options_get_raw(GArrowCastOptions *cast_options); arrow::compute::CastOptions *
garrow_scalar_aggregate_options_new_raw( arrow::compute::ScalarAggregateOptions *arrow_scalar_aggregate_options); GArrowScalarAggregateOptions *
garrow_scalar_aggregate_options_get_raw(GArrowScalarAggregateOptions *scalar_aggregate_options); arrow::compute::ScalarAggregateOptions *
garrow_filter_options_get_raw(GArrowFilterOptions *filter_options); arrow::compute::FilterOptions *
garrow_take_options_get_raw(GArrowTakeOptions *take_options); arrow::compute::TakeOptions *
garrow_compare_options_get_raw(GArrowCompareOptions *compare_options); arrow::compute::CompareOptions *
garrow_array_sort_options_get_raw(GArrowArraySortOptions *array_sort_options); arrow::compute::ArraySortOptions *
garrow_sort_key_get_raw(GArrowSortKey *sort_key); arrow::compute::SortKey *
garrow_sort_options_get_raw(GArrowSortOptions *sort_options); arrow::compute::SortOptions *
)

NB. =========================================================
NB. Datum
NB. https://arrow.apache.org/docs/c_glib/arrow-glib/datum-classes.html
NB. =========================================================

datumBindings =: lib 0 : 0
ADD TYPES
garrow_datum_finalize(GObject *object); static void
garrow_datum_set_property(GObject *object, guint prop_id, const GValue *value, GParamSpec *pspec); static void
garrow_datum_init(GArrowDatum *object); static void
garrow_datum_class_init(GArrowDatumClass *klass); static void
garrow_datum_is_array(GArrowDatum *datum); gboolean
garrow_datum_is_array_like(GArrowDatum *datum); gboolean
garrow_datum_is_scalar(GArrowDatum *datum); gboolean
garrow_datum_is_value(GArrowDatum *datum); gboolean
garrow_datum_equal(GArrowDatum *datum, GArrowDatum *other_datum); gboolean
garrow_datum_to_string(GArrowDatum *datum); gchar *
garrow_array_datum_dispose(GObject *object); static void
garrow_array_datum_set_property(GObject *object, guint prop_id, const GValue *value, GParamSpec *pspec); static void
garrow_array_datum_get_property(GObject *object, guint prop_id, GValue *value, GParamSpec *pspec); static void
garrow_array_datum_init(GArrowArrayDatum *object); static void
garrow_array_datum_class_init(GArrowArrayDatumClass *klass); static void
garrow_array_datum_new(GArrowArray *value); GArrowArrayDatum *
garrow_scalar_datum_dispose(GObject *object); static void
garrow_scalar_datum_set_property(GObject *object , guint prop_id , const GValue *value , GParamSpec *pspec); static void
garrow_scalar_datum_get_property(GObject *object , guint prop_id , GValue *value , GParamSpec *pspec); static void
garrow_scalar_datum_init(GArrowScalarDatum *object); static void
garrow_scalar_datum_class_init(GArrowScalarDatumClass *klass); static void
garrow_scalar_datum_new(GArrowScalar *value); GArrowScalarDatum *
garrow_chunked_array_datum_dispose(GObject *object); static void
garrow_chunked_array_datum_set_property(GObject *object, guint prop_id, const GValue *value, GParamSpec *pspec); static void
garrow_chunked_array_datum_get_property(GObject *object, guint prop_id, GValue *value, GParamSpec *pspec); static void
garrow_chunked_array_datum_init(GArrowChunkedArrayDatum *object); static void
garrow_chunked_array_datum_class_init(GArrowChunkedArrayDatumClass *klass); static void
garrow_chunked_array_datum_new(GArrowChunkedArray *value); GArrowChunkedArrayDatum *
garrow_record_batch_datum_dispose(GObject *object); static void
garrow_record_batch_datum_set_property(GObject *object, guint prop_id, const GValue *value, GParamSpec *pspec); static void
garrow_record_batch_datum_get_property(GObject *object, guint prop_id, GValue *value, GParamSpec *pspec); static void
garrow_record_batch_datum_init(GArrowRecordBatchDatum *object); static void
garrow_record_batch_datum_class_init(GArrowRecordBatchDatumClass *klass); static void
garrow_record_batch_datum_new(GArrowRecordBatch *value); GArrowRecordBatchDatum *
garrow_table_datum_dispose(GObject *object); static void
garrow_table_datum_set_property(GObject *object, guint prop_id, const GValue *value, GParamSpec *pspec); static void
garrow_table_datum_get_property(GObject *object, guint prop_id, GValue *value, GParamSpec *pspec); static void
garrow_table_datum_init(GArrowTableDatum *object); static void
garrow_table_datum_class_init(GArrowTableDatumClass *klass); static void
garrow_table_datum_new(GArrowTable *value); GArrowTableDatum *
garrow_datum_get_raw(GArrowDatum *datum); arrow::Datum
garrow_datum_new_raw(arrow::Datum *arrow_datum); GArrowDatum *
garrow_scalar_datum_new_raw(arrow::Datum *arrow_datum, GArrowScalar *value); GArrowScalarDatum *
garrow_array_datum_new_raw(arrow::Datum *arrow_datum, GArrowArray *value); GArrowArrayDatum *
garrow_chunked_array_datum_new_raw(arrow::Datum *arrow_datum, GArrowChunkedArray *value); GArrowChunkedArrayDatum *
garrow_record_batch_datum_new_raw(arrow::Datum *arrow_datum , GArrowRecordBatch *value); GArrowRecordBatchDatum *
garrow_table_datum_new_raw(arrow::Datum *arrow_datum, GArrowTable *value); GArrowTableDatum *
)