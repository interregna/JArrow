NB. =========================================================
NB. GObject bindings
NB. 
NB. =========================================================

gLibBindings =: lib 0 : 0 
* i	g_malloc	(gsize n_bytes); 	pointer
n *	g_free	(gpointer mem) void
* & i	g_bytes_new	(gconstpointer data,  gsize size);	GBytes*
* & i	g_bytes_new_static	(gconstpointer data, gsize size);	GBytes*
* & i	g_bytes_new_take	(gconstpointer data, gsize size);	GBytes*
i *	g_bytes_get_size	(GBytes* bytes);	gsize
* * *	g_bytes_get_data	(GBytes* bytes, gsize* size); gconstpointer
* * *	g_bytes_unref_to_data	(GBytes* bytes, gsize* size); gpointer
* *	g_bytes_unref_to_array	(GBytes* bytes); GByteArray*
n *	g_bytes_unref 	(GBytes* bytes); 	void
n * * * *	g_object_get	(GObject* object, const gchar* first_property_name, *first_value, NULL); void
n * * * *	g_object_set	(GObject* object, const gchar* first_property_name, *first_value, NULL); void
n * 	g_object_unref	(GObject* object); void
n *	g_clear_object	(GObject** object_ptr);	void
*	g_list_alloc	(void) GList*
* * *	g_list_append	(GList* list, gpointer data) GList*
n * 	g_list_free	(GList* list) void
* *	g_list_length	(GList* list) guint
* * i	g_list_nth_data	(GList* list, guint n);	gpointer
* *	g_type_name	(GType type);	gchar *
* *	g_type_class_peek	( GType type);	GObjectTypeClass*
* *	g_param_spec_get_name	(GParamSpec* pspec)	const gchar*
* * *	g_object_class_find_property	( GObjectClass* oclass,  const gchar* property_name)	GParamSpec*
* *	g_type_create_instance	(GType type)	GTypeInstance*
* * * *	g_filename_to_uri	(const gchar* filename,  const gchar* hostname,  GError** error) gchar*
)


