############################################################
# R PROGRAMLAMAYA GİRİŞ — LİSTELER (Script)
############################################################


# ==========================================================
# 1) GİRİŞ: LİSTELER NEDİR?
# ----------------------------------------------------------
# - Listeler heterojen veri tutar: numeric, character, logical,
#   vektör, matris, data.frame ya da başka bir liste aynı anda.
# - Vektörler homojen, listeler heterojen.
# - R'de birçok fonksiyon çıktısı "liste"dir (özellikle model nesneleri).
# ==========================================================



# ==========================================================
# 2) LİSTE OLUŞTURMA — list()
# ----------------------------------------------------------
# Temel sözdizimi: list(...), opsiyonel olarak isimli elemanlar da verebilirsin.
# ----------------------------------------------------------

ogrenci <- list(
  isim     = "Ayşe",
  yas      = 21,
  notlar   = c(85, 90, 78),
  mezun    = FALSE,
  adres    = list(il = "Ankara", ilce = "Çankaya") # iç içe liste
)
ogrenci
# Beklenen (özet): list of 5: $isim (chr), $yas (num), $notlar (num[1:3]), $mezun (lgl), $adres (list)

# İsimli/ismi olmayan karışık oluşturma (genelde önerilmez, okunabilirliği düşürür):
karisik <- list(1:3, "abc", TRUE, m = matrix(1:4, 2, 2))
names(karisik) # isim atanmayanlar için NULL
# -> "m" dışında isim yok.



# ==========================================================
# 3) ERİŞİM YÖNTEMLERİ — [], [[]], $
# ----------------------------------------------------------
# - []  : ALT LİSTE döndürür (tür: list)
# - [[]]: DOĞRUDAN ELEMAN döndürür (tür: elemanın kendi türü)
# - $   : İSİMLE ERİŞİM (kısayol), kısmi eşleşme riskine dikkat!
# ----------------------------------------------------------

# [] alt liste
ogrenci["isim"]             # list döner
str(ogrenci["isim"])        # List of 1

# [[]] doğrudan eleman
ogrenci[["isim"]]           # "Ayşe"
str(ogrenci[["isim"]])      # chr [1] "Ayşe"

# $ isimle erişim
ogrenci$yas                 # 21

# İç içe erişim
ogrenci$adres$il            # "Ankara"
ogrenci[["adres"]][["ilce"]]# "Çankaya"


# ==========================================================
# 4) GÜNCELLEME / EKLEME / SİLME
# ----------------------------------------------------------
# - Mevcut eleman değerini değiştir, yeni anahtar ekle, silmek için NULL ata.
# ----------------------------------------------------------

# Güncelle
ogrenci$yas <- 22

# Yeni eleman ekle
ogrenci$universite <- "ODTÜ"

# Sil (NULL ataması)
ogrenci$mezun <- NULL

# Son durum
str(ogrenci)
# $ isim       : chr "Ayşe"
# $ yas        : num 22
# $ notlar     : num [1:3] 85 90 78
# $ adres      :List of 2
# $ universite : chr "ODTÜ"



# ==========================================================
# 5) LİSTE-ÖZEL YARARLI FONKSİYONLAR
# ----------------------------------------------------------
# length(x): eleman sayısı
# names(x) : isimleri getir/ata
# str(x)   : yapıyı hızlı incele (büyük listelerde hayat kurtarır)
# unlist(x): listeyi vektöre düzle (TÜR dönüşümüne dikkat!)
# ----------------------------------------------------------

length(ogrenci)      # 5
names(ogrenci)       # "isim" "yas" "notlar" "adres" "universite"
names(ogrenci)[1] <- "ad"   # isim güncelle
str(ogrenci)

# unlist: her şey vektöre zorlanır; iç içe/heterojen yapılarda tehlikeli olabilir
unlist(ogrenci[1:2])
# $ad = "Ayşe", $yas = "22"  (dikkat: "22" karaktere zorlanabilir)



# ==========================================================
# 6) İÇ İÇE LİSTELER
# ----------------------------------------------------------
# - Derinlik arttıkça erişim zinciri uzar (a$b$c gibi).
# - Büyük yapılarda str(), length(), names() ile yolunu bul.
# ----------------------------------------------------------

