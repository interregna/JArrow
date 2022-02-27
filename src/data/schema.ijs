
NB. =========================================================
NB. ArrowSchema
NB. https://arrow.apache.org/docs/c_glib/arrow-glib/GArrowSchema.html

schemaBindings =: lib 0 : 0
* *	garrow_schema_new	(GList *fields); GArrowSchema *
i * *	garrow_schema_equal	(GArrowSchema *schema, GArrowSchema *other_schema); gboolean         
* * i	garrow_schema_get_field	(GArrowSchema *schema, guint i); GArrowField *
* * *	garrow_schema_get_field_by_name	(GArrowSchema *schema,const gchar *name); GArrowField *
i * *	garrow_schema_get_field_index	(GArrowSchema *schema,const gchar *name); gint
i *	garrow_schema_n_fields	(GArrowSchema *schema); guint
* *	garrow_schema_get_fields	(GArrowSchema *schema); GList *
* *	garrow_schema_to_string	(GArrowSchema *schema); gchar *
* * i	garrow_schema_to_string_metadata	(GArrowSchema *schema, gboolean show_metadata); gchar *
* * i * *	garrow_schema_add_field	(GArrowSchema *schema, guint i, GArrowField *field, GError **error); GArrowSchema *
* * i *	garrow_schema_remove_field	(GArrowSchema *schema,guint i, GError **error); GArrowSchema *
* * i * *	garrow_schema_replace_field	(GArrowSchema *schema,guint i, GArrowField *field, GError **error); GArrowSchema *
)


NB. =========================================================
NB. ArrowField
NB. https://arrow.apache.org/docs/c_glib/arrow-glib/GArrowField.html

fieldBindings =: lib 0 : 0
* * *	garrow_field_new	(const gchar *name, GArrowDataType *data_type); GArrowField *
* * * i	garrow_field_new_full	(const gchar *name, GArrowDataType *data_type, gboolean nullable); GArrowField *
* *	garrow_field_get_name	(GArrowField *field); const gchar *
* *	garrow_field_get_data_type	(GArrowField *field); GArrowDataType *
i *	garrow_field_is_nullable	(GArrowField *field); gboolean
i * *	garrow_field_equal	(GArrowField *field, GArrowField *other_field); gboolean
* *	garrow_field_to_string	(GArrowField *field); gchar *
* * i	garrow_field_to_string_metadata	(GArrowField *field, gboolean show_metadata); gchar *
i *	garrow_field_has_metadata	(GArrowField *field); gboolean
* *	garrow_field_get_metadata	(GArrowField *field); GHashTable *
* * *	garrow_field_with_metadata	(GArrowField *field, GHashTable *metadata); GArrowField *
* * *	garrow_field_with_merged_metadata	(GArrowField *field, GHashTable *metadata); GArrowField *
* *	garrow_field_remove_metadata	(GArrowField *field); GArrowField *
)