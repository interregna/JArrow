NB. =========================================================
NB. File System
NB. https://arrow.apache.org/docs/c_glib/arrow-glib/file-system-classes.html
NB. =========================================================

fileSystemBindings =: lib 0 : 0
ADD TYPES
garrow_file_info_finalize(GObject *object); static void
garrow_file_info_set_property(GObject *object, guint prop_id, const GValue *value, GParamSpec *pspec); static void
garrow_file_info_get_property(GObject *object, guint prop_id, GValue *value, GParamSpec *pspec); static void
garrow_file_info_init(GArrowFileInfo *object); static void
garrow_file_info_class_init(GArrowFileInfoClass *klass); static void
garrow_file_info_new(void); GArrowFileInfo *
garrow_file_info_equal(GArrowFileInfo *file_info, GArrowFileInfo *other_file_info); gboolean
garrow_file_info_is_file(GArrowFileInfo *file_info); gboolean
garrow_file_info_is_dir(GArrowFileInfo *file_info); gboolean
garrow_file_info_to_string(GArrowFileInfo *file_info); gchar *
garrow_file_selector_finalize(GObject *object); static void
garrow_file_selector_set_property(GObject *object , guint prop_id , const GValue *value , GParamSpec *pspec); static void
garrow_file_selector_get_property(GObject *object , guint prop_id , GValue *value , GParamSpec *pspec); static void
garrow_file_selector_init(GArrowFileSelector *object); static void
garrow_file_selector_class_init(GArrowFileSelectorClass *klass); static void
garrow_file_system_finalize(GObject *object); static void
garrow_file_system_set_property(GObject *object, guint prop_id, const GValue *value, GParamSpec *pspec); static void
garrow_file_system_init(GArrowFileSystem *object); static void
garrow_file_system_class_init(GArrowFileSystemClass *klass); static void
garrow_file_system_create(const gchar *uri, GError **error); GArrowFileSystem *
garrow_file_system_get_type_name(GArrowFileSystem *file_system); gchar *
garrow_file_system_get_file_info(GArrowFileSystem *file_system , const gchar *path , GError **error); GArrowFileInfo *
garrow_file_infos_new(arrow::Result<std::vector<arrow::fs::FileInfo>>&& arrow_result, GError **error, const gchar *context); static inline GList *
garrow_file_system_get_file_infos_paths(GArrowFileSystem *file_system, const gchar **paths, gsize n_paths, GError **error); GList *
garrow_file_system_get_file_infos_selector(GArrowFileSystem *file_system, GArrowFileSelector *file_selector, GError **error); GList *
garrow_file_system_create_dir(GArrowFileSystem *file_system, const gchar *path, gboolean recursive, GError **error); gboolean
garrow_file_system_delete_dir(GArrowFileSystem *file_system, const gchar *path, GError **error); gboolean
garrow_file_system_delete_dir_contents(GArrowFileSystem *file_system, const gchar *path, GError **error); gboolean
garrow_file_system_delete_file(GArrowFileSystem *file_system, const gchar *path, GError **error); gboolean
garrow_file_system_delete_files(GArrowFileSystem *file_system, const gchar **paths, gsize n_paths, GError **error); gboolean
garrow_file_system_move(GArrowFileSystem *file_system, const gchar *src, const gchar *dest, GError **error); gboolean
garrow_file_system_copy_file(GArrowFileSystem *file_system, const gchar *src, const gchar *dest, GError **error); gboolean
garrow_file_system_open_input_stream(GArrowFileSystem *file_system, const gchar *path, GError **error); GArrowInputStream *
garrow_file_system_open_input_file(GArrowFileSystem *file_system, const gchar *path, GError **error); GArrowSeekableInputStream *
garrow_file_system_open_output_stream(GArrowFileSystem *file_system, const gchar *path, GError **error); GArrowOutputStream *
garrow_file_system_open_append_stream(GArrowFileSystem *file_system, const gchar *path, GError **error); GArrowOutputStream *
garrow_sub_tree_file_system_dispose(GObject *object); static void
garrow_sub_tree_file_system_set_property(GObject *object, guint prop_id, const GValue *value, GParamSpec *pspec); static void
garrow_sub_tree_file_system_get_property(GObject *object, guint prop_id, GValue *value, GParamSpec *pspec); static void
garrow_sub_tree_file_system_init(GArrowSubTreeFileSystem *file_system); static void
garrow_sub_tree_file_system_class_init(GArrowSubTreeFileSystemClass *klass); static void
garrow_sub_tree_file_system_new(const gchar *base_path, GArrowFileSystem *base_file_system); GArrowSubTreeFileSystem *
garrow_slow_file_system_dispose(GObject *object); static void
garrow_slow_file_system_set_property(GObject *object, guint prop_id, const GValue *value, GParamSpec *pspec); static void
garrow_slow_file_system_get_property(GObject *object, guint prop_id, GValue *value, GParamSpec *pspec); static void
garrow_slow_file_system_init(GArrowSlowFileSystem *file_system); static void
garrow_slow_file_system_class_init(GArrowSlowFileSystemClass *klass); static void
garrow_slow_file_system_new_average_latency(GArrowFileSystem *base_file_system, gdouble average_latency); GArrowSlowFileSystem *
garrow_slow_file_system_new_average_latency_and_seed(GArrowFileSystem *base_file_system, gdouble average_latency, gint32 seed); GArrowSlowFileSystem *
garrow_mock_file_system_init(GArrowMockFileSystem *file_system); static void
garrow_mock_file_system_class_init(GArrowMockFileSystemClass *klass); static void
garrow_hdfs_file_system_init(GArrowHDFSFileSystem *file_system); static void
garrow_hdfs_file_system_class_init(GArrowHDFSFileSystemClass *klass); static void
garrow_s3_file_system_init(GArrowS3FileSystem *file_system); static void
garrow_s3_file_system_class_init(GArrowS3FileSystemClass *klass); static void
garrow_file_info_new_raw(const arrow::fs::FileInfo &arrow_file_info); ArrowFileInfo *
garrow_file_info_get_raw(GArrowFileInfo *file_info); arrow::fs::FileInfo *
garrow_file_system_new_raw(std::shared_ptr<arrow::fs::FileSystem> *arrow_file_system); GArrowFileSystem *
garrow_file_system_get_raw(GArrowFileSystem *file_system); std::shared_ptr<arrow::fs::FileSystem>
garrow_sub_tree_file_system_new_raw( std::shared_ptr<arrow::fs::FileSystem> *arrow_file_system, GArrowFileSystem *base_file_system); GArrowSubTreeFileSystem *
garrow_slow_file_system_new_raw( std::shared_ptr<arrow::fs::FileSystem> *arrow_file_system, GArrowFileSystem *base_file_system); GArrowSlowFileSystem *
)

