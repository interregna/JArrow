NB. =========================================================
NB. Commmon
NB. https://github.com/apache/arrow/blob/master/c_glib/arrow-flight-glib
NB. =========================================================

commonFlightBindings =: lib 0 : 0
* *	gaflight_descriptor_to_string	(GAFlightDescriptor *descriptor); gchar *
* *	gaflight_criteria_new	(GBytes *expression); GAFlightCriteria *
*	gaflight_criteria_get_type
* * *	gaflight_location_new	(const gchar *uri, GError **error); GAFlightLocation *
* *	gaflight_location_to_string	(GAFlightLocation *location); gchar *
* *	gaflight_location_get_scheme	(GAFlightLocation *location); gchar *
b * *	gaflight_location_equal	(GAFlightLocation *location, GAFlightLocation *other_location); gboolean
*	gaflight_location_get_type
b * *	gaflight_descriptor_equal	(GAFlightDescriptor *descriptor, GAFlightDescriptor *other_descriptor) gboolean
*	gaflight_descriptor_get_type
* * i	gaflight_path_descriptor_new	(const gchar **paths, gsize n_paths); GAFlightPathDescriptor *
* *	gaflight_path_descriptor_get_paths 	(GAFlightPathDescriptor *descriptor); gchar **
*	gaflight_path_descriptor_get_type
* *	gaflight_command_descriptor_new	(const gchar *command); GAFlightCommandDescriptor *
* *	gaflight_command_descriptor_get_command	(GAFlightCommandDescriptor *descriptor); gchar *
* *	gaflight_ticket_new	(GBytes *data); GAFlightTicket *
b * *	gaflight_ticket_equal	(GAFlightTicket *ticket, GAFlightTicket *other_ticket); gboolean
* 	gaflight_ticket_get_type	
* * *	gaflight_endpoint_new	(GAFlightTicket *ticket, GList *locations); GAFlightEndpoint *
b * *	gaflight_endpoint_equal	(GAFlightEndpoint *endpoint, GAFlightEndpoint *other_endpoint); gboolean
* *	gaflight_endpoint_get_locations	(GAFlightEndpoint *endpoint); GList *
*	gaflight_endpoint_get_type
* * * i i *	gaflight_info_new	(GArrowSchema *schema, GAFlightDescriptor *descriptor, GList *endpoints, gint64 total_records, gint64 total_bytes, GError **error); GAFlightInfo *
b * *	gaflight_info_equal	(GAFlightInfo *info, GAFlightInfo *other_info); gboolean
* * * *	gaflight_info_get_schema	(GAFlightInfo *info, GArrowReadOptions *options, GError **error); GArrowSchema *
* *	gaflight_info_get_descriptor	(GAFlightInfo *info); GAFlightDescriptor *
* *	gaflight_info_get_endpoints	(GAFlightInfo *info); GList *
i *	gaflight_info_get_total_records	(GAFlightInfo *info); gint64
i *	gaflight_info_get_total_bytes	(GAFlightInfo *info); gint64
*	gaflight_info_get_type
* *	gaflight_stream_chunk_get_data	(GAFlightStreamChunk *chunk); GArrowRecordBatch *
* *	gaflight_stream_chunk_get_metadata	(GAFlightStreamChunk *chunk); GArrowBuffer *
*	gaflight_stream_chunk_get_type
* * *	gaflight_record_batch_reader_read_next	(GAFlightRecordBatchReader *reader, GError **error); GAFlightStreamChunk *
* * *	gaflight_record_batch_reader_read_all	(GAFlightRecordBatchReader *reader, GError **error); GArrowTable *
)

NB. =========================================================
NB. Client
NB. https://github.com/apache/arrow/blob/master/c_glib/arrow-flight-glib
NB. =========================================================
clientFlightBindings =: lib 0 : 0
*	gaflight_call_options_new	(void); GAFlightCallOptions *
n * * *	gaflight_call_options_add_header	(GAFlightCallOptions *options, const gchar *name, const gchar *value); void
n *	gaflight_call_options_clear_headers	(GAFlightCallOptions *options); void
n * * *	gaflight_call_options_foreach_header	(GAFlightCallOptions *options, GAFlightHeaderFunc func, gpointer user_data); void
*	gaflight_call_options_get_type
*	gaflight_client_options_new	(void); GAFlightClientOptions *
*	gaflight_client_options_get_type
* * * *	gaflight_client_new	(GAFlightLocation *location, GAFlightClientOptions *options, GError **error); GAFlightClient *
* * * * *	gaflight_client_list_flights	(GAFlightClient *client, GAFlightCriteria *criteria, GAFlightCallOptions *options, GError **error); GList *
b * *	gaflight_client_close	(GAFlightClient *client, GError **error); gboolean
* * * * *	gaflight_client_get_flight_info	(GAFlightClient *client, GAFlightDescriptor *descriptor, GAFlightCallOptions *options, GError **error); GAFlightInfo *
* * * * *	gaflight_client_do_get	(GAFlightClient *client, GAFlightTicket *ticket, GAFlightCallOptions *options, GError **error); GAFlightStreamReader *
*	gaflight_client_get_type
*	gaflight_stream_reader_get_type
)


NB. =========================================================
NB. Server
NB. https://github.com/apache/arrow/blob/master/c_glib/arrow-flight-glib
NB. =========================================================
serverFlightBindings =: lib 0 : 0
* *	gaflight_record_batch_stream_new	(GArrowRecordBatchReader *reader); GAFlightRecordBatchStream *
* *	gaflight_server_options_new	(GAFlightLocation *location); GAFlightServerOptions *
b * * *	gaflight_server_listen	(GAFlightServer *server, GAFlightServerOptions *options, GError **error); gboolean 
i *	gaflight_server_get_port	(GAFlightServer *server); gint 
i * *	gaflight_server_shutdown	(GAFlightServer *server, GError **error); gboolean 
i * *	gaflight_server_wait	(GAFlightServer *server, GError **error); gboolean 
* * * * *	gaflight_server_list_flights	(GAFlightServer *server, GAFlightServerCallContext *context, GAFlightCriteria *criteria, GError **error); GList *
* * * * *	gaflight_server_get_flight_info	(GAFlightServer *server, GAFlightServerCallContext *context, GAFlightDescriptor *request, GError **error); GAFlightInfo *
* * * * *	gaflight_server_do_get	(GAFlightServer *server, GAFlightServerCallContext *context, GAFlightTicket *ticket, GError **error); GAFlightDataStream *
)
