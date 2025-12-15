###############################################################
# R Programlamaya Giriş – Fonksiyonlar
# Bu script "Fonksiyonlar" dersi için hazırlanmıştır.
# İçerik: Fonksiyonların mantığı, sözdizimi, argümanlar, ellipsis,
# ortam (environment), iyi uygulamalar ve küçük örnekler.
###############################################################


###############################################################
# 1) Fonksiyonlara Giriş
###############################################################

# Fonksiyonlar tekrar eden işleri kolaylaştırır.
# Kodun daha okunabilir, düzenli ve bakımı kolay olmasını sağlar.
# Matematikte fonksiyon: girdi → işlem → çıktı
# Programlamada da aynı felsefe geçerlidir.


###############################################################
# 2) Fonksiyonların Temel Yapısı
###############################################################

# Genel sözdizimi:
# isim <- function(arg1, arg2, ...) {
#   # işlemler
#   return(sonuc)   # return() opsiyoneldir
# }

# Basit bir toplama fonksiyonu
toplama <- function(x, y) {
  x + y   # return yazmasak da son satır döndürülür
}

toplama(3, 5)   # Beklenen çıktı: 8


###############################################################
# 3) Argümanlar
###############################################################

# Varsayılan argümanlar sayesinde fonksiyon daha esnek olur.
selamla <- function(isim = "Misafir") {
  paste("Merhaba", isim)
}

selamla()            # "Merhaba Misafir"
selamla("Fatih")     # "Merhaba Fatih"
selamla(isim="Ayşe") # "Merhaba Ayşe"

# Not: Argüman isimleri kullanıldığında sıralamanın önemi kalmaz.


###############################################################
# 4) Ellipsis (...) – Basit Kullanım
###############################################################

# Çok sayıda argümanı kabul etmek için kullanılır.
topla_hepsi <- function(...) {
  sayilar <- c(...)
  sum(sayilar)
}

topla_hepsi(1, 2, 3, 4, 5)   # Beklenen çıktı: 15

# Ellipsis ayrıca başka fonksiyonlara argüman aktarmada kullanılır.
ozel_cizim <- function(x, y, ...) {
  plot(x, y, type = "l", ...)  # ... parametreleri plot'a iletilir
}

x <- 1:5
y <- x^2
ozel_cizim(x, y, col = "blue", lwd = 3, main = "Özel Çizim")


###############################################################
# 5) Ortam (Environment)
###############################################################

# Fonksiyon içinde tanımlanan değişkenler yereldir.
deneme <- function() {
  z <- 10
  z^2
}
deneme()  # 100
# z   # Hata: 'z' global ortamda tanımlı değil

# Global ortamda değişken tanımlamak için <<- kullanılır (önerilmez).
global_ornek <- function() {
  y <<- 42
}
global_ornek()
y   # 42


###############################################################
# 6) İyi Uygulamalar
###############################################################

# - Fonksiyon tek bir iş yapmalı
# - İsimlendirme açık ve anlamlı olmalı
# - Girdi doğrulama yapılmalı
# - Yan etkilerden mümkünse kaçınılmalı

istatistik <- function(x) {
  stopifnot(is.numeric(x))   # sadece sayısal vektör kabul edilir
  list(ortalama = mean(x), varyans = var(x))
}

istatistik(c(1, 2, 3, 4, 5))
# $ortalama = 3
# $varyans = 2.5


###############################################################
# 7) Fonksiyonları İncelemek
###############################################################

# Yerleşik fonksiyonları incelemek için kullanışlı araçlar:
args(mean)      # Argümanları listeler
formals(mean)   # Varsayılan değerleri gösterir
body(mean)      # Fonksiyonun gövdesini gösterir

# Hata sonrası traceback:
hata_fonksiyonu <- function() {
  stop("Bilinçli hata!")   # Hata üretir
}
# hata_fonksiyonu()
# traceback()   # Hata sonrası çalıştırıldığında çağrı zincirini gösterir


###############################################################
# 8) Küçük Uygulama Örnekleri
###############################################################

# (1) Ortalama ve varyans döndüren fonksiyon
istatistik2 <- function(x, na.rm = FALSE) {
  if (na.rm) x <- x[!is.na(x)]
  list(ortalama = mean(x), varyans = var(x))
}
istatistik2(c(1, 2, NA, 4, 5), na.rm = TRUE)

# (2) Bir metnin ilk harfini büyüten fonksiyon
ilk_harf_buyuk <- function(metin) {
  stopifnot(is.character(metin), length(metin) == 1)
  paste0(toupper(substr(metin, 1, 1)), substr(metin, 2, nchar(metin)))
}
ilk_harf_buyuk("fatih")   # "Fatih"

# (3) Kompozit fonksiyon: toplama + küp alma
kupu_al_ve_topla <- function(x, y) {
  toplam <- toplama(x, y)   # daha önce tanımladığımız toplama() fonksiyonunu çağırır
  toplam^3
}
kupu_al_ve_topla(2, 3)   # (2+3)^3 = 125


###############################################################
# 9) Kapanış
###############################################################

# Fonksiyonlar R programlamanın temel taşlarıdır.
# Öğrendiklerimiz:
# - Sözdizimi
# - Argümanlar
# - Ellipsis (...) temel kullanımı
# - Ortamlar ve global atama
# - İyi uygulamalar
# - Fonksiyon inceleme araçları
# - Küçük uygulamalar

###############################################################
