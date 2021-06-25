NB. Parquet

NB. =========================================================
NB. Reader
NB. https://arrow.apache.org/docs/c_glib/parquet-glib/GParquetArrowFileReader.html

parquetReaderBindings =: lib 0 : 0
* * *	gparquet_arrow_file_reader_new_arrow	(GArrowSeekableInputStream *source, GError **error); * GParquetArrowFileReader
* *c *	gparquet_arrow_file_reader_new_path	(const gchar *path, GError **error); * GParquetArrowFileReader
* * *	gparquet_arrow_file_reader_read_table	(GParquetArrowFileReader *reader, GError **error); * GArrowTable
* *i i *i i i	gparquet_arrow_file_reader_read_row_group	(GParquetArrowFileReader *reader, gint row_group_index, gint *column_indices, gsize n_column_indices, GError **error); * GArrowTable
* * * 	gparquet_arrow_file_reader_get_schema 	(GParquetArrowFileReader *reader, GError **error); * GArrowSchema
* * i * 	gparquet_arrow_file_reader_read_column_data	(GParquetArrowFileReader *reader, gint i, GError **error); * GArrowChunkedArray
i *	gparquet_arrow_file_reader_get_n_row_groups	(GParquetArrowFileReader *reader); gint
n * c	gparquet_arrow_file_reader_set_use_threads	(GParquetArrowFileReader *reader, gboolean use_threads); void
)

NB. =========================================================
NB. Writer
NB. https://arrow.apache.org/docs/c_glib/parquet-glib/GParquetArrowFileWriter.html

parquetWriterBindings =: lib 0 : 0
*	gparquet_writer_properties_new	(void); GParquetWriterProperties
n * c *c	gparquet_writer_properties_set_compression	(GParquetWriterProperties *properties, GArrowCompressionType compression_type, const gchar *path); void
? * *c	gparquet_writer_properties_get_compression_path	(GParquetWriterProperties *properties, const gchar *path); GArrowCompressionType
n * *	gparquet_writer_properties_enable_dictionary	(GParquetWriterProperties *properties, const gchar *path); void
n * *	gparquet_writer_properties_disable_dictionary	(GParquetWriterProperties *properties, const gchar *path); void
c * *	gparquet_writer_properties_is_dictionary_enabled	(GParquetWriterProperties *properties, const gchar *path); gboolean
n *	gparquet_writer_properties_set_dictionary_page_size_limit	(GParquetWriterProperties *properties, gint64 limit); void
x *	gparquet_writer_properties_get_dictionary_page_size_limit	(GParquetWriterProperties *properties); gint64
n * x	gparquet_writer_properties_set_batch_size	(GParquetWriterProperties *properties, gint64 batch_size); void
x *	gparquet_writer_properties_get_batch_size	(GParquetWriterProperties *properties); gint64
n * x	gparquet_writer_properties_set_max_row_group_length	(GParquetWriterProperties *properties, gint64 length); void
x *	gparquet_writer_properties_get_max_row_group_length	(GParquetWriterProperties *properties); gint64
n * x	gparquet_writer_properties_set_data_page_size		(GParquetWriterProperties *properties, gint64 data_page_size); void
x *	gparquet_writer_properties_get_data_page_size		(GParquetWriterProperties *properties); gint64
* * * * *	gparquet_arrow_file_writer_new_arrow	(GArrowSchema *schema, GArrowOutputStream *sink,GParquetWriterProperties *writer_properties,GError **error); GParquetArrowFileWriter *
* * * * *	gparquet_arrow_file_writer_new_path	(GArrowSchema *schema, const gchar *path, GParquetWriterProperties *writer_properties, GError **error); GParquetArrowFileWriter *
c * * x *	gparquet_arrow_file_writer_write_table	(GParquetArrowFileWriter *writer, GArrowTable *table, guint64 chunk_size, GError **error); gboolean
c * *	gparquet_arrow_file_writer_close	(GParquetArrowFileWriter *writer, GError **error); gboolean
)