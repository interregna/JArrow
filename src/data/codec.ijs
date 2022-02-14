NB. =========================================================
NB. Codec
NB. https://arrow.apache.org/docs/c_glib/arrow-glib/GArrowCodec.html
NB. =========================================================
codecBindings =: lib 0 : 0
ADD TYPES
garrow_codec_finalize(GObject *object); static void
garrow_codec_set_property(GObject *object, guint prop_id, const GValue *value, GParamSpec *pspec); static void
garrow_codec_get_property(GObject *object, guint prop_id, GValue *value, GParamSpec *pspec); static void
garrow_codec_init(GArrowCodec *object); static void
garrow_codec_class_init(GArrowCodecClass *klass); static void
garrow_codec_new(GArrowCompressionType type, GError **error); GArrowCodec *
garrow_codec_get_name(GArrowCodec *codec); const gchar *
garrow_codec_get_compression_type(GArrowCodec *codec); GArrowCompressionType
garrow_codec_get_compression_level(GArrowCodec *codec); gint
garrow_compression_type_from_raw(arrow::Compression::type arrow_type); ArrowCompressionType
garrow_compression_type_to_raw(GArrowCompressionType type)}; arrow::Compression::type
garrow_codec_new_raw(std::shared_ptr<arrow::util::Codec> *arrow_codec); GArrowCodec *
garrow_codec_get_raw(GArrowCodec *codec); std::shared_ptr<arrow::util::Codec>
)