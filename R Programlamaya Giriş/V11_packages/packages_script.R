############################################################
# R Programlama ve İstatistik Akademisi
# V11 — R’de Paket Kavramı ve Paket Kullanımı
# Amaç: Paket nedir? Base R vs paketler, CRAN, kurulum (install)
#       ve kullanım (library) mantığını örneklerle göstermek.
#
# Not: Bu script eğitim amaçlıdır. Kod + yorum birlikte okunmalıdır.
############################################################


############################################################
# 0) Hızlı Özet: Kurulum ≠ Kullanım
#
# - install.packages("paket")  -> Paketi bilgisayara KURAR (genellikle bir kez)
# - library(paket)             -> Paketi oturuma YÜKLER (her oturumda gerekebilir)
# - paket::fonksiyon()         -> Paketi yüklemeden fonksiyon çağırır (kaynagi net)
############################################################


############################################################
# 1) Base R Fonksiyonları: Ekstra Paket Gerekmez
############################################################

# Base R'den örnekler:
x <- c(1, 2, 3, 4, 5)

mean(x)    # Ortalama
sum(x)     # Toplam
length(x)  # Eleman sayısı
seq(1, 10) # 1'den 10'a ardışık
rep(1, 5)  # 1'i 5 kez tekrar et

# Yorum:
# Bu fonksiyonlar R kurulumuyla birlikte gelir.
# Bu yüzden "library()" ile çağırmanıza gerek yoktur.


############################################################
# 2) "Bu fonksiyon nereden geliyor?" refleksi
############################################################

# find(): Bir ismin arama yolunda (search path) nerede bulunduğunu söyler.
find("mean")
find("lm")

# Not:
# find() çıktısında "package:stats" gibi ifadeler görürsünüz.
# Bu, fonksiyonun hangi paket/namespace içinde bulunduğunu gösterir.
# Base R ile gelen paketlerin bir kısmı (stats gibi) kurulumla zaten hazır gelir.

# Bir fonksiyonun yardım sayfasına bakmak:
?mean
# Alternatif:
help("mean")


############################################################
# 3) CRAN hakkında pratik: (Script içinde link bırakmak iyi alışkanlık)
############################################################

# CRAN ana sayfa:
# https://cran.r-project.org
#
# Paket listesi:
# https://cran.r-project.org/web/packages/
#
# Örnek paket sayfası (ggplot2):
# https://cran.r-project.org/package=ggplot2
#
# Not:
# Bu linkler, "paket nereden geliyor / resmi kaynak nedir" sorusuna cevap verir.


############################################################
# 4) Paket Kurulumu: install.packages()
############################################################

# ÖNEMLİ:
# Bu satırı her çalıştırmada çalıştırmak doğru değildir.
# Paket bilgisayarda kurulu değilse bir kez çalıştırılır.

# install.packages("ggplot2")  # Örnek: ggplot2 kurulumu
# install.packages("readxl")   # Örnek: Excel okumak için
# install.packages("dplyr")    # Örnek: Veri manipülasyonu

# Birden fazla paket kurmak:
# install.packages(c("ggplot2", "dplyr", "readxl"))

# Yaygın hata:
# install.packages(ggplot2)    # HATALI -> paket adı tırnak içinde olmalı

# Yorum:
# install.packages() internet bağlantısı gerektirir ve paketi R'nin library dizinine kurar.
# Kurulum kalıcıdır; R kapansa bile paket sistemde kalır.


############################################################
# 5) Paket Kullanımı: library()
############################################################

# Kurulu bir paketi aktif oturuma yüklemek:
# library(ggplot2)
# library(readxl)
# library(dplyr)

# Yaygın hata:
# library("ggplot2")  # ÇALIŞIR ama eğitimde paket adını tırnaksız yazmak daha nettir.
# Tercih: library(ggplot2)

# Yorum:
# library() oturum (session) bazlıdır.
# R'yi kapatıp açarsanız, paketi yeniden library() ile çağırmanız gerekir.


############################################################
# 6) Paket::Fonksiyon Kullanımı (Namespace Operatörü ::)
############################################################

# Bazı durumlarda paketi tamamen yüklemek yerine,
# doğrudan fonksiyonu paket adıyla çağırmak daha temiz olabilir.

# Örnekler:
# ggplot2::ggplot()
# readxl::read_excel("dosya.xlsx")
# dplyr::mutate(mtcars, hp2 = hp * 2)

# Yorum:
# paket::fonksiyon biçimi şu avantajları sağlar:
# - Fonksiyonun kaynağı nettir (hangi paketten geldiği belli olur)
# - library() çağırmadan kullanılabilir
# - İsim çakışmalarını azaltır


############################################################
# 7) İsim Çakışması (Conflict / Masking) Fikrine Giriş
############################################################

# Aynı isimli fonksiyonlar farklı paketlerde bulunabilir.
# Klasik örnek: filter()

# Bu isimler fonksiyonların kendisidir (çağırmıyoruz, referans veriyoruz).
stats::filter
# dplyr::filter  # dplyr yüklü değilse burada hata görürsünüz.

# Yorum:
# Buradaki amaç şu farkındalık:
# "Ben filter() yazdım ama hangi filter() çalıştı?"
# İşte paket::fonksiyon yazımı bu soruyu netleştirir.


############################################################
# 8) Minimal “Kur - Çağır - Kullan” Senaryosu
############################################################

# 1) Kurulum (bir kez) - yorum satırında bırakalım:
# install.packages("stringr")

# 2) Kullanım (oturumda):
# library(stringr)

# 3) Kullanım örneği:
# stringr::str_detect("R programlama", "R")

# Alternatif: Paketi yükleyip direkt fonksiyon adıyla kullanmak:
# library(stringr)
# str_detect("R programlama", "R")

# Yorum:
# Eğitimde iki yaklaşımı da göstermek faydalı:
# - library() ile oturum temelli kullanım
# - paket::fonksiyon ile kaynak belirtilerek kullanım


############################################################
# 9) Sürüm (Version) Notu: Neden Önemli?
############################################################

# Paketler zaman içinde güncellenir.
# Aynı kodun farklı bilgisayarda farklı davranmasının nedenlerinden biri sürüm farkıdır.

# Yüklü paketlerin sürümünü görmek:
# packageVersion("ggplot2")

# Kurulu paketleri listelemek:
# installed.packages()[, c("Package", "Version")]

# Yorum:
# Bu konuyu burada derinleştirmiyoruz.
# Ama "sürüm farkı" kavramını bilmek, özellikle akademik/kurumsal işlerde kritiktir.


############################################################
# 10) Kapanış: Bu videodan sonra hedeflenen refleks
############################################################

# 1) Fonksiyon çalışmadı mı?
#    - Paket kurulu mu? (install)
#    - Paket çağrıldı mı? (library)
#    - Fonksiyon nereden geliyor? (paket::fonksiyon veya find())

# 2) Kod paylaşırken:
#    - Hangi paketler gerekiyor?
#    - Gerekirse paket sürümü önemli mi?

