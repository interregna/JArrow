NB. IPC
NB. Options
NB. IPC options classes
NB. =========================================================
NB. IPC Options
NB. https://arrow.apache.org/docs/c_glib/arrow-glib/ipc-options-classes.html
NB. =========================================================
ipcOptionsBindings =: lib 0 : 0
ADD TYPES
garrow_read_options_finalize(GObject *object); static void
garrow_read_options_set_property(GObject *object , guint prop_id , const GValue *value , GParamSpec *pspec); static void
garrow_read_options_get_property(GObject *object , guint prop_id , GValue *value , GParamSpec *pspec); static void
garrow_read_options_init(GArrowReadOptions *object); static void
garrow_read_options_class_init(GArrowReadOptionsClass *klass); static void
garrow_read_options_new(void); GArrowReadOptions *
garrow_read_options_get_included_fields(GArrowReadOptions *options, gsize *n_fields); int *
garrow_read_options_set_included_fields(GArrowReadOptions *options, int *fields, gsize n_fields); void
garrow_write_options_dispose(GObject *object); static void
garrow_write_options_finalize(GObject *object); static void
garrow_write_options_set_property(GObject *object , guint prop_id , const GValue *value , GParamSpec *pspec); static void
garrow_write_options_get_property(GObject *object , guint prop_id , GValue *value , GParamSpec *pspec); static void
garrow_write_options_init(GArrowWriteOptions *object); static void
garrow_write_options_class_init(GArrowWriteOptionsClass *klass); static void
garrow_write_options_new(void); GArrowWriteOptions *
garrow_read_options_get_raw(GArrowReadOptions *options); arrow::ipc::IpcReadOptions *
garrow_read_options_get_dictionary_memo_raw(GArrowReadOptions *options); arrow::ipc::DictionaryMemo *
garrow_write_options_get_raw(GArrowWriteOptions *options); arrow::ipc::IpcWriteOptions *
)