NB. =========================================================
NB. Local File System	
NB. https://arrow.apache.org/docs/c_glib/arrow-glib/local-file-system-classes.html
NB. =========================================================

localFileSystemBindings =: lib 0 : 0
ADD TYPES
static void	garrow_local_file_system_options_finalize(GObject *object)
static void	garrow_local_file_system_options_set_property(GObject *object, guint prop_id, const GValue *value, GParamSpec *pspec)
static void	garrow_local_file_system_options_get_property(GObject *object, guint prop_id, GValue *value, GParamSpec *pspec)
static void	garrow_local_file_system_options_init(GArrowLocalFileSystemOptions *object)
static void	garrow_local_file_system_options_class_init(GArrowLocalFileSystemOptionsClass *klass)
GArrowLocalFileSystemOptions *	garrow_local_file_system_options_new(void)
static void	garrow_local_file_system_init(GArrowLocalFileSystem *file_system)
static void	garrow_local_file_system_class_init(GArrowLocalFileSystemClass *klass)
GArrowLocalFileSystem *	garrow_local_file_system_new(GArrowLocalFileSystemOptions *options)
arrow::fs::LocalFileSystemOptions &	garrow_local_file_system_options_get_raw(GArrowLocalFileSystemOptions *options)
GArrowLocalFileSystem *	garrow_local_file_system_new_raw(std::shared_ptr<arrow::fs::FileSystem> *arrow_file_system)
)