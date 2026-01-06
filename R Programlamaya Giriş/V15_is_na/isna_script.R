# ======================================================================
# R Programlamaya Giriş
# Konu: Eksik Değer Kavramı — is.na()
# Yazar: Dr. M. Fatih Tüzen
#
# Amaç:
# - NA kavramını doğru anlamak (0 / "" / yanlış ölçüm değildir)
# - is.na() ile eksik değerleri tespit etmek
# - Eksik değerleri saymak, seçmek/dışlamak (subsetting)
# - NA, NULL, NaN, Inf ayrımını yapmak
# - na.rm argümanının ne yaptığını ve risklerini kavramak
#
# Not:
# - Bu script “uygulamalı”dır. Kodları sırayla çalıştırarak ilerleyebilirsin.
# - Büyük veri setlerinde is.na() çıktısı çok büyüyebilir; özetleme tercih edilir.
# ======================================================================


# ----------------------------------------------------------------------
# 0) Eksik Değer Nedir? (NA)
# ----------------------------------------------------------------------
# NA (Not Available / Not Applicable):
# - Bilginin mevcut olmadığını veya bu gözlem için geçerli olmadığını ifade eder.
# - 0 değildir.
# - "" (boş string) değildir.
# - Yanlış ölçüm değildir (yanlış ölçüm = hatalı ama "bir değer"dir).
#
# Eksik değer, analizi "sessizce" bozabileceği için erken aşamada kontrol edilmelidir.
NA


# ----------------------------------------------------------------------
# 1) Tipli NA Kavramı
# ----------------------------------------------------------------------
# R, NA'yı veri tipine göre de temsil edebilir.
# Bu, özellikle tür dönüşümlerinde (coercion) önem kazanır.
na_int  <- NA_integer_
na_real <- NA_real_
na_chr  <- NA_character_
na_logi <- NA_logical_

str(na_int)
str(na_real)
str(na_chr)
str(na_logi)

# İpucu:
# Tipli NA'lar, bir sütunun veri tipini "korumak" için yararlıdır.


# ----------------------------------------------------------------------
# 2) is.na() Nedir?
# ----------------------------------------------------------------------
# is.na(x): x içindeki NA değerlerini kontrol eder.
# - NA olanlar -> TRUE
# - NA olmayanlar -> FALSE
#
# Bu fonksiyon "kontrol" eder; düzeltmez / silmez.
x <- c(10, NA, 25, NA, 40)
is.na(x)

# Mantıksal çıktı (logical):
str(is.na(x))


# ----------------------------------------------------------------------
# 3) is.na() Çıktısını Okumak ve Saymak
# ----------------------------------------------------------------------
# TRUE/FALSE çıktısı bir "harita" gibidir: NA'lar nerede?
#
# NA saymak için en pratik yöntem:
sum(is.na(x))

# Mantık:
# TRUE -> 1, FALSE -> 0 olarak toplanır (R'da çoğu zaman bu şekilde davranır).

# Bir veri çerçevesinde (data.frame) sütun bazında NA sayımı:
df <- data.frame(
  a = c(1, NA, 3, 4),
  b = c(NA, 5, 6, NA),
  c = c(7, 8, 9, 10)
)

# Hücre bazında NA haritası (büyük tablolarda çok büyür):
is.na(df)

# Sütun bazında NA sayıları:
colSums(is.na(df))

# Tüm tablo içinde toplam NA sayısı:
sum(is.na(df))


# ----------------------------------------------------------------------
# 4) Subsetting: NA'ları Seçmek / Dışlamak
# ----------------------------------------------------------------------
# is.na() çıktısını indeks olarak kullanabilirsin.
#
# 4.1) Sadece NA olan değerler:
x[is.na(x)]

# 4.2) NA olmayan değerler:
x[!is.na(x)]

# 4.3) Data frame'de NA içeren satırları seçmek:
# Örn: a sütununda NA olan satırlar
df[is.na(df$a), ]

# 4.4) a sütununda NA olmayan satırlar:
df[!is.na(df$a), ]

# 4.5) Birden fazla sütunda NA kontrolü:
# Örn: a veya b sütununda NA olan satırlar
df[is.na(df$a) | is.na(df$b), ]

# Örn: Hem a hem b NA ise
df[is.na(df$a) & is.na(df$b), ]


# ----------------------------------------------------------------------
# 5) NA, NULL, NaN, Inf: Aynı Şey Değil
# ----------------------------------------------------------------------
# 5.1) NA vs NULL
# NA: eksik değer (var olan bir vektörün içinde eksik bir eleman)
# NULL: nesnenin yokluğu (uzunluk 0)
length(NA)
length(NULL)

is.na(NA)      # TRUE
is.null(NA)    # FALSE

is.na(NULL)    # logical(0) -> NULL'un elemanı yok
is.null(NULL)  # TRUE

# 5.2) NaN (Not a Number)
# Tanımsız işlemler sonucu oluşur.
nan_val <- 0/0
nan_val
is.nan(nan_val)   # TRUE
is.na(nan_val)    # TRUE  (NaN, NA türlerinden biridir)

# 5.3) Inf (Sonsuzluk)
inf_val <- 1/0
inf_val
is.infinite(inf_val)  # TRUE
is.na(inf_val)        # FALSE (Inf eksik değer değildir)


# ----------------------------------------------------------------------
# 6) NA Fonksiyonları Nasıl Etkiler? (na.rm)
# ----------------------------------------------------------------------
# Birçok özet fonksiyon NA varsa sonucu NA döndürür.
mean(x)  # NA döner

# na.rm = TRUE -> NA'ları hesaplama dışında bırak
mean(x, na.rm = TRUE)

# Aynı mantık birçok fonksiyonda geçerlidir:
sum(x)                 # NA
sum(x, na.rm = TRUE)   # NA'lar hariç toplam

# Kritik uyarı:
# na.rm = TRUE teknik bir çözümdür; analitik karar değildir.
# NA neden oluştu? Rastgele mi, sistematik mi? Analizi nasıl etkiler?
# Bu sorular atlanırsa, sonuç "temiz" görünür ama yanıltıcı olabilir.


# ----------------------------------------------------------------------
# 7) Sık Yapılan Hata: x == NA (YAPMA)
# ----------------------------------------------------------------------
# Yeni başlayanların en sık yaptığı hata:
# x == NA
#
# Bu doğru bir NA kontrol yöntemi değildir.
# Doğru yöntem: is.na(x)
#
# Gösterim (çalıştırıp gör):
x == NA
is.na(x)


# ----------------------------------------------------------------------
# 8) Mini Refleks Checklist
# ----------------------------------------------------------------------
# Veri geldiğinde otomatikleşmesi gereken rutin:
#
# 1) NA var mı?
#    sum(is.na(df)) / colSums(is.na(df))
# 2) NA nerede yoğun?
#    colSums(is.na(df))
# 3) NA ile ne yapılacak?
#    - Filtrele (x[!is.na(x)])
#    - Sil (na.omit / complete.cases)  [sonraki ders]
#    - Doldur (imputasyon)             [ileri ders]
#
# Unutma:
# Eksik değerler bir "hata" değil; veri hakkında bilgidir.
# ======================================================================
