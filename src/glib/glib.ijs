NB. =========================================================
NB. GObject bindings
NB. 
NB. =========================================================

gLibBindings =: lib 0 : 0 
* * i	g_bytes_new	(gconstpointer data,  gsize size);	GBytes*
i *	g_bytes_get_size	(GBytes* bytes)	gsize
* * *	g_bytes_get_data	(GBytes* bytes, gsize* size) gconstpointer
* * *	g_bytes_unref_to_data	(GBytes* bytes, gsize* size) gpointer
* *	g_bytes_unref_to_array	(GBytes* bytes) GByteArray*
n * * * *	g_object_get	(GObject* object, const gchar* first_property_name, *first_value, NULL); void
n * * * *	g_object_set	(GObject* object, const gchar* first_property_name, *first_value, NULL); void
* *	g_list_length	(GList* list);	guint
* * i	g_list_nth_data	(GList* list, guint n);	gpointer
* *	g_type_name	(GType type);	gchar *
* *	g_type_class_peek	( GType type);	GObjectTypeClass*
* *	g_param_spec_get_name	(GParamSpec* pspec)	const gchar*
* * *	g_object_class_find_property	( GObjectClass* oclass,  const gchar* property_name)	GParamSpec*
* *	g_type_create_instance	(GType type)	GTypeInstance*
)