sinif <- list(
  ogr1 = ogrenci,
  ogr2 = list(ad = "Mehmet", yas = 23, notlar = c(70, 82)),
  ogr3 = list(ad = "Zeynep", yas = 21, notlar = c(90, 95, 93))
)

# Örnek erişimler:
sinif$ogr2$notlar
mean(sinif$ogr3$notlar)

# Tüm öğrencilerin yaşlarını çekmek (manuel):
c(sinif$ogr1$yas, sinif$ogr2$yas, sinif$ogr3$yas)



# ==========================================================
# 7) İPUÇLARI — lapply() ve sapply()
# ----------------------------------------------------------
# lapply(X, FUN, ...) → her elemana FUN uygular, daima LİSTE döndürür.
# sapply(X, FUN, ...) → mümkün olduğunca basitleştirir (vektör/matris), aksi halde liste.
# ----------------------------------------------------------

sayilar <- list(a = 1:5, b = 6:10, c = c(10, 20, 30, 40))

# Her listenin ortalaması:
l_means <- lapply(sayilar, mean) # liste
s_means <- sapply(sayilar, mean) # vektör

l_means
# $a 3; $b 8; $c 25 (liste)
s_means
#   a   b   c 
#   3   8  25

# Ek örnek — anonim fonksiyon ve ... kullanımı:
# (NA'ları yoksayarak standart sapma)
set.seed(42)
sayilar2 <- list(
  x = c(1, 2, 3, NA),
  y = c(10, 12, NA, 14),
  z = rnorm(5)
)

lapply(sayilar2, function(v) sd(v, na.rm = TRUE))
sapply(sayilar2, sd, na.rm = TRUE)

# Listeye aynı anda birden fazla fonksiyon uygulamak (öz/örnek yaklaşım):
# Sonuç: her eleman için mean/sd içeren alt-listeler
lapply(sayilar2, function(v) list(mean = mean(v, na.rm = TRUE),
                                  sd   = sd(v, na.rm = TRUE)))

# sapply'nin matris döndürmesi (örnek: range)
sapply(sayilar2, range, na.rm = TRUE)
#       x   y          z
# min   1  10  (yaklaşık)
# max   3  14  (yaklaşık)

# Dikkat: sapply bazen beklenmedik yapı üretirse simplify=FALSE kullan:
sapply(sayilar2, quantile, probs = c(0.25, 0.5, 0.75), na.rm = TRUE, simplify = FALSE)



# ==========================================================
# 8) FONKSİYON ÇIKTILARI — lm() BİR LİSTEDİR
# ----------------------------------------------------------
# - class(model) → "lm"
# - str(model)   → list içeriğini gösterir (coefficients, residuals, fitted.values, etc.)
# - model$coefficients gibi alanlara doğrudan erişilebilir.
# ----------------------------------------------------------

veri <- data.frame(x = 1:5, y = c(2, 4, 6, 8, 10))
model <- lm(y ~ x, data = veri)

class(model)  # "lm"
str(model)    # Yapıyı incele (uzun çıkabilir)

# Örnek parça erişimleri:
model$coefficients     # (Intercept) ve x katsayısı
model$residuals        # artıklar
model$fitted.values    # tahminler
model$call             # çağrı bilgisi

# Kullanışlı özet, yine LİSTE döndürür:
ozet <- summary(model)
class(ozet)            # "summary.lm"
str(ozet)              # coefficients tablosu, R^2 vb.

# R-kare, katsayı tablosu gibi özetler:
ozet$r.squared
ozet$coefficients
#               Estimate Std. Error t value Pr(>|t|)
# (Intercept) ~ 0        ...
# x           ~ 2        ...

# ==========================================================
# 9) EN İYİ PRATİKLER ve KISA NOTLAR
# ----------------------------------------------------------
# - İsimli listelerle çalış; okunabilirlik ve bakım kolaylığı sağlar.
# - Büyük listelerde str(x, max.level = 2) gibi kısaltılmış inceleme kullan.
# - sapply beklenmedik yapı verdiğinde simplify=FALSE ya da vapply tercih et.
# - unlist dönüşümlerine dikkat et (tip zorlaması).
# - $ ile erişimde kısmi eşleşme tuzaklarına karşı uyanık ol:
# - Model nesneleri listelerdir: parça-parça erişilebilir; summary() da liste döndürür.
# ----------------------------------------------------------


