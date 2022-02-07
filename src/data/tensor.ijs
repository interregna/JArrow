NB. =========================================================
NB. Tensor
NB. https://arrow.apache.org/docs/c_glib/arrow-glib/GArrowTensor.html
NB. =========================================================

tensorBindings =: lib 0 : 0
ADD TYPES
garrow_tensor_dispose(GObject *object); static void
garrow_tensor_finalize(GObject *object); static void
garrow_tensor_set_property(GObject *object, guint prop_id, const GValue *value, GParamSpec *pspec); static void
garrow_tensor_get_property(GObject *object, guint prop_id, GValue *value, GParamSpec *pspec); static void
garrow_tensor_init(GArrowTensor *object); static void
garrow_tensor_class_init(GArrowTensorClass *klass); static void
garrow_tensor_new(GArrowDataType *data_type, GArrowBuffer *data, gint64 *shape, gsize n_dimensions, gint64 *strides, gsize n_strides, gchar **dimension_names, gsize n_dimension_names); GArrowTensor *
garrow_tensor_equal(GArrowTensor *tensor, GArrowTensor *other_tensor); gboolean
garrow_tensor_get_value_data_type(GArrowTensor *tensor); GArrowDataType *
garrow_tensor_get_value_type(GArrowTensor *tensor); GArrowType
garrow_tensor_get_buffer(GArrowTensor *tensor); GArrowBuffer *
garrow_tensor_get_shape(GArrowTensor *tensor, gint *n_dimensions); gint64 *
garrow_tensor_get_strides(GArrowTensor *tensor, gint *n_strides); gint64 *
garrow_tensor_get_n_dimensions(GArrowTensor *tensor); gint
garrow_tensor_get_dimension_name(GArrowTensor *tensor, gint i); const gchar *
garrow_tensor_get_size(GArrowTensor *tensor); gint64
garrow_tensor_is_mutable(GArrowTensor *tensor); gboolean
garrow_tensor_is_contiguous(GArrowTensor *tensor); gboolean
garrow_tensor_is_row_major(GArrowTensor *tensor); gboolean
garrow_tensor_is_column_major(GArrowTensor *tensor); gboolean
garrow_tensor_new_raw(std::shared_ptr<arrow::Tensor> *arrow_tensor); ArrowTensor *
garrow_tensor_new_raw_buffer(std::shared_ptr<arrow::Tensor> *arrow_tensor, GArrowBuffer *buffer); GArrowTensor *
garrow_tensor_get_raw(GArrowTensor *tensor); std::shared_ptr<arrow::Tensor>
)