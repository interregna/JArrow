NB. =========================================================
NB. File System
NB. https://arrow.apache.org/docs/c_glib/arrow-glib/file-system-classes.html
NB. =========================================================

fileSystemBindings =: lib 0 : 0
*	garrow_file_info_new	(void); GArrowFileInfo *
b * *	garrow_file_info_equal	(GArrowFileInfo *file_info, GArrowFileInfo *other_file_info); gboolean
b *	garrow_file_info_is_file	(GArrowFileInfo *file_info); gboolean
b *	garrow_file_info_is_dir	(GArrowFileInfo *file_info); gboolean
* *	garrow_file_info_to_string	(GArrowFileInfo *file_info); gchar *
* * *	garrow_file_system_create	(const gchar *uri, GError **error); GArrowFileSystem *
* *	garrow_file_system_get_type_name	(GArrowFileSystem *file_system); gchar *
* * * *	garrow_file_system_get_file_info	(GArrowFileSystem *file_system , const gchar *path , GError **error); GArrowFileInfo *
* * * i *	garrow_file_system_get_file_infos_paths	(GArrowFileSystem *file_system, const gchar **paths, gsize n_paths, GError **error); GList *
* * * *	garrow_file_system_get_file_infos_selector	(GArrowFileSystem *file_system, GArrowFileSelector *file_selector, GError **error); GList *
b * * b *	garrow_file_system_create_dir	(GArrowFileSystem *file_system, const gchar *path, gboolean recursive, GError **error); gboolean
b * * *	garrow_file_system_delete_dir	(GArrowFileSystem *file_system, const gchar *path, GError **error); gboolean
b * * *	garrow_file_system_delete_dir_contents	(GArrowFileSystem *file_system, const gchar *path, GError **error); gboolean
b * * *	garrow_file_system_delete_file	(GArrowFileSystem *file_system, const gchar *path, GError **error); gboolean
b * * i *	garrow_file_system_delete_files	(GArrowFileSystem *file_system, const gchar **paths, gsize n_paths, GError **error); gboolean
b * * * *	garrow_file_system_move	(GArrowFileSystem *file_system, const gchar *src, const gchar *dest, GError **error); gboolean
b * * * *	garrow_file_system_copy_file	(GArrowFileSystem *file_system, const gchar *src, const gchar *dest, GError **error); gboolean
* * * *	garrow_file_system_open_input_stream	(GArrowFileSystem *file_system, const gchar *path, GError **error); GArrowInputStream *
* * * *	garrow_file_system_open_input_file	(GArrowFileSystem *file_system, const gchar *path, GError **error); GArrowSeekableInputStream *
* * * *	garrow_file_system_open_output_stream	(GArrowFileSystem *file_system, const gchar *path, GError **error); GArrowOutputStream *
* * * *	garrow_file_system_open_append_stream	(GArrowFileSystem *file_system, const gchar *path, GError **error); GArrowOutputStream *
n *	garrow_sub_tree_file_system_dispose	(GObject *object); static void
* * *	garrow_sub_tree_file_system_new	(const gchar *base_path, GArrowFileSystem *base_file_system); GArrowSubTreeFileSystem *
* * l	garrow_slow_file_system_new_average_latency	(GArrowFileSystem *base_file_system, gdouble average_latency); GArrowSlowFileSystem *
* * l i	garrow_slow_file_system_new_average_latency_and_seed	(GArrowFileSystem *base_file_system, gdouble average_latency, gint32 seed); GArrowSlowFileSystem *
)

NB. =========================================================
NB. Local File System	
NB. https://arrow.apache.org/docs/c_glib/arrow-glib/local-file-system-classes.html
NB. =========================================================

localFileSystemBindings =: lib 0 : 0
*	garrow_local_file_system_options_new	(void); GArrowLocalFileSystemOptions *	
n *	garrow_local_file_system_init	(GArrowLocalFileSystem *file_system); static void
* *	garrow_local_file_system_new	(GArrowLocalFileSystemOptions *options); GArrowLocalFileSystem *
)