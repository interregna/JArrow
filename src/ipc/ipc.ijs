NB. IPC
NB. Options
NB. IPC options classes
NB. =========================================================
NB. IPC Options
NB. https://arrow.apache.org/docs/c_glib/arrow-glib/ipc-options-classes.html
NB. =========================================================
ipcOptionsBindings =: lib 0 : 0
*	garrow_read_options_new	(void); GArrowReadOptions *
*i * *	garrow_read_options_get_included_fields	(GArrowReadOptions *options, gsize *n_fields); int *
n * * i	garrow_read_options_set_included_fields	(GArrowReadOptions *options, int *fields, gsize n_fields); void
*	garrow_write_options_new	(void); GArrowWriteOptions *
)

NB. Reader
NB. Reader classes
NB. =========================================================
NB. Reader
NB. https://arrow.apache.org/docs/c_glib/arrow-glib/reader-classes.html
NB. =========================================================
readerBindings =: lib 0 : 0
* * *	garrow_record_batch_reader_import	(gpointer c_abi_array_stream, GError **error);GArrowRecordBatchReader *
* * * *	garrow_record_batch_reader_new	(GList *record_batches, GArrowSchema *schema, GError **error);GArrowRecordBatchReader *);GArrowRecordBatchReader *
* * *	garrow_record_batch_reader_export	(GArrowRecordBatchReader *reader, GError **error);gpointer
* *	garrow_record_batch_reader_get_schema	(GArrowRecordBatchReader *reader); GArrowSchema *
* * *	garrow_record_batch_reader_get_next_record_batch	(GArrowRecordBatchReader *reader, GError **error); GArrowRecordBatch *
* * *	garrow_record_batch_reader_read_next_record_batch	(GArrowRecordBatchReader *reader, GError **error); GArrowRecordBatch *
* * *	garrow_record_batch_reader_read_next	(GArrowRecordBatchReader *reader, GError **error); GArrowRecordBatch *
* *	garrow_table_batch_reader_new	(GArrowTable *table); GArrowTableBatchReader *
* * *	garrow_record_batch_stream_reader_new	(GArrowInputStream *stream, GError **error); GArrowRecordBatchStreamReader *
* * *	garrow_record_batch_file_reader_new	(GArrowSeekableInputStream *file, GError **error); GArrowRecordBatchFileReader *
* *	garrow_record_batch_file_reader_get_schema	(GArrowRecordBatchFileReader *reader); GArrowSchema *
i *	garrow_record_batch_file_reader_get_n_record_batches	(GArrowRecordBatchFileReader *reader); guint
i *	garrow_record_batch_file_reader_get_version	(GArrowRecordBatchFileReader *reader); GArrowMetadataVersion
* * i *	garrow_record_batch_file_reader_get_record_batch	(GArrowRecordBatchFileReader *reader, guint i, GError **error); GArrowRecordBatch *
* * i *	garrow_record_batch_file_reader_read_record_batch	(GArrowRecordBatchFileReader *reader, guint i, GError **error); GArrowRecordBatch *
* * *	garrow_feather_file_reader_new	(GArrowSeekableInputStream *file, GError **error); GArrowFeatherFileReader *
i *	garrow_feather_file_reader_get_version	(GArrowFeatherFileReader *reader); gint
* * *	garrow_feather_file_reader_read	(GArrowFeatherFileReader *reader, GError **error); GArrowTable *
* * * i *	garrow_feather_file_reader_read_indices	(GArrowFeatherFileReader *reader, const gint *indices, guint n_indices, GError **error); GArrowTable *
* * * i *	garrow_feather_file_reader_read_names	(GArrowFeatherFileReader *reader, const gchar **names, guint n_names, GError **error); GArrowTable *
*	garrow_csv_read_options_new	(void); GArrowCSVReadOptions *
n * * *	garrow_csv_read_options_add_column_type	(GArrowCSVReadOptions *options, const gchar *name, GArrowDataType *data_type); void
n * *	garrow_csv_read_options_add_schema	(GArrowCSVReadOptions *options, GArrowSchema *schema); void
* *	garrow_csv_read_options_get_column_types	(GArrowCSVReadOptions *options); GHashTable *
n * * i	garrow_csv_read_options_set_null_values	(GArrowCSVReadOptions *options, const gchar **null_values, gsize n_null_values); void
* *	garrow_csv_read_options_get_null_values	(GArrowCSVReadOptions *options); gchar **
n * *	garrow_csv_read_options_add_null_value	(GArrowCSVReadOptions *options, const gchar *null_value); void
n * i	garrow_csv_read_options_set_true_values	(GArrowCSVReadOptions *options, const gchar **true_values, gsize n_true_values); void
* *	garrow_csv_read_options_get_true_values	(GArrowCSVReadOptions *options); gchar **
n *	garrow_csv_read_options_add_true_value	(GArrowCSVReadOptions *options, const gchar *true_value); void
n * * u	garrow_csv_read_options_set_false_values	(GArrowCSVReadOptions *options, const gchar **false_values, gsize n_false_values); void
* *	garrow_csv_read_options_get_false_values	(GArrowCSVReadOptions *options); gchar **
n * *	garrow_csv_read_options_add_false_value	(GArrowCSVReadOptions *options, const gchar *false_value); void
n * * i	garrow_csv_read_options_set_column_names	(GArrowCSVReadOptions *options, const gchar **column_names, gsize n_column_names); void
* *	garrow_csv_read_options_get_column_names	(GArrowCSVReadOptions *options); gchar **
n * *	garrow_csv_read_options_add_column_name	(GArrowCSVReadOptions *options, const gchar *column_name); void
* * * *	garrow_csv_reader_new	(GArrowInputStream *input, GArrowCSVReadOptions *options, GError **error); GArrowCSVReader *
* * *	garrow_csv_reader_read	(GArrowCSVReader *reader, GError **error); GArrowTable *
*	garrow_json_read_options_new	(void); GArrowJSONReadOptions *
* * * *	garrow_json_reader_new	(GArrowInputStream *input, GArrowJSONReadOptions *options, GError **error); GArrowJSONReader *
* * *	garrow_json_reader_read	(GArrowJSONReader *reader, GError **error); GArrowTable *
)