NB. Reader
NB. Reader classes
NB. =========================================================
NB. Reader
NB. https://arrow.apache.org/docs/c_glib/arrow-glib/reader-classes.html
NB. =========================================================
readerBindings =: lib 0 : 0
ADD TYPES
garrow_record_batch_reader_finalize(GObject *object); static void
garrow_record_batch_reader_set_property(GObject *object, guint prop_id, const GValue *value, GParamSpec *pspec); static void
garrow_record_batch_reader_get_property(GObject *object, guint prop_id, GValue *value, GParamSpec *pspec); static void
garrow_record_batch_reader_init(GArrowRecordBatchReader *object); static void
garrow_record_batch_reader_class_init(GArrowRecordBatchReaderClass *klass); static void
garrow_record_batch_reader_get_schema(GArrowRecordBatchReader *reader); GArrowSchema *
garrow_record_batch_reader_get_next_record_batch(GArrowRecordBatchReader *reader, GError **error); GArrowRecordBatch *
garrow_record_batch_reader_read_next_record_batch(GArrowRecordBatchReader *reader, GError **error); GArrowRecordBatch *
garrow_record_batch_reader_read_next(GArrowRecordBatchReader *reader, GError **error); GArrowRecordBatch *
garrow_table_batch_reader_init(GArrowTableBatchReader *object); static void
garrow_table_batch_reader_class_init(GArrowTableBatchReaderClass *klass); static void
garrow_table_batch_reader_new(GArrowTable *table); GArrowTableBatchReader *
garrow_record_batch_stream_reader_init(GArrowRecordBatchStreamReader *object); static void
garrow_record_batch_stream_reader_class_init(GArrowRecordBatchStreamReaderClass *klass); static void
garrow_record_batch_stream_reader_new(GArrowInputStream *stream, GError **error); GArrowRecordBatchStreamReader *
garrow_record_batch_file_reader_finalize(GObject *object); static void
garrow_record_batch_file_reader_set_property(GObject *object, guint prop_id, const GValue *value, GParamSpec *pspec); static void
garrow_record_batch_file_reader_get_property(GObject *object, guint prop_id, GValue *value, GParamSpec *pspec); static void
garrow_record_batch_file_reader_init(GArrowRecordBatchFileReader *object); static void
garrow_record_batch_file_reader_class_init(GArrowRecordBatchFileReaderClass *klass); static void
garrow_record_batch_file_reader_new(GArrowSeekableInputStream *file, GError **error); GArrowRecordBatchFileReader *
garrow_record_batch_file_reader_get_schema(GArrowRecordBatchFileReader *reader); GArrowSchema *
garrow_record_batch_file_reader_get_n_record_batches(GArrowRecordBatchFileReader *reader); guint
garrow_record_batch_file_reader_get_version(GArrowRecordBatchFileReader *reader); GArrowMetadataVersion
garrow_record_batch_file_reader_get_record_batch(GArrowRecordBatchFileReader *reader, guint i, GError **error); GArrowRecordBatch *
garrow_record_batch_file_reader_read_record_batch(GArrowRecordBatchFileReader *reader, guint i, GError **error); GArrowRecordBatch *
garrow_feather_file_reader_finalize(GObject *object); static void
garrow_feather_file_reader_set_property(GObject *object, guint prop_id, const GValue *value, GParamSpec *pspec); static void
garrow_feather_file_reader_get_property(GObject *object, guint prop_id, GValue *value, GParamSpec *pspec); static void
garrow_feather_file_reader_init(GArrowFeatherFileReader *object); static void
garrow_feather_file_reader_class_init(GArrowFeatherFileReaderClass *klass); static void
garrow_feather_file_reader_new(GArrowSeekableInputStream *file, GError **error); GArrowFeatherFileReader *
garrow_feather_file_reader_get_version(GArrowFeatherFileReader *reader); gint
garrow_feather_file_reader_read(GArrowFeatherFileReader *reader, GError **error); GArrowTable *
garrow_feather_file_reader_read_indices(GArrowFeatherFileReader *reader, const gint *indices, guint n_indices, GError **error); GArrowTable *
garrow_feather_file_reader_read_names(GArrowFeatherFileReader *reader, const gchar **names, guint n_names, GError **error); GArrowTable *
garrow_csv_read_options_set_property(GObject *object, guint prop_id, const GValue *value, GParamSpec *pspec); static void
garrow_csv_read_options_get_property(GObject *object, guint prop_id, GValue *value, GParamSpec *pspec); static void
garrow_csv_read_options_init(GArrowCSVReadOptions *object); static void
garrow_csv_read_options_class_init(GArrowCSVReadOptionsClass *klass); static void
garrow_csv_read_options_new(void); GArrowCSVReadOptions *
garrow_csv_read_options_add_column_type(GArrowCSVReadOptions *options, const gchar *name, GArrowDataType *data_type); void
garrow_csv_read_options_add_schema(GArrowCSVReadOptions *options, GArrowSchema *schema); void
garrow_csv_read_options_get_column_types(GArrowCSVReadOptions *options); GHashTable *
garrow_csv_read_options_set_null_values(GArrowCSVReadOptions *options, const gchar **null_values, gsize n_null_values); void
garrow_csv_read_options_get_null_values(GArrowCSVReadOptions *options); gchar **
garrow_csv_read_options_add_null_value(GArrowCSVReadOptions *options, const gchar *null_value); void
garrow_csv_read_options_set_true_values(GArrowCSVReadOptions *options, const gchar **true_values, gsize n_true_values); void
garrow_csv_read_options_get_true_values(GArrowCSVReadOptions *options); gchar **
garrow_csv_read_options_add_true_value(GArrowCSVReadOptions *options, const gchar *true_value); void
garrow_csv_read_options_set_false_values(GArrowCSVReadOptions *options, const gchar **false_values, gsize n_false_values); void
garrow_csv_read_options_get_false_values(GArrowCSVReadOptions *options); gchar **
garrow_csv_read_options_add_false_value(GArrowCSVReadOptions *options, const gchar *false_value); void
garrow_csv_read_options_set_column_names(GArrowCSVReadOptions *options, const gchar **column_names, gsize n_column_names); void
garrow_csv_read_options_get_column_names(GArrowCSVReadOptions *options); gchar **
garrow_csv_read_options_add_column_name(GArrowCSVReadOptions *options, const gchar *column_name); void
garrow_csv_reader_dispose(GObject *object); static void
garrow_csv_reader_finalize(GObject *object); static void
garrow_csv_reader_set_property(GObject *object, guint prop_id, const GValue *value, GParamSpec *pspec); static void
garrow_csv_reader_get_property(GObject *object, guint prop_id, GValue *value, GParamSpec *pspec); static void
garrow_csv_reader_init(GArrowCSVReader *object); static void
garrow_csv_reader_class_init(GArrowCSVReaderClass *klass); static void
garrow_csv_reader_new(GArrowInputStream *input, GArrowCSVReadOptions *options, GError **error); GArrowCSVReader *
garrow_csv_reader_read(GArrowCSVReader *reader, GError **error); GArrowTable *
garrow_json_read_options_dispose(GObject *object); static void
garrow_json_read_options_set_property(GObject *object, guint prop_id, const GValue *value, GParamSpec *pspec); static void
garrow_json_read_options_get_property(GObject *object, guint prop_id, GValue *value, GParamSpec *pspec); static void
garrow_json_read_options_init(GArrowJSONReadOptions *object); static void
garrow_json_read_options_class_init(GArrowJSONReadOptionsClass *klass); static void
garrow_json_read_options_new(void); GArrowJSONReadOptions *
garrow_json_reader_dispose(GObject *object); static void
garrow_json_reader_finalize(GObject *object); static void
garrow_json_reader_set_property(GObject *object, guint prop_id, const GValue *value, GParamSpec *pspec); static void
garrow_json_reader_get_property(GObject *object, guint prop_id, GValue *value, GParamSpec *pspec); static void
garrow_json_reader_init(GArrowJSONReader *object); static void
garrow_json_reader_class_init(GArrowJSONReaderClass *klass); static void
garrow_json_reader_new(GArrowInputStream *input, GArrowJSONReadOptions *options, GError **error); GArrowJSONReader *
garrow_json_reader_read(GArrowJSONReader *reader, GError **error); GArrowTable *
garrow_record_batch_reader_new_raw(std::shared_ptr<arrow::ipc::RecordBatchReader> *arrow_reader); ArrowRecordBatchReader *
garrow_record_batch_reader_get_raw(GArrowRecordBatchReader *reader); std::shared_ptr<arrow::ipc::RecordBatchReader>
garrow_table_batch_reader_new_raw(std::shared_ptr<arrow::TableBatchReader> *arrow_reader); GArrowTableBatchReader *
garrow_record_batch_stream_reader_new_raw(std::shared_ptr<arrow::ipc::RecordBatchStreamReader> *arrow_reader); GArrowRecordBatchStreamReader *
garrow_record_batch_file_reader_new_raw(std::shared_ptr<arrow::ipc::RecordBatchFileReader> *arrow_reader); GArrowRecordBatchFileReader *
garrow_record_batch_file_reader_get_raw(GArrowRecordBatchFileReader *reader); std::shared_ptr<arrow::ipc::RecordBatchFileReader>
garrow_feather_file_reader_new_raw(std::shared_ptr<arrow::ipc::feather::Reader> *arrow_reader); GArrowFeatherFileReader *
garrow_feather_file_reader_get_raw(GArrowFeatherFileReader *reader); std::shared_ptr<arrow::ipc::feather::Reader>
garrow_csv_reader_new_raw(std::shared_ptr<arrow::csv::TableReader> *arrow_reader, GArrowInputStream *input); GArrowCSVReader *
garrow_csv_reader_get_raw(GArrowCSVReader *reader); std::shared_ptr<arrow::csv::TableReader>
garrow_json_reader_new_raw(std::shared_ptr<arrow::json::TableReader> *arrow_reader, GArrowInputStream *input); GArrowJSONReader *
garrow_json_reader_get_raw(GArrowJSONReader *reader); std::shared_ptr<arrow::json::TableReader>
)

NB. ORC reader
NB. =========================================================
NB. ORC File Reader
NB. https://arrow.apache.org/docs/c_glib/arrow-glib/orc-file-reader.html
NB. =========================================================
orcFileReaderBindings =: lib 0 : 0
ADD TYPES
garrow_orc_file_reader_dispose(GObject *object); static void
garrow_orc_file_reader_finalize(GObject *object); static void
garrow_orc_file_reader_set_property(GObject *object, guint prop_id, const GValue *value, GParamSpec *pspec); static void
garrow_orc_file_reader_get_property(GObject *object, guint prop_id, GValue *value, GParamSpec *pspec); static void
garrow_orc_file_reader_init(GArrowORCFileReader *object); static void
garrow_orc_file_reader_class_init(GArrowORCFileReaderClass *klass); static void
garrow_orc_file_reader_new(GArrowSeekableInputStream *input, GError **error); GArrowORCFileReader *
garrow_orc_file_reader_set_field_indexes(GArrowORCFileReader *reader, const gint *field_indexes, guint n_field_indexes); void
garrow_orc_file_reader_set_field_indices(GArrowORCFileReader *reader, const gint *field_indices, guint n_field_indices); void
garrow_orc_file_reader_get_field_indexes(GArrowORCFileReader *reader, guint *n_field_indexes); const gint *
garrow_orc_file_reader_get_field_indices(GArrowORCFileReader *reader, guint *n_field_indices); const gint *
garrow_orc_file_reader_read_type(GArrowORCFileReader *reader , GError **error); GArrowSchema *
garrow_orc_file_reader_read_stripes(GArrowORCFileReader *reader, GError **error); GArrowTable *
garrow_orc_file_reader_read_stripe(GArrowORCFileReader *reader, gint64 i, GError **error); GArrowRecordBatch *
garrow_orc_file_reader_get_n_stripes(GArrowORCFileReader *reader); gint64
garrow_orc_file_reader_get_n_rows(GArrowORCFileReader *reader); gint64
garrow_orc_file_reader_new_raw(GArrowSeekableInputStream *input, arrow::adapters::orc::ORCFileReader *arrow_reader); GArrowORCFileReader *
garrow_orc_file_reader_get_raw(GArrowORCFileReader *reader); arrow::adapters::orc::ORCFileReader *
)
NB. Writer
NB. Writer classes

