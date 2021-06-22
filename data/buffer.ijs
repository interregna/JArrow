NB. =========================================================
NB. Buffer
NB. https://arrow.apache.org/docs/c_glib/arrow-glib/buffer-classes.html
NB. =========================================================

bufferBindings =: lib 0 : 0
garrow_buffer_finalize(GObject *object); static void
garrow_buffer_set_property(GObject *object, guint prop_id, const GValue *value, GParamSpec *pspec); static void
garrow_buffer_get_property(GObject *object, guint prop_id, GValue *value, GParamSpec *pspec); static void
garrow_buffer_init(GArrowBuffer *object); static void
garrow_buffer_class_init(GArrowBufferClass *klass); static void
garrow_buffer_new(const guint8 *data, gint64 size); GArrowBuffer *
garrow_buffer_new_bytes(GBytes *data); GArrowBuffer *
garrow_buffer_equal(GArrowBuffer *buffer, GArrowBuffer *other_buffer); gboolean
garrow_buffer_equal_n_bytes(GArrowBuffer *buffer, GArrowBuffer *other_buffer, gint64 n_bytes); gboolean
garrow_buffer_is_mutable(GArrowBuffer *buffer); gboolean
garrow_buffer_get_capacity(GArrowBuffer *buffer); gint64
garrow_buffer_get_data(GArrowBuffer *buffer); GBytes *
garrow_buffer_get_mutable_data(GArrowBuffer *buffer); GBytes *
garrow_buffer_get_size(GArrowBuffer *buffer); gint64
garrow_buffer_get_parent(GArrowBuffer *buffer); GArrowBuffer *
garrow_buffer_copy(GArrowBuffer *buffer, gint64 start, gint64 size, GError **error); GArrowBuffer *
garrow_buffer_slice(GArrowBuffer *buffer, gint64 offset, gint64 size); GArrowBuffer *
garrow_mutable_buffer_init(GArrowMutableBuffer *object); static void
garrow_mutable_buffer_class_init(GArrowMutableBufferClass *klass); static void
garrow_mutable_buffer_new(guint8 *data, gint64 size); GArrowMutableBuffer *
garrow_mutable_buffer_new_bytes(GBytes *data); GArrowMutableBuffer *
garrow_mutable_buffer_slice(GArrowMutableBuffer *buffer, gint64 offset, gint64 size); GArrowMutableBuffer *
garrow_mutable_buffer_set_data(GArrowMutableBuffer *buffer, gint64 offset, const guint8 *data, gint64 size, GError **error); gboolean
garrow_resizable_buffer_init(GArrowResizableBuffer *object); static void
garrow_resizable_buffer_class_init(GArrowResizableBufferClass *klass); static void
garrow_resizable_buffer_new(gint64 initial_size, GError **error); GArrowResizableBuffer *
garrow_resizable_buffer_resize(GArrowResizableBuffer *buffer, gint64 new_size, GError **error); gboolean
garrow_resizable_buffer_reserve(GArrowResizableBuffer *buffer, gint64 new_capacity, GError **error); gboolean
garrow_buffer_new_raw(std::shared_ptr<arrow::Buffer> *arrow_buffer); ArrowBuffer *
garrow_buffer_new_raw_bytes(std::shared_ptr<arrow::Buffer> *arrow_buffer, GBytes *data); GArrowBuffer *
garrow_buffer_new_raw_parent(std::shared_ptr<arrow::Buffer> *arrow_buffer, GArrowBuffer *parent); GArrowBuffer *
garrow_buffer_get_raw(GArrowBuffer *buffer); std::shared_ptr<arrow::Buffer>
garrow_mutable_buffer_new_raw(std::shared_ptr<arrow::MutableBuffer> *arrow_buffer); GArrowMutableBuffer *
garrow_mutable_buffer_new_raw_bytes(std::shared_ptr<arrow::MutableBuffer> *arrow_buffer, GBytes *data); GArrowMutableBuffer *
garrow_resizable_buffer_new_raw(std::shared_ptr<arrow::ResizableBuffer> *arrow_buffer); GArrowResizableBuffer *
)