NB. ORC reader
NB. =========================================================
NB. ORC File Reader
NB. https://arrow.apache.org/docs/c_glib/arrow-glib/orc-file-reader.html
NB. =========================================================
orcFileReaderBindings =: lib 0 : 0
* * * i	garrow_orc_file_reader_new	(GArrowSeekableInputStream *input, GError **error); GArrowORCFileReader *
n * * i	garrow_orc_file_reader_set_field_indexes	(GArrowORCFileReader *reader, const gint *field_indexes, guint n_field_indexes); void
n * *i	garrow_orc_file_reader_set_field_indices	(GArrowORCFileReader *reader, const gint *field_indices, guint n_field_indices); void
*i * *i	garrow_orc_file_reader_get_field_indexes	(GArrowORCFileReader *reader, guint *n_field_indexes); const gint *
*i * *i	garrow_orc_file_reader_get_field_indices	(GArrowORCFileReader *reader, guint *n_field_indices); const gint *
* * *	garrow_orc_file_reader_read_type	(GArrowORCFileReader *reader , GError **error); GArrowSchema *
* * *	garrow_orc_file_reader_read_stripes	(GArrowORCFileReader *reader, GError **error); GArrowTable *
* * x *	garrow_orc_file_reader_read_stripe	(GArrowORCFileReader *reader, gint64 i, GError **error); GArrowRecordBatch *
x *	garrow_orc_file_reader_get_n_stripes	(GArrowORCFileReader *reader); gint64
x *	garrow_orc_file_reader_get_n_rows	(GArrowORCFileReader *reader); gint64
)
NB. Writer
NB. Writer classes

NB. =========================================================
NB. Writer
NB. https://arrow.apache.org/docs/c_glib/arrow-glib/writer-classes.html
NB. =========================================================
writerBindings =: lib 0 : 0
i * * *	garrow_record_batch_writer_write_record_batch	(GArrowRecordBatchWriter *writer, GArrowRecordBatch *record_batch, GError **error); gboolean
i * * *	garrow_record_batch_writer_write_table	(GArrowRecordBatchWriter *writer, GArrowTable *table, GError **error); gboolean
i * * *	garrow_record_batch_writer_close	(GArrowRecordBatchWriter *writer , GError **error); gboolean
* * * *	garrow_record_batch_stream_writer_new	(GArrowOutputStream *sink, GArrowSchema *schema, GError **error); GArrowRecordBatchStreamWriter *
* * * *	garrow_record_batch_file_writer_new	(GArrowOutputStream *sink, GArrowSchema *schema, GError **error); GArrowRecordBatchFileWriter *
)