NB. =========================================================
NB. Writer
NB. https://arrow.apache.org/docs/c_glib/arrow-glib/writer-classes.html
NB. =========================================================
writerBindings =: lib 0 : 0
ADD TYPES
garrow_record_batch_writer_finalize(GObject *object); static void
garrow_record_batch_writer_set_property(GObject *object, guint prop_id, const GValue *value, GParamSpec *pspec); static void
garrow_record_batch_writer_get_property(GObject *object, guint prop_id, GValue *value, GParamSpec *pspec); static void
garrow_record_batch_writer_init(GArrowRecordBatchWriter *object); static void
garrow_record_batch_writer_class_init(GArrowRecordBatchWriterClass *klass); static void
garrow_record_batch_writer_write_record_batch(GArrowRecordBatchWriter *writer, GArrowRecordBatch *record_batch, GError **error); gboolean
garrow_record_batch_writer_write_table(GArrowRecordBatchWriter *writer, GArrowTable *table, GError **error); gboolean
garrow_record_batch_writer_close(GArrowRecordBatchWriter *writer , GError **error); gboolean
garrow_record_batch_stream_writer_init(GArrowRecordBatchStreamWriter *object); static void
garrow_record_batch_stream_writer_class_init(GArrowRecordBatchStreamWriterClass *klass); static void
garrow_record_batch_stream_writer_new(GArrowOutputStream *sink, GArrowSchema *schema, GError **error); GArrowRecordBatchStreamWriter *
garrow_record_batch_file_writer_init(GArrowRecordBatchFileWriter *object); static void
garrow_record_batch_file_writer_class_init(GArrowRecordBatchFileWriterClass *klass); static void
garrow_record_batch_file_writer_new(GArrowOutputStream *sink, GArrowSchema *schema, GError **error); GArrowRecordBatchFileWriter *
garrow_record_batch_writer_new_raw(std::shared_ptr<arrow::ipc::RecordBatchWriter> *arrow_writer); GArrowRecordBatchWriter *
garrow_record_batch_writer_get_raw(GArrowRecordBatchWriter *writer); std::shared_ptr<arrow::ipc::RecordBatchWriter>
garrow_record_batch_stream_writer_new_raw(std::shared_ptr<arrow::ipc::RecordBatchWriter> *arrow_writer); GArrowRecordBatchStreamWriter *
garrow_record_batch_file_writer_new_raw(std::shared_ptr<arrow::ipc::RecordBatchWriter> *arrow_writer); GArrowRecordBatchFileWriter *
)