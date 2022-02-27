NB. =========================================================
NB. Buffer
NB. https://arrow.apache.org/docs/c_glib/arrow-glib/buffer-classes.html
NB. =========================================================

bufferBindings =: lib 0 : 0
n *	garrow_buffer_finalize	(GObject *object); static void
n * i * *	garrow_buffer_set_property	(GObject *object, guint prop_id, const GValue *value, GParamSpec *pspec); static void
n * i * *	garrow_buffer_get_property	(GObject *object, guint prop_id, GValue *value, GParamSpec *pspec); static void
n *	garrow_buffer_init	(GArrowBuffer *object); static void
n * 	garrow_buffer_class_init	(GArrowBufferClass *klass); static void
* * i	garrow_buffer_new	(const guint8 *data, gint64 size); GArrowBuffer *
* *	garrow_buffer_new_bytes	(GBytes *data); GArrowBuffer *
i * *	garrow_buffer_equal	(GArrowBuffer *buffer, GArrowBuffer *other_buffer); gboolean
i * * i	garrow_buffer_equal_n_bytes	(GArrowBuffer *buffer, GArrowBuffer *other_buffer, gint64 n_bytes); gboolean
i *	garrow_buffer_is_mutable	(GArrowBuffer *buffer); gboolean
i *	garrow_buffer_get_capacity	(GArrowBuffer *buffer); gint64
* *	garrow_buffer_get_data	(GArrowBuffer *buffer); GBytes *
* *	garrow_buffer_get_mutable_data	(GArrowBuffer *buffer); GBytes *
i *	garrow_buffer_get_size	(GArrowBuffer *buffer); gint64
* *	garrow_buffer_get_parent	(GArrowBuffer *buffer); GArrowBuffer *
* * i i *	garrow_buffer_copy	(GArrowBuffer *buffer, gint64 start, gint64 size, GError **error); GArrowBuffer *
* * i i	garrow_buffer_slice	(GArrowBuffer *buffer, gint64 offset, gint64 size); GArrowBuffer *
n *	garrow_mutable_buffer_init	(GArrowMutableBuffer *object); static void
n *	garrow_mutable_buffer_class_init	(GArrowMutableBufferClass *klass); static void
* * i	garrow_mutable_buffer_new	(guint8 *data, gint64 size); GArrowMutableBuffer *
* *	garrow_mutable_buffer_new_bytes	(GBytes *data); GArrowMutableBuffer *
* * i i	garrow_mutable_buffer_slice	(GArrowMutableBuffer *buffer, gint64 offset, gint64 size); GArrowMutableBuffer *
i * i *i i *	garrow_mutable_buffer_set_data	(GArrowMutableBuffer *buffer, gint64 offset, const guint8 *data, gint64 size, GError **error); gboolean
n *	garrow_resizable_buffer_init	(GArrowResizableBuffer *object); static void
n *	garrow_resizable_buffer_class_init	(GArrowResizableBufferClass *klass); static void
* i *	garrow_resizable_buffer_new	(gint64 initial_size, GError **error); GArrowResizableBuffer *
i * i *	garrow_resizable_buffer_resize	(GArrowResizableBuffer *buffer, gint64 new_size, GError **error); gboolean
i * i *	garrow_resizable_buffer_reserve	(GArrowResizableBuffer *buffer, gint64 new_capacity, GError **error); gboolean
* *	garrow_buffer_new_raw	(std::shared_ptr<arrow::Buffer> *arrow_buffer); ArrowBuffer *
* * *	garrow_buffer_new_raw_bytes	(std::shared_ptr<arrow::Buffer> *arrow_buffer, GBytes *data); GArrowBuffer *
* * *	garrow_buffer_new_raw_parent	(std::shared_ptr<arrow::Buffer> *arrow_buffer, GArrowBuffer *parent); GArrowBuffer *
* *	garrow_buffer_get_raw	(GArrowBuffer *buffer); std::shared_ptr<arrow::Buffer>
* *	garrow_mutable_buffer_new_raw	(std::shared_ptr<arrow::MutableBuffer> *arrow_buffer); GArrowMutableBuffer *
* * *	garrow_mutable_buffer_new_raw_bytes	(std::shared_ptr<arrow::MutableBuffer> *arrow_buffer, GBytes *data); GArrowMutableBuffer *
* *	garrow_resizable_buffer_new_raw	(std::shared_ptr<arrow::ResizableBuffer> *arrow_buffer); GArrowResizableBuffer *
)