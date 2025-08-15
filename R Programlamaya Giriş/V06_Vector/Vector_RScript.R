
# Veri tipi vs veri yapısı örnekleri ----

# Veri tipi
typeof(42)        # "double"
typeof("Merhaba") # "character"

# Veri yapısı örnekleri
vec <- c(1, 2, 3)
mat <- matrix(1:6, nrow = 2, ncol = 3)
arr <- array(1:12, dim = c(2, 3, 2))
df <- data.frame(id = 1:3, isim = c("Ali", "Ayşe", "Mehmet"))
lst <- list(sayi = 1:3, kelime = "Merhaba", matris = mat)

# Yapı kontrolü
is.vector(vec)
is.matrix(mat)
is.data.frame(df)
is.list(lst)

# Vektör oluşturma yöntemleri

# 1. c() fonksiyonu
v1 <- c(1, 2, 3)
v1

# 2. : operatörü
v2 <- 1:5
v2

# 3. seq() fonksiyonu
v3 <- seq(1, 10, by = 2)
v3

# 4. rep() fonksiyonu
v4 <- rep(5, times = 3)
v4

# Coercion örneği
v5 <- c(1, "Ali", TRUE)
v5
typeof(v5) # "character"

# Vektörlerde Elemanlara Erişim ----

# Örnek vektör
v <- c(10, 20, 30, 40, 50)

# 1. Tek eleman
v[3]

# 2. Birden fazla eleman
v[c(1, 4)]

# 3. Aralık
v[2:5]

# 4. Negatif indeks
v[-2]

# 5. Mantıksal indeks
v[c(TRUE, FALSE, TRUE, FALSE, TRUE)]


---
  
# Vektorlerde Eleman Değiştirme ----
  
# Örnek vektör
v <- c(10, 20, 30, 40, 50)

# 1. Tek eleman değiştirme
v[2] <- 99

# 2. Birden fazla eleman değiştirme
v[c(1, 4)] <- c(100, 200)

# 3. Aralık kullanarak değiştirme
v[2:4] <- c(5, 6, 7)

# 4. Mantıksal indeks ile değiştirme
v[v > 10] <- 0

# 5. Recycling örneği
v[1:4] <- c(1, 2)

# Vektör Uzunluğu ve Yapısı ----

# Vektör oluşturma
vektor <- c(5, 10, 15, 20, 25)

# 1️⃣ Uzunluk: length()
length(vektor)
# [1] 5
# Açıklama: Vektörde 5 eleman var.

# 2️⃣ Yapı: str()
str(vektor)
# num [1:5] 5 10 15 20 25
# Açıklama: Numeric tipinde, 1’den 5’e indekslenmiş 5 eleman var.

# 3️⃣ Özet: summary()
summary(vektor)
#   Min. 1st Qu.  Median    Mean 3rd Qu.    Max.
#      5      10      15      15     20      25
# Açıklama: Temel istatistik bilgileri (minimum, çeyrekler, medyan, ortalama, maksimum)

# Vektörlerde Eleman Ekleme ve Silme ----

# Mevcut vektör
v <- c(10, 20, 30)

# 1) c() ile ekleme
v_new <- c(v, 40)           # sona ekleme
v_new2 <- c(5, v)           # başa ekleme
v_new3 <- c(v[1:2], 25, v[3])  # araya ekleme (manuel)

v_new
v_new2
v_new3

# 2) append() ile belirli konuma ekleme
v_app <- append(v, 25, after = 2)  # 2. elemandan sonra ekleme
v_app

# 3) Negatif indeksleme ile silme
v_minus <- v[-2]            # 2. eleman hariç
v_minus

# 4) Mantıksal koşulla silme (filtreleme)
v_filter <- v[v <= 20]      # 20 ve altını tut
v_filter

# 5) NA davranışı
v_na <- c(10, NA, 20, 30)
v_filter_na <- v_na[!is.na(v_na) & v_na > 15]  # NA'ları ve küçük değerleri çıkar
v_filter_na

# Vektörlerde Aritmetik ve Karşılaştırma İşlemleri ----

# Örnek vektörler
a <- c(1, 2, 3)
b <- c(4, 5, 6)

# 1) Aritmetik işlemler (eleman bazlı)
a + b        # 5 7 9
a - b        # -3 -3 -3
a * b        # 4 10 18
b / a        # 4.0 2.5 2.0
a ^ 2        # 1 4 9

# 2) Karşılaştırma işlemleri
a > 2        # FALSE FALSE TRUE
a == c(1, 2, 5)  # TRUE TRUE FALSE

# 3) Geri dönüşüm (recycling) kuralı
x <- c(1, 2, 3, 4)
y <- c(10, 20)
x + y        # 11 22 13 24  (y -> 10,20,10,20)

# Uyarı örneği (uzunluklar kat değil)
z <- c(100, 200, 300)
x + z        # 101 202 303 104

# 4) Mantıksal sonuçla filtreleme
v <- c(5, 10, 15, 20, NA)
v[v > 12]            # 15 20 NA (NA karşılaştırmada NA döndürür)
v[!is.na(v) & v > 12]# 15 20   (NA'ları ayıklayarak filtre)

# Vektörlerde Tür Dönüşümü ----


# 1) Açık Dönüşüm (Explicit Conversion)

# Mantıksal -> Sayısal (TRUE=1, FALSE=0)
log_v <- c(TRUE, FALSE, TRUE)
as.numeric(log_v)

# Sayısal -> Mantıksal (0=FALSE, 0 dışı=TRUE)
num_v <- c(0, 1, -2, 3.5)
as.logical(num_v)

# Sayısal -> Karakter
as.character(c(3.14, 42))

# Karakter -> Sayısal
# Geçerli sayısal metinler çevrilir; geçersiz olanlar NA üretir (uyarı gelebilir)
char_ok  <- c("10", "20.5", "0")
char_bad <- c("10", "abc", "30")
as.numeric(char_ok)
as.numeric(char_bad)   # "abc" -> NA

# 2) Otomatik Dönüşüm (Coercion) 

# R, aynı vektörde farklı tipleri en kapsayıcı tipe dönüştürür:
# Öncelik: logical -> integer/numeric -> character

c(TRUE, 2, FALSE)         # logical -> numeric
c(1, "a", 3)              # numeric -> character
c(FALSE, "TRUE", TRUE)    # logical -> character

# 3) NA ve Karşılaştırma Notu

v <- c(5, NA, 10)
v > 6                 # NA ile karşılaştırma NA üretir
v[!is.na(v) & v > 6]  # NA'ları ayıklayarak filtrele

# 4) (Opsiyonel) Faktör Notu
# Faktörler integer KOD + etiketlerden oluşur.
# as.numeric(factor) -> KOD döner; etiketin kendisi değil.
f <- factor(c("10", "20", "10"))

typeof(f)     # "integer"
class(f)      # "factor"

as.numeric(f)                 # 1 2 1  (seviye kodları)
as.numeric(as.character(f))   # 10 20 10 (etiketlerin sayısal değeri)


