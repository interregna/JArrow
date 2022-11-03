NB. Memory
NB. =========================================================
NB. https://arrow.apache.org/docs/c_glib/arrow-glib/memory-pool-classes.html#garrow-memory-pool-default
NB. =========================================================

memoryBindings =: lib 0 : 0
*	garrow_memory_pool_default	(); GArrowMemoryPool *
l *	garrow_memory_pool_get_bytes_allocated	(GArrowMemoryPool *memory_pool); gint64
l *	garrow_memory_pool_get_max_memory 	(GArrowMemoryPool *memory_pool); gint64
*c *	garrow_memory_pool_get_backend_name 	(GArrowMemoryPool *memory_pool); gchar *
)
