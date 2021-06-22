NB. IO

NB. Input
NB. GArrowReadable — Input interface
NB. =========================================================
NB. Readable
NB. https://arrow.apache.org/docs/c_glib/arrow-glib/GArrowReadable.html
NB. =========================================================
readableBindings =: lib 0 : 0
ADD TYPES
garrow_readable_default_init(GArrowReadableInterface *iface); static void
garrow_readable_read(GArrowReadable *readable, gint64 n_bytes, GError **error); GArrowBuffer *
garrow_readable_read_bytes(GArrowReadable *readable, gint64 n_bytes, GError **error); GBytes *
garrow_readable_get_raw(GArrowReadable *readable); std::shared_ptr<arrow::io::Readable>
)

NB. Input stream classes
NB. =========================================================	
NB. Input Stream	
NB. https://arrow.apache.org/docs/c_glib/arrow-glib/input-stream-classes.html
NB. =========================================================
inputStreamBindings =: lib 0 : 0
ADD TYPES
garrow_input_stream_get_raw_file_interface(GArrowFile *file); static std::shared_ptr<arrow::io::FileInterface>
garrow_input_stream_file_interface_init(GArrowFileInterface *iface); static void
garrow_input_stream_get_raw_readable_interface(GArrowReadable *readable); static std::shared_ptr<arrow::io::Readable>
garrow_input_stream_readable_interface_init(GArrowReadableInterface *iface); static void
garrow_input_stream_finalize(GObject *object); static void
garrow_input_stream_set_property(GObject *object , guint prop_id , const GValue *value , GParamSpec *pspec); static void
garrow_input_stream_get_property(GObject *object , guint prop_id , GValue *value , GParamSpec *pspec); static void
garrow_input_stream_read(GInputStream *stream, void *buffer, gsize count, GCancellable *cancellable, GError **error); static gssize
garrow_input_stream_skip(GInputStream *stream, gsize count, GCancellable *cancellable, GError **error); static gssize
garrow_input_stream_close(GInputStream *stream, GCancellable *cancellable, GError **error); static gboolean
garrow_input_stream_init(GArrowInputStream *object); static void
garrow_input_stream_class_init(GArrowInputStreamClass *klass); static void
garrow_input_stream_advance(GArrowInputStream *input_stream, gint64 n_bytes, GError **error); gboolean
garrow_input_stream_align(GArrowInputStream *input_stream, gint32 alignment, GError **error); gboolean
garrow_input_stream_read_tensor(GArrowInputStream *input_stream, GError **error); GArrowTensor *
garrow_input_stream_read_record_batch(GArrowInputStream *input_stream, GArrowSchema *schema, GArrowReadOptions *options, GError **error); GArrowRecordBatch *
garrow_seekable_input_stream_init(GArrowSeekableInputStream *object); static void
garrow_seekable_input_stream_class_init(GArrowSeekableInputStreamClass *klass); static void
garrow_seekable_input_stream_get_size(GArrowSeekableInputStream *input_stream, GError **error); guint64
garrow_seekable_input_stream_get_support_zero_copy(GArrowSeekableInputStream *input_stream); gboolean
garrow_seekable_input_stream_read_at(GArrowSeekableInputStream *input_stream, gint64 position, gint64 n_bytes, GError **error); GArrowBuffer *
garrow_seekable_input_stream_read_at_bytes(GArrowSeekableInputStream *input_stream, gint64 position, gint64 n_bytes, GError **error); GBytes *
garrow_seekable_input_stream_peek(GArrowSeekableInputStream *input_stream , gint64 n_bytes , GError **error); GBytes *
garrow_buffer_input_stream_dispose(GObject *object); static void
garrow_buffer_input_stream_set_property(GObject *object, guint prop_id, const GValue *value, GParamSpec *pspec); static void
garrow_buffer_input_stream_get_property(GObject *object, guint prop_id, GValue *value, GParamSpec *pspec); static void
garrow_buffer_input_stream_init(GArrowBufferInputStream *object); static void
garrow_buffer_input_stream_class_init(GArrowBufferInputStreamClass *klass); static void
garrow_buffer_input_stream_new(GArrowBuffer *buffer); GArrowBufferInputStream *
garrow_buffer_input_stream_get_buffer(GArrowBufferInputStream *input_stream); GArrowBuffer *
garrow_memory_mapped_input_stream_init(GArrowMemoryMappedInputStream *object); static void
garrow_memory_mapped_input_stream_class_init(GArrowMemoryMappedInputStreamClass *klass); static void
garrow_memory_mapped_input_stream_new(const gchar *path, GError **error); GArrowMemoryMappedInputStream *
garrow_gio_input_stream_dispose(GObject *object); static void
garrow_gio_input_stream_set_property(GObject *object, guint prop_id, const GValue *value, GParamSpec *pspec); static void
garrow_gio_input_stream_get_property(GObject *object, guint prop_id, GValue *value, GParamSpec *pspec); static void
garrow_gio_input_stream_init(GArrowGIOInputStream *object); static void
garrow_gio_input_stream_class_init(GArrowGIOInputStreamClass *klass); static void
garrow_gio_input_stream_new(GInputStream *gio_input_stream); GArrowGIOInputStream *
garrow_gio_input_stream_get_raw(GArrowGIOInputStream *input_stream); GInputStream *
garrow_compressed_input_stream_dispose(GObject *object); static void
garrow_compressed_input_stream_set_property(GObject *object, guint prop_id, const GValue *value, GParamSpec *pspec); static void
garrow_compressed_input_stream_get_property(GObject *object, guint prop_id, GValue *value, GParamSpec *pspec); static void
garrow_compressed_input_stream_init(GArrowCompressedInputStream *object); static void
garrow_compressed_input_stream_class_init(GArrowCompressedInputStreamClass *klass); static void
garrow_compressed_input_stream_new(GArrowCodec *codec, GArrowInputStream *raw, GError **error); GArrowCompressedInputStream *
garrow_input_stream_new_raw(std::shared_ptr<arrow::io::InputStream> *arrow_input_stream); ArrowInputStream *
garrow_input_stream_get_raw(GArrowInputStream *input_stream); std::shared_ptr<arrow::io::InputStream>
garrow_seekable_input_stream_new_raw(std::shared_ptr<arrow::io::RandomAccessFile> *arrow_random_access_file); GArrowSeekableInputStream *
garrow_seekable_input_stream_get_raw(GArrowSeekableInputStream *seekable_input_stream); std::shared_ptr<arrow::io::RandomAccessFile>
garrow_buffer_input_stream_new_raw(std::shared_ptr<arrow::io::BufferReader> *arrow_buffer_reader, GArrowBuffer *buffer); GArrowBufferInputStream *
garrow_buffer_input_stream_get_raw(GArrowBufferInputStream *buffer_input_stream); std::shared_ptr<arrow::io::BufferReader>
garrow_memory_mapped_input_stream_new_raw(std::shared_ptr<arrow::io::MemoryMappedFile> *arrow_memory_mapped_file); GArrowMemoryMappedInputStream *
garrow_compressed_input_stream_new_raw(std::shared_ptr<arrow::io::CompressedInputStream> *arrow_raw, GArrowCodec *codec, GArrowInputStream *raw); GArrowCompressedInputStream *
garrow_compressed_input_stream_get_raw(GArrowCompressedInputStream *compressed_input_stream); std::shared_ptr<arrow::io::InputStream>
)

NB. Output
NB. GArrowWritable — Output interface
NB. =========================================================
NB. Writeable
NB. https://arrow.apache.org/docs/c_glib/arrow-glib/GArrowWritable.html
NB. =========================================================
writeableBindings =: lib 0 : 0
ADD TYPES
garrow_writable_default_init(GArrowWritableInterface *iface); static void
garrow_writable_write(GArrowWritable *writable, const guint8 *data, gint64 n_bytes, GError **error); gboolean
garrow_writable_flush(GArrowWritable *writable, GError **error); gboolean
garrow_writable_get_raw(GArrowWritable *writable); std::shared_ptr<arrow::io::Writable>
)

NB. GArrowWritableFile — File output interface
NB. =========================================================
NB. Writeable File
NB. https://arrow.apache.org/docs/c_glib/arrow-glib/GArrowWritableFile.html
NB. =========================================================
writeableFileBindings =: lib 0 : 0
ADD TYPES
garrow_writable_file_default_init(GArrowWritableFileInterface *iface); static void
garrow_writable_file_write_at(GArrowWritableFile *writable_file, gint64 position, const guint8 *data, gint64 n_bytes, GError **error); gboolean
garrow_writable_file_get_raw(GArrowWritableFile *writable_file); std::shared_ptr<arrow::io::WritableFile>
)

NB. Output stream classes
NB. =========================================================
NB. Output Stream
NB. https://arrow.apache.org/docs/c_glib/arrow-glib/output-stream-classes.html
NB. =========================================================
outputStreamBindings =: lib 0 : 0
ADD TYPES
garrow_output_stream_get_raw_file_interface(GArrowFile *file)
garrow_output_stream_file_interface_init(GArrowFileInterface *iface); static void
garrow_output_stream_get_raw_writable_interface(GArrowWritable *writable); static std::shared_ptr<arrow::io::Writable>
garrow_output_stream_writable_interface_init(GArrowWritableInterface *iface); static void
garrow_output_stream_finalize(GObject *object); static void
garrow_output_stream_set_property(GObject *object, guint prop_id, const GValue *value, GParamSpec *pspec); static void
garrow_output_stream_get_property(GObject *object, guint prop_id, GValue *value, GParamSpec *pspec); static void
garrow_output_stream_init(GArrowOutputStream *object); static void
garrow_output_stream_class_init(GArrowOutputStreamClass *klass); static void
garrow_output_stream_align(GArrowOutputStream *stream, gint32 alignment, GError **error); gboolean
garrow_output_stream_write_tensor(GArrowOutputStream *stream , GArrowTensor *tensor , GError **error); gint64
garrow_output_stream_write_record_batch(GArrowOutputStream *stream, GArrowRecordBatch *record_batch, GArrowWriteOptions *options, GError **error); gint64
garrow_file_output_stream_init(GArrowFileOutputStream *file_output_stream); static void
garrow_file_output_stream_class_init(GArrowFileOutputStreamClass *klass); static void
garrow_file_output_stream_new(const gchar *path, gboolean append, GError **error); GArrowFileOutputStream *
garrow_buffer_output_stream_init(GArrowBufferOutputStream *buffer_output_stream); static void
garrow_buffer_output_stream_class_init(GArrowBufferOutputStreamClass *klass); static void
garrow_buffer_output_stream_new(GArrowResizableBuffer *buffer); GArrowBufferOutputStream *
garrow_gio_output_stream_dispose(GObject *object); static void
garrow_gio_output_stream_set_property(GObject *object, guint prop_id, const GValue *value, GParamSpec *pspec); static void
garrow_gio_output_stream_get_property(GObject *object, guint prop_id, GValue *value, GParamSpec *pspec); static void
garrow_gio_output_stream_init(GArrowGIOOutputStream *object); static void
garrow_gio_output_stream_class_init(GArrowGIOOutputStreamClass *klass); static void
garrow_gio_output_stream_new(GOutputStream *gio_output_stream); GArrowGIOOutputStream *
garrow_gio_output_stream_get_raw(GArrowGIOOutputStream *output_stream); GOutputStream *
garrow_compressed_output_stream_dispose(GObject *object); static void
garrow_compressed_output_stream_set_property(GObject *object, guint prop_id, const GValue *value, GParamSpec *pspec); static void
garrow_compressed_output_stream_get_property(GObject *object, guint prop_id, GValue *value, GParamSpec *pspec); static void
garrow_compressed_output_stream_init(GArrowCompressedOutputStream *object); static void
garrow_compressed_output_stream_class_init(GArrowCompressedOutputStreamClass *klass); static void
garrow_compressed_output_stream_new(GArrowCodec *codec, GArrowOutputStream *raw, GError **error); GArrowCompressedOutputStream *
garrow_output_stream_new_raw(std::shared_ptr<arrow::io::OutputStream> *arrow_output_stream); GArrowOutputStream *
garrow_output_stream_get_raw(GArrowOutputStream *output_stream); std::shared_ptr<arrow::io::OutputStream>
garrow_file_output_stream_new_raw(std::shared_ptr<arrow::io::FileOutputStream> *arrow_file_output_stream); GArrowFileOutputStream *
garrow_buffer_output_stream_new_raw(std::shared_ptr<arrow::io::BufferOutputStream> *arrow_buffer_output_stream); GArrowBufferOutputStream *
garrow_compressed_output_stream_new_raw(std::shared_ptr<arrow::io::CompressedOutputStream> *arrow_raw, GArrowCodec *codec, GArrowOutputStream *raw); GArrowCompressedOutputStream *
garrow_compressed_output_stream_get_raw(GArrowCompressedOutputStream *compressed_output_stream); std::shared_ptr<arrow::io::OutputStream>
)

NB. Input and output

NB. GArrowFile — File interface
NB. =========================================================
NB. File
NB. https://arrow.apache.org/docs/c_glib/arrow-glib/GArrowFile.html
NB. =========================================================
fileBindings =: lib 0 : 0
ADD TYPES
garrow_file_default_init(GArrowFileInterface *iface); static void
garrow_file_close(GArrowFile *file, GError **error); gboolean
garrow_file_is_closed(GArrowFile *file); gboolean
garrow_file_tell(GArrowFile *file, GError **error); gint64
garrow_file_get_mode(GArrowFile *file); GArrowFileMode
garrow_file_get_raw(GArrowFile *file); std::shared_ptr<arrow::io::FileInterface>
)