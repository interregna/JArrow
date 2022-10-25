NB. =========================================================
NB. Error
NB. https://arrow.apache.org/docs/c_glib/arrow-glib/arrow-glib-GArrowError.html
NB. =========================================================
errorBindings =: lib 0 : 0
b * & *	garrow_error_check	(GError **error, const arrow::Status &status, const char *context); boolean
* &	garrow_error_from_status	(const arrow::Status &status); GArrowError
* * *	garrow_error_to_status_code	(GError *error, arrow::StatusCode default_code); arrow::StatusCode
* * *	garrow_error_to_status	(GError *error, arrow::StatusCode default_code, const char *context); arrow::Status
)