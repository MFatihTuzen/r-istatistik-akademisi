# ======================================================================
# R Programlamaya Giriş
# Konu: Verinin Yapısını Anlamak — str()
# Yazar: Dr. M. Fatih Tüzen
#
# Amaç:
# - Verinin yalnızca nasıl göründüğünü değil,
#   R tarafından nasıl algılandığını anlamak
# - str() fonksiyonunu doğru okumayı öğrenmek
# - Analiz öncesi yapı kontrolü refleksi kazanmak
#
# Not:
# - Bu script bir analiz scripti değildir.
# - Amaç: analizden ÖNCE yapılması gereken zorunlu kontrolleri göstermek.
# ======================================================================


# ----------------------------------------------------------------------
# 0) Örnek Veri: mtcars
# ----------------------------------------------------------------------
# R ile birlikte gelen klasik bir örnek veri seti.
# Veri analizi sürecinde çoğu zaman ilk adım:
# “Bu veri R tarafından nasıl görülüyor?”
data(mtcars)


# ----------------------------------------------------------------------
# 1) İlk Yapı Kontrolü: str()
# ----------------------------------------------------------------------
# str(), bir nesnenin yapısını kısa ve yoğun biçimde özetler.
# - Nesnenin sınıfı
# - Boyutu
# - Değişkenlerin veri tipleri
# - Örnek değerler
#
# Bu fonksiyonun amacı detay değil, çerçeve sunmaktır.
str(mtcars)


# ----------------------------------------------------------------------
# 2) str() Çıktısı Nasıl Okunur?
# ----------------------------------------------------------------------
# str() çıktısı şu sırayla okunmalıdır:
# 1) Nesnenin sınıfı (data.frame, tibble, list, vb.)
# 2) Gözlem ve değişken sayısı
# 3) Her değişken için:
#    - Veri tipi (num, int, chr, logi, factor)
#    - İlk birkaç örnek değer
#
# Bu okuma sırası alışkanlık hâline getirilmelidir.


# ----------------------------------------------------------------------
# 3) Sayısal Veri Tipleri: num ve int
# ----------------------------------------------------------------------
# R, sayısal verileri genellikle iki temel tipte tutar:
# - num : ondalıklı sayılar
# - int : tam sayılar
#
# Çoğu analizde fark yaratmaz gibi görünse de,
# bellek ve bazı fonksiyon davranışları açısından önemlidir.
#
# Örnek:
x_num <- c(1.5, 2.3, 3.7)
x_int <- as.integer(c(1, 2, 3))

str(x_num)
str(x_int)


# ----------------------------------------------------------------------
# 4) Karakter ve Mantıksal Tipler: chr ve logi
# ----------------------------------------------------------------------
# chr : karakter (metin)
# logi: mantıksal (TRUE / FALSE)
#
# Sayısal beklenen bir değişkenin chr olması,
# analizde sessiz ama ciddi hatalara yol açabilir.
x_chr <- c("10", "20", "30")
x_logi <- c(TRUE, FALSE, TRUE)

str(x_chr)
str(x_logi)


# ----------------------------------------------------------------------
# 5) factor: Kategorik Değişkenler
# ----------------------------------------------------------------------
# factor, kategorik değişkenleri temsil eder.
# Seviyeleri (levels) vardır ve modelleme açısından kritiktir.
x_factor <- factor(c("A", "B", "A", "C"))

str(x_factor)

# Faktör–karakter farkı:
# Aynı görünen veri, R açısından çok farklı davranır.
x_char <- c("A", "B", "A", "C")
str(x_char)


# ----------------------------------------------------------------------
# 6) Farklı Veri Yapıları: data.frame, tibble, matrix
# ----------------------------------------------------------------------
# Aynı veri farklı yapılarda tutulabilir.
# Bu yapı farkları, fonksiyon davranışlarını etkiler.
df <- data.frame(a = 1:3, b = c("x", "y", "z"))
mat <- matrix(1:6, nrow = 3)

str(df)
str(mat)

# Not:
# matrix tek tip veri tutar;
# data.frame sütun bazında farklı tipleri destekler.


# ----------------------------------------------------------------------
# 7) Tarih Değişkenleri ve str()
# ----------------------------------------------------------------------
# Tarih görünümlü her şey tarih değildir.
date_chr <- c("2025-01-01", "2025-01-02")
date_real <- as.Date(date_chr)

str(date_chr)
str(date_real)

# Tarih analizi yapmadan önce mutlaka str() ile kontrol edilmelidir.


# ----------------------------------------------------------------------
# 8) Listeler ve İç İçe Yapılar
# ----------------------------------------------------------------------
# Liste, R’ın en esnek veri yapısıdır.
# İçine farklı tipte nesneler koyabiliriz.
lst <- list(
  data = mtcars,
  mean_mpg = mean(mtcars$mpg),
  model = "örnek"
)

str(lst)

# Listelerle çalışırken str() neredeyse zorunludur.


# ----------------------------------------------------------------------
# 9) str() Ne Yapmaz?
# ----------------------------------------------------------------------
# str():
# - Ortalama vermez
# - Dağılım göstermez
# - Özet istatistik üretmez
#
# Bunun için summary() kullanılır.
summary(mtcars)


# ----------------------------------------------------------------------
# 10) Mini Yapı Kontrol Checklist
# ----------------------------------------------------------------------
# Veri geldiğinde otomatik refleks:
# 1) head() / tail()
# 2) str()
# 3) summary()
#
# str() atlanırsa:
# - Yanlış veri tipiyle analiz yapılabilir
# - Hatalar geç fark edilir
#
# Unutma:
# Yapısı bilinmeyen veriyle yapılan analiz,
# temeli bilinmeyen bina gibidir.
# ======================================================================
