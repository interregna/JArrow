
NB. =========================================================
NB. ArrowTable
NB. https://arrow.apache.org/docs/c_glib/arrow-glib/GArrowTable.html

tableBindings =: lib 0 : 0
* * * *	garrow_table_new_values	(GArrowSchema *schema, GList *values, GError **error); GArrowTable *
* * * * i * 	garrow_table_new_chunked_arrays	(GArrowSchema *schema, GArrowChunkedArray **chunked_arrays, gsize n_chunked_arrays, GError **error); GArrowTable * 
* * * i *	garrow_table_new_arrays	(GArrowSchema *schema, GArrowArray **arrays, gsize n_arrays, GError **error); GArrowTable *
* * * o *	garrow_table_new_record_batches	(GArrowSchema *schema, GArrowRecordBatch **record_batches, gsize n_record_batches, GError **error); GArrowTable *
c * *	garrow_table_equal	(GArrowTable *table, GArrowTable *other_table); gboolean
c * * c	garrow_table_equal_metadata	(GArrowTable *table, GArrowTable *other_table, gboolean check_metadata); gboolean
* *	garrow_table_get_schema	(GArrowTable *table); GArrowSchema *
* * i	garrow_table_get_column_data	(GArrowTable *table, gint i); GArrowChunkedArray *
i *	garrow_table_get_n_columns	(GArrowTable *table); guint
l *	garrow_table_get_n_rows	(GArrowTable *table); guint64
* * i * * *	garrow_table_add_column	(GArrowTable *table, guint i, GArrowField *field, GArrowChunkedArray *chunked_array, GError **error); GArrowTable *
* * i *	garrow_table_remove_column	(GArrowTable *table, guint i, GError **error); GArrowTable *
* * i * * *	garrow_table_replace_column	(GArrowTable *table, guint i, GArrowField *field, GArrowChunkedArray *chunked_array, GError **error); GArrowTable *
* * *	garrow_table_to_string	(GArrowTable *table, GError **error); gchar *
* * * *	garrow_table_concatenate	(GArrowTable *table, GList *other_tables, GError **error); GArrowTable *
* * x x	garrow_table_slice	(GArrowTable *table, gint64 offset, gint64 length); GArrowTable *
* * *	garrow_table_combine_chunks	(GArrowTable *table, GError **error); GArrowTable *
n *	garrow_feather_write_properties_finalize	(GObject *object); static void 
n * i * *	garrow_feather_write_properties_set_property	(GObject *object, guint prop_id, const GValue *value, GParamSpec *pspec); static void 
n * i * *	garrow_feather_write_properties_get_property	(GObject *object, guint prop_id, GValue *value, GParamSpec *pspec); static void 
n *	garrow_feather_write_properties_init	(GArrowFeatherWriteProperties *object); static void 
n *	garrow_feather_write_properties_class_init	(GArrowFeatherWritePropertiesClass *klass); static void 
* n	garrow_feather_write_properties_new	(void); GArrowFeatherWriteProperties *
c * * * *	garrow_table_write_as_feather	(GArrowTable *table, GArrowOutputStream *sink, GArrowFeatherWriteProperties *properties, GError **error); gboolean 
)

NB. =========================================================
NB. Record Batch
NB. https://arrow.apache.org/docs/c_glib/arrow-glib/record-batch.html
NB. =========================================================
recordBatchBindings =: lib 0 : 0
n *	garrow_record_batch_finalize	(GObject *object); static void
n * i * *	garrow_record_batch_set_property	(GObject *object, guint prop_id, const GValue *value, GParamSpec *pspec); static void
n * i * *	garrow_record_batch_get_property	(GObject *object, guint prop_id, GValue *value, GParamSpec *pspec); static void
n *	garrow_record_batch_init	(GArrowRecordBatch *object); static void
n *	garrow_record_batch_class_init	(GArrowRecordBatchClass *klass); static void
* * i * *	garrow_record_batch_new	(GArrowSchema *schema, guint32 n_rows, GList *columns, GError **error); GArrowRecordBatch *
c * *	garrow_record_batch_equal	(GArrowRecordBatch *record_batch, GArrowRecordBatch *other_record_batch); gboolean
c * * c	garrow_record_batch_equal_metadata	(GArrowRecordBatch *record_batch, GArrowRecordBatch *other_record_batch, gboolean check_metadata); gboolean
* *	garrow_record_batch_get_schema	(GArrowRecordBatch *record_batch); GArrowSchema *
* * i	garrow_record_batch_get_column_data	(GArrowRecordBatch *record_batch, gint i); GArrowArray *
* * i	garrow_record_batch_get_column_name	(GArrowRecordBatch *record_batch, gint i); const gchar *
i *	garrow_record_batch_get_n_columns	(GArrowRecordBatch *record_batch); guint
x *	garrow_record_batch_get_n_rows	(GArrowRecordBatch *record_batch); gint64
* * x x	garrow_record_batch_slice	(GArrowRecordBatch *record_batch, gint64 offset, gint64 length); GArrowRecordBatch *
* * *	garrow_record_batch_to_string	(GArrowRecordBatch *record_batch, GError **error); gchar *
* * i * * *	garrow_record_batch_add_column	(GArrowRecordBatch *record_batch, guint i, GArrowField *field, GArrowArray *column, GError **error); GArrowRecordBatch *
* * i *	garrow_record_batch_remove_column	(GArrowRecordBatch *record_batch, guint i, GError **error); GArrowRecordBatch *
* * * *	garrow_record_batch_serialize	(GArrowRecordBatch *record_batch, GArrowWriteOptions *options, GError **error); GArrowBuffer *
n *	garrow_record_batch_iterator_finalize	(GObject *object); static void
n * i * *	garrow_record_batch_iterator_set_property	(GObject *object, guint prop_id, const GValue *value, GParamSpec *pspec); static void
n *	garrow_record_batch_iterator_init	(GArrowRecordBatchIterator *object); static void
n *	garrow_record_batch_iterator_class_init	(GArrowRecordBatchIteratorClass *klass); static void
* *	garrow_record_batch_iterator_new	(GList *record_batches); GArrowRecordBatchIterator *
* * *	garrow_record_batch_iterator_next	(GArrowRecordBatchIterator *iterator, GError **error); GArrowRecordBatch *
c * *	garrow_record_batch_iterator_equal	(GArrowRecordBatchIterator *iterator, GArrowRecordBatchIterator *other_iterator); gboolean
* * *	garrow_record_batch_iterator_to_list	(GArrowRecordBatchIterator *iterator, GError **error); GList*
* *	garrow_record_batch_new_raw	(std::shared_ptr<arrow::RecordBatch> *arrow_record_batch); ArrowRecordBatch *
* *	garrow_record_batch_get_raw	(GArrowRecordBatch *record_batch); std::shared_ptr<arrow::RecordBatch>
* *	garrow_record_batch_iterator_new_raw	(arrow::RecordBatchIterator *arrow_iterator); GArrowRecordBatchIterator *
* *	garrow_record_batch_iterator_get_raw	(GArrowRecordBatchIterator *iterator); arrow::RecordBatchIterator *
)

NB. =========================================================
NB. Chunked Array
NB. https://arrow.apache.org/docs/c_glib/arrow-glib/GArrowChunkedArray.html

chunkedArrayBindings =: lib 0 : 0
n *	garrow_chunked_array_finalize	(GObject *object); static void
n * i * *	garrow_chunked_array_set_property	(GObject *object, guint prop_id, const GValue *value, GParamSpec *pspec); static void
n * i * *	garrow_chunked_array_get_property	(GObject *object, guint prop_id, GValue *value, GParamSpec *pspec); static void
n *	garrow_chunked_array_init	(GArrowChunkedArray *object); static void
n *	garrow_chunked_array_class_init	(GArrowChunkedArrayClass *klass); static void
* *	garrow_chunked_array_new	(GList *chunks); GArrowChunkedArray *
c * *	garrow_chunked_array_equal	(GArrowChunkedArray *chunked_array, GArrowChunkedArray *other_chunked_array); gboolean
* *	garrow_chunked_array_get_value_data_type	(GArrowChunkedArray *chunked_array); GArrowDataType *
i *	garrow_chunked_array_get_value_type	(GArrowChunkedArray *chunked_array); GArrowType
x *	garrow_chunked_array_get_length	(GArrowChunkedArray *chunked_array); guint64
x *	garrow_chunked_array_get_n_rows	(GArrowChunkedArray *chunked_array); guint64
x *	garrow_chunked_array_get_n_nulls	(GArrowChunkedArray *chunked_array); guint64
x *	garrow_chunked_array_get_n_chunks	(GArrowChunkedArray *chunked_array); guint
* * i	garrow_chunked_array_get_chunk	(GArrowChunkedArray *chunked_array, guint i); GArrowArray *
* *	garrow_chunked_array_get_chunks	(GArrowChunkedArray *chunked_array); GList *
* * x x	garrow_chunked_array_slice	(GArrowChunkedArray *chunked_array, guint64 offset, guint64 length); GArrowChunkedArray *
* * *	garrow_chunked_array_to_string	(GArrowChunkedArray *chunked_array, GError **error); gchar *
* * *	garrow_chunked_array_combine	(GArrowChunkedArray *chunked_array, GError **error); GArrowArray *
* *	garrow_chunked_array_new_raw	(std::shared_ptr<arrow::ChunkedArray> *arrow_chunked_array); ArrowChunkedArray *
* *	garrow_chunked_array_get_raw	(GArrowChunkedArray *chunked_array); std::shared_ptr<arrow::ChunkedArray>
)