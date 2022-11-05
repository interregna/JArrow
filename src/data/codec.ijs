NB. =========================================================
NB. Codec
NB. https://arrow.apache.org/docs/c_glib/arrow-glib/GArrowCodec.html
NB. =========================================================
codecBindings =: lib 0 : 0
* i *	garrow_codec_new	(GArrowCompressionType type,GError **error); GArrowCodec *
* *	garrow_codec_get_name	(GArrowCodec *codec); const gchar *
i *	garrow_codec_get_compression_type	(GArrowCodec *codec); GArrowCompressionType
i *	garrow_codec_get_compression_level	(GArrowCodec *codec); gint
)