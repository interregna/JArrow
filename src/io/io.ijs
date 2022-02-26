NB. IO

NB. Input
NB. GArrowReadable — Input interface
NB. =========================================================
NB. Readable
NB. https://arrow.apache.org/docs/c_glib/arrow-glib/GArrowReadable.html
NB. =========================================================
readableBindings =: lib 0 : 0
* * l *	garrow_readable_read	(GArrowReadable *readable, gint64 n_bytes, GError **error); GArrowBuffer *
* * l *	garrow_readable_read_bytes	(GArrowReadable *readable, gint64 n_bytes, GError **error); GBytes *
)

NB. Input stream classes
NB. =========================================================	
NB. Input Stream	
NB. https://arrow.apache.org/docs/c_glib/arrow-glib/input-stream-classes.html
NB. =========================================================
inputStreamBindings =: lib 0 : 0
i * l *	garrow_input_stream_advance	(GArrowInputStream *input_stream, gint64 n_bytes, GError **error); gboolean
i * i *	garrow_input_stream_align	(GArrowInputStream *input_stream, gint32 alignment, GError **error); gboolean
* * *	garrow_input_stream_read_tensor	(GArrowInputStream *input_stream, GError **error); GArrowTensor *
* * * * *	garrow_input_stream_read_record_batch	(GArrowInputStream *input_stream, GArrowSchema *schema, GArrowReadOptions *options, GError **error); GArrowRecordBatch *
l *	garrow_seekable_input_stream_get_size	(GArrowSeekableInputStream *input_stream, GError **error); guint64
i *	garrow_seekable_input_stream_get_support_zero_copy	(GArrowSeekableInputStream *input_stream); gboolean
* * l l *	garrow_seekable_input_stream_read_at	(GArrowSeekableInputStream *input_stream, gint64 position, gint64 n_bytes, GError **error); GArrowBuffer *
* * l l *	garrow_seekable_input_stream_read_at_bytes	(GArrowSeekableInputStream *input_stream, gint64 position, gint64 n_bytes, GError **error); GBytes *
* * l *	garrow_seekable_input_stream_peek	(GArrowSeekableInputStream *input_stream , gint64 n_bytes , GError **error); GBytes *
* * *	garrow_file_input_stream_new	(const gchar *path, GError **error); GArrowFileInputStream *
* i *	garrow_file_input_stream_new_file_descriptor	(gint file_descriptor, GError **error); GArrowFileInputStream *
i * *	garrow_file_input_stream_get_file_descriptor	(const gchar *path, GError **error); gint
* *	garrow_buffer_input_stream_new	(GArrowBuffer *buffer); GArrowBufferInputStream *
* *	garrow_buffer_input_stream_get_buffer	(GArrowBufferInputStream *input_stream); GArrowBuffer *
* * *	garrow_memory_mapped_input_stream_new	(const gchar *path, GError **error); GArrowMemoryMappedInputStream *
* *	garrow_gio_input_stream_new	(GInputStream *gio_input_stream); GArrowGIOInputStream *
* *	garrow_gio_input_stream_get_raw	(GArrowGIOInputStream *input_stream); GInputStream *
* * * *	garrow_compressed_input_stream_new	(GArrowCodec *codec, GArrowInputStream *raw, GError **error); GArrowCompressedInputStream *
)

NB. Output
NB. GArrowWritable — Output interface
NB. =========================================================
NB. Writeable
NB. https://arrow.apache.org/docs/c_glib/arrow-glib/GArrowWritable.html
NB. =========================================================
writeableBindings =: lib 0 : 0
n *	garrow_writable_default_init	(GArrowWritableInterface *iface); static void
i * * l *	garrow_writable_write	(GArrowWritable *writable, const guint8 *data, gint64 n_bytes, GError **error); gboolean
i * *	garrow_writable_flush	(GArrowWritable *writable, GError **error); gboolean
* *	garrow_writable_get_raw	(GArrowWritable *writable); std::shared_ptr<arrow::io::Writable>
)

NB. GArrowWritableFile — File output interface
NB. =========================================================
NB. Writeable File
NB. https://arrow.apache.org/docs/c_glib/arrow-glib/GArrowWritableFile.html
NB. =========================================================
writeableFileBindings =: lib 0 : 0
n *	garrow_writable_file_default_init	(GArrowWritableFileInterface *iface); static void
i * l i i *	garrow_writable_file_write_at	(GArrowWritableFile *writable_file, gint64 position, const guint8 *data, gint64 n_bytes, GError **error); gboolean
* *	garrow_writable_file_get_raw(GArrowWritableFile *writable_file); std::shared_ptr<arrow::io::WritableFile>
)

NB. Output stream classes
NB. =========================================================
NB. Output Stream
NB. https://arrow.apache.org/docs/c_glib/arrow-glib/output-stream-classes.html
NB. =========================================================
outputStreamBindings =: lib 0 : 0
i * i *	garrow_output_stream_align	(GArrowOutputStream *stream, gint32 alignment, GError **error); gboolean
i * * *	garrow_output_stream_write_tensor	(GArrowOutputStream *stream , GArrowTensor *tensor , GError **error); gint64
i * * * *	garrow_output_stream_write_record_batch	(GArrowOutputStream *stream, GArrowRecordBatch *record_batch, GArrowWriteOptions *options, GError **error); gint64
* * i *	garrow_file_output_stream_new	(const gchar *path, gboolean append, GError **error); GArrowFileOutputStream *
* *	garrow_buffer_output_stream_new	(GArrowResizableBuffer *buffer); GArrowBufferOutputStream *
* *	garrow_gio_output_stream_new	(GOutputStream *gio_output_stream); GArrowGIOOutputStream *
* *	garrow_gio_output_stream_get_raw	(GArrowGIOOutputStream *output_stream); GOutputStream *
)

NB. Input and output

NB. GArrowFile — File interface
NB. =========================================================
NB. File
NB. https://arrow.apache.org/docs/c_glib/arrow-glib/GArrowFile.html
NB. =========================================================
fileBindings =: lib 0 : 0
i * *	garrow_file_close	(GArrowFile *file, GError **error); gboolean
i *	garrow_file_is_closed	(GArrowFile *file); gboolean
l *	garrow_file_tell	(GArrowFile *file, GError **error); gint64
* *	garrow_file_get_mode	(GArrowFile *file); GArrowFileMode
)