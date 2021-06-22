NB. =========================================================
NB. Table Builder
NB. https://arrow.apache.org/docs/c_glib/arrow-glib/table-builder-classes.html
NB. =========================================================

tableBuilderBindings =: lib 0 : 0
ADD TYPES
garrow_record_batch_builder_finalize(GObject *object); static void
garrow_record_batch_builder_set_property(GObject *object, guint prop_id, const GValue *value, GParamSpec *pspec); static void
garrow_record_batch_builder_get_property(GObject *object, guint prop_id, GValue *value, GParamSpec *pspec); static void
garrow_record_batch_builder_init(GArrowRecordBatchBuilder *builder); static void
garrow_record_batch_builder_class_init(GArrowRecordBatchBuilderClass *klass); static void
garrow_record_batch_builder_new(GArrowSchema *schema, GError **error); GArrowRecordBatchBuilder *
garrow_record_batch_builder_get_initial_capacity(GArrowRecordBatchBuilder *builder); gint64
garrow_record_batch_builder_set_initial_capacity(GArrowRecordBatchBuilder *builder, gint64 capacity); void
garrow_record_batch_builder_get_schema(GArrowRecordBatchBuilder *builder); GArrowSchema *
garrow_record_batch_builder_get_n_fields(GArrowRecordBatchBuilder *builder); gint
garrow_record_batch_builder_get_n_columns(GArrowRecordBatchBuilder *builder); gint
garrow_record_batch_builder_get_field(GArrowRecordBatchBuilder *builder, gint i); GArrowArrayBuilder *
garrow_record_batch_builder_get_column_builder(GArrowRecordBatchBuilder *builder, gint i); GArrowArrayBuilder *
garrow_record_batch_builder_flush(GArrowRecordBatchBuilder *builder , GError **error); GArrowRecordBatch *
garrow_record_batch_builder_new_raw(arrow::RecordBatchBuilder *arrow_builder); ArrowRecordBatchBuilder *
garrow_record_batch_builder_get_raw(GArrowRecordBatchBuilder *builder); arrow::RecordBatchBuilder *
)