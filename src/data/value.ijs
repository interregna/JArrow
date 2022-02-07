NB. =========================================================
NB. Decimal
NB. https://arrow.apache.org/docs/c_glib/arrow-glib/decimal.html
NB. =========================================================

decimalBindings =: lib 0 : 0
ADD TYPES
garrow_decimal_new_string(const gchar *data); garrowType *
garrow_decimal_new_integer(const gint64 data); garrowType *
garrow_decimal_copy(typename DecimalConverter<Decimal>, garrowType *decimal); garrowType *
garrow_decimal_equal(typename DecimalConverter<Decimal>, garrowType *decimal, typename DecimalConverter<Decimal>:, garrowType *other_decimal); gboolean
garrow_decimal_not_equal(typename DecimalConverter<Decimal>:,garrowType *decimal, typename DecimalConverter<Decimal>:,garrowType *other_decimal); gboolean
garrow_decimal_less_than(typename DecimalConverter<Decimal>:,garrowType *decimal, typename DecimalConverter<Decimal>:,garrowType *other_decimal); gboolean
garrow_decimal_less_than_or_equal(typename DecimalConverter<Decimal>:,garrowType *decimal , typename DecimalConverter<Decimal>:,garrowType *other_decimal); gboolean
garrow_decimal_greater_than(typename DecimalConverter<Decimal>:,garrowType *decimal, typename DecimalConverter<Decimal>:,garrowType *other_decimal); gboolean
garrow_decimal_greater_than_or_equal(typename DecimalConverter<Decimal>:,garrowType *decimal, typename DecimalConverter<Decimal>:,garrowType *other_decimal); gboolean
garrow_decimal_to_string_scale(typename DecimalConverter<Decimal>:,garrowType *decimal, gint32 scale); gchar *
garrow_decimal_to_string(typename DecimalConverter<Decimal>:,garrowType *decimal); gchar *
garrow_decimal_to_bytes(typename DecimalConverter<Decimal>:,garrowType *decimal); GBytes *
garrow_decimal_abs(typename DecimalConverter<Decimal>:,garrowType *decimal); void
garrow_decimal_negate(typename DecimalConverter<Decimal>:,garrowType *decimal); void
garrow_decimal_plus(typename DecimalConverter<Decimal>:,garrowType *left, typename DecimalConverter<Decimal>:; garrowType *
garrow_decimal_minus(typename DecimalConverter<Decimal>:,garrowType *left, typename DecimalConverter<Decimal>:; garrowType *
garrow_decimal_multiply(typename DecimalConverter<Decimal>:,garrowType *left, typename DecimalConverter<Decimal>:; garrowType *
garrow_decimal_divide(typename DecimalConverter<Decimal>:,garrowType *left, typename DecimalConverter<Decimal>:; garrowType *
garrow_decimal_rescale(typename DecimalConverter<Decimal>:,garrowType *decimal, gint32 original_scale, gint32 new_scale, GError **error, const gchar *tag); garrowType *
garrow_decimal128_finalize(GObject *object); static void
garrow_decimal128_set_property(GObject *object, guint prop_id, const GValue *value, GParamSpec *pspec); static void
garrow_decimal128_init(GArrowDecimal128 *object); static void
garrow_decimal128_class_init(GArrowDecimal128Class *klass); static void
garrow_decimal128_new_string(const gchar *data); GArrowDecimal128 *
garrow_decimal128_new_integer(const gint64 data); GArrowDecimal128 *
garrow_decimal128_copy(GArrowDecimal128 *decimal); GArrowDecimal128 *
garrow_decimal128_equal(GArrowDecimal128 *decimal, GArrowDecimal128 *other_decimal); gboolean
garrow_decimal128_not_equal(GArrowDecimal128 *decimal, GArrowDecimal128 *other_decimal); gboolean
garrow_decimal128_less_than(GArrowDecimal128 *decimal, GArrowDecimal128 *other_decimal); gboolean
garrow_decimal128_less_than_or_equal(GArrowDecimal128 *decimal, GArrowDecimal128 *other_decimal); gboolean
garrow_decimal128_greater_than(GArrowDecimal128 *decimal, GArrowDecimal128 *other_decimal); gboolean
garrow_decimal128_greater_than_or_equal(GArrowDecimal128 *decimal, GArrowDecimal128 *other_decimal); gboolean
garrow_decimal128_to_string_scale(GArrowDecimal128 *decimal, gint32 scale); gchar *
garrow_decimal128_to_string(GArrowDecimal128 *decimal); gchar *
garrow_decimal128_to_bytes(GArrowDecimal128 *decimal); GBytes *
garrow_decimal128_abs(GArrowDecimal128 *decimal); void
garrow_decimal128_negate(GArrowDecimal128 *decimal); void
garrow_decimal128_to_integer(GArrowDecimal128 *decimal); gint64
garrow_decimal128_plus(GArrowDecimal128 *left, GArrowDecimal128 *right); GArrowDecimal128 *
garrow_decimal128_minus(GArrowDecimal128 *left, GArrowDecimal128 *right); GArrowDecimal128 *
garrow_decimal128_multiply(GArrowDecimal128 *left, GArrowDecimal128 *right); GArrowDecimal128 *
garrow_decimal128_divide(GArrowDecimal128 *left, GArrowDecimal128 *right, GArrowDecimal128 **remainder, GError **error); GArrowDecimal128 *
garrow_decimal128_rescale(GArrowDecimal128 *decimal, gint32 original_scale, gint32 new_scale, GError **error); GArrowDecimal128 *
garrow_decimal256_finalize(GObject *object); static void
garrow_decimal256_set_property(GObject *object, guint prop_id, const GValue *value, GParamSpec *pspec); static void
garrow_decimal256_init(GArrowDecimal256 *object); static void
garrow_decimal256_class_init(GArrowDecimal256Class *klass); static void
garrow_decimal256_new_string(const gchar *data); GArrowDecimal256 *
garrow_decimal256_new_integer(const gint64 data); GArrowDecimal256 *
garrow_decimal256_copy(GArrowDecimal256 *decimal); GArrowDecimal256 *
garrow_decimal256_equal(GArrowDecimal256 *decimal, GArrowDecimal256 *other_decimal); gboolean
garrow_decimal256_not_equal(GArrowDecimal256 *decimal, GArrowDecimal256 *other_decimal); gboolean
garrow_decimal256_less_than(GArrowDecimal256 *decimal, GArrowDecimal256 *other_decimal); gboolean
garrow_decimal256_less_than_or_equal(GArrowDecimal256 *decimal, GArrowDecimal256 *other_decimal); gboolean
garrow_decimal256_greater_than(GArrowDecimal256 *decimal, GArrowDecimal256 *other_decimal); gboolean
garrow_decimal256_greater_than_or_equal(GArrowDecimal256 *decimal, GArrowDecimal256 *other_decimal); gboolean
garrow_decimal256_to_string_scale(GArrowDecimal256 *decimal, gint32 scale); gchar *
garrow_decimal256_to_string(GArrowDecimal256 *decimal); gchar *
garrow_decimal256_to_bytes(GArrowDecimal256 *decimal); GBytes *
garrow_decimal256_abs(GArrowDecimal256 *decimal); void
garrow_decimal256_negate(GArrowDecimal256 *decimal); void
garrow_decimal256_plus(GArrowDecimal256 *left, GArrowDecimal256 *right); GArrowDecimal256 *
garrow_decimal256_multiply(GArrowDecimal256 *left, GArrowDecimal256 *right); GArrowDecimal256 *
garrow_decimal256_divide(GArrowDecimal256 *left, GArrowDecimal256 *right, GArrowDecimal256 **remainder, GError **error); GArrowDecimal256 *
garrow_decimal256_rescale(GArrowDecimal256 *decimal, gint32 original_scale, gint32 new_scale, GError **error); GArrowDecimal256 *
garrow_decimal128_new_raw(std::shared_ptr<arrow::Decimal128> *arrow_decimal128); ArrowDecimal128 *
garrow_decimal128_get_raw(GArrowDecimal128 *decimal128); std::shared_ptr<arrow::Decimal128>
garrow_decimal256_new_raw(std::shared_ptr<arrow::Decimal256> *arrow_decimal256); GArrowDecimal256 *
garrow_decimal256_get_raw(GArrowDecimal256 *decimal256); std::shared_ptr<arrow::Decimal256>
)