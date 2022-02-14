
NB. =========================================================
NB. GPU
NB. https://arrow.apache.org/docs/c_glib/arrow-glib/cuda-classes.html
NB. =========================================================

cudaBindings =: lib 0 : 0
ADD TYPES
garrow_cuda_device_manager_new (GError **error);GArrowCUDADeviceManager *
garrow_cuda_device_manager_get_context(GArrowCUDADeviceManager *manager, gint gpu_number, GError **error);;GArrowCUDAContext *
garrow_cuda_device_manager_get_n_devices(GArrowCUDADeviceManager *manager);;gsize
garrow_cuda_context_get_allocated_size(GArrowCUDAContext *context);;gint64
garrow_cuda_buffer_new (GArrowCUDAContext *context,gint64 size,GError **error);;GArrowCUDABuffer *
garrow_cuda_buffer_new_ipc (GArrowCUDAContext *context,    GArrowCUDAIPCMemoryHandle *handle,    GError **error);;GArrowCUDABuffer *
garrow_cuda_buffer_new_record_batch (GArrowCUDAContext *context,      GArrowRecordBatch *record_batch,      GError **error);;GArrowCUDABuffer *
garrow_cuda_buffer_copy_to_host (GArrowCUDABuffer *buffer,  gint64 position,  gint64 size,  GError **error);;GBytes *
garrow_cuda_buffer_copy_from_host (GArrowCUDABuffer *buffer,    const guint8 *data,    gint64 size,    GError **error);;gboolean
garrow_cuda_buffer_export (GArrowCUDABuffer *buffer,   GError **error);;GArrowCUDAIPCMemoryHandle *
garrow_cuda_buffer_get_context (GArrowCUDABuffer *buffer);;GArrowCUDAContext *
garrow_cuda_buffer_read_record_batch (GArrowCUDABuffer *buffer,       GArrowSchema *schema,       GArrowReadOptions *options,       GError **error);;GArrowRecordBatch *
garrow_cuda_host_buffer_new (gint gpu_number,     gint64 size,     GError **error);;GArrowCUDAHostBuffer *
garrow_cuda_ipc_memory_handle_new (const guint8 *data,    gsize size,    GError **error);;GArrowCUDAIPCMemoryHandle *
garrow_cuda_ipc_memory_handle_serialize(GArrowCUDAIPCMemoryHandle *handle, GError **error);;GArrowBuffer *
garrow_cuda_buffer_input_stream_new (GArrowCUDABuffer *buffer);;GArrowCUDABufferInputStream *
garrow_cuda_buffer_output_stream_new (GArrowCUDABuffer *buffer);;GArrowCUDABufferOutputStream *
garrow_cuda_buffer_output_stream_set_buffer_size(GArrowCUDABufferOutputStream *stream, gint64 size, GError **error);;gboolean
garrow_cuda_buffer_output_stream_get_buffer_size(GArrowCUDABufferOutputStream *stream);;gint64
garrow_cuda_buffer_output_stream_get_buffered_size(GArrowCUDABufferOutputStream *stream);;gint64
)