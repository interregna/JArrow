NB. =========================================================
NB. Buffer
NB. https://arrow.apache.org/docs/c_glib/arrow-glib/buffer-classes.html
NB. =========================================================

bufferBindings =: lib 0 : 0
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
* * i	garrow_mutable_buffer_new	(guint8 *data, gint64 size); GArrowMutableBuffer *
* *	garrow_mutable_buffer_new_bytes	(GBytes *data); GArrowMutableBuffer *
* * i i	garrow_mutable_buffer_slice	(GArrowMutableBuffer *buffer, gint64 offset, gint64 size); GArrowMutableBuffer *
i * i *i i *	garrow_mutable_buffer_set_data	(GArrowMutableBuffer *buffer, gint64 offset, const guint8 *data, gint64 size, GError **error); gboolean
* i *	garrow_resizable_buffer_new	(gint64 initial_size, GError **error); GArrowResizableBuffer *
i * i *	garrow_resizable_buffer_resize	(GArrowResizableBuffer *buffer, gint64 new_size, GError **error); gboolean
i * i *	garrow_resizable_buffer_reserve	(GArrowResizableBuffer *buffer, gint64 new_capacity, GError **error); gboolean
)
