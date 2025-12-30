# ======================================================================
# R Programlamaya Giriş
# Konu: Veriye İlk Bakış — head() ve tail()
# Yazar: Dr. M. Fatih Tüzen
#
# Amaç:
# - Veriyle ilk temas refleksini kazanmak
# - head() / tail() ile hızlı ön-izleme yapmak
# - n argümanı (pozitif ve negatif) ile kontrolü ele almak
#
# Not:
# - Bu script bir “analiz” scripti değil; veri keşfinin (EDA) ilk adımına odaklanır.
# - head()/tail() çıktısı verinin tamamını temsil etmez; sadece ilk izlenimi verir.
# ======================================================================


# ----------------------------------------------------------------------
# 0) Örnek Veri: mtcars
# ----------------------------------------------------------------------
# R ile birlikte gelen, sık kullanılan küçük bir örnek veri seti.
# - Satırlar: gözlemler (araçlar)
# - Sütunlar: değişkenler (hp, mpg, wt, ...)
#
# Veri setini incelemeye “körlemesine” başlamıyoruz.
# İlk refleks: “Veri nasıl görünüyor?”
data(mtcars)


# ----------------------------------------------------------------------
# 1) Veri Analizinde İlk Refleks: Veriyi görmek
# ----------------------------------------------------------------------
# Bir veri seti yüklendiğinde akla gelen ilk sorular:
# - Kaç satır/sütun var?
# - Değişken adları ne?
# - İlk/son gözlemler mantıklı mı?
#
# head() ve tail() bu sorular için en hızlı araçlardır.


# ----------------------------------------------------------------------
# 2) head() — İlk gözlemlerle tanışma
# ----------------------------------------------------------------------
# head(x) varsayılan olarak ilk 6 gözlemi getirir.
head(mtcars)

# head() çıktısında pratik kontrol:
# - Değişken adları okunabilir mi?
# - Sayısal olması beklenen bir değişken karakter/faktör gibi mi gelmiş?
# - İlk satırlarda bariz hata var mı?
#
# Bu bir “keşif” adımıdır; modelleme değildir.


# ----------------------------------------------------------------------
# 3) head() ve n argümanı (pozitif): Kaç satır göreceğini seç
# ----------------------------------------------------------------------
# Varsayılan 6 satır bazen yetmez.
# n argümanı ile daha fazla (ya da daha az) satır görebilirsin.
head(mtcars, n = 10)

# Daha küçük n de mümkündür (okunabilirlik için):
head(mtcars, n = 3)


# ----------------------------------------------------------------------
# 4) head() ve n argümanı (negatif): Son k gözlemi hariç tutmak
# ----------------------------------------------------------------------
# Bu kullanım “çok bilinmez ama çok işe yarar”.
# head(x, n = -k) => SON k gözlemi hariç bırakır, geri kalanı gösterir.
#
# Ne zaman işe yarar?
# - Son satırlarda güncelleme hatası / yarım kayıt şüphesi varsa
# - “Sondaki birkaç satır” veri dışı (ör. dipnot/özet) ise
#
# Dikkat:
# - Büyük veri setlerinde bu komut çok satır basabilir.
# - Bu yüzden k değerini küçük tutmak mantıklı.
head(mtcars, n = -2)


# ----------------------------------------------------------------------
# 5) tail() — Son gözlemlerle “son durum” kontrolü
# ----------------------------------------------------------------------
# tail(x) varsayılan olarak son 6 gözlemi getirir.
tail(mtcars)

# tail() özellikle şunlar için kritiktir:
# - Zaman serilerinde en güncel gözlemleri kontrol etmek
# - Veri akışında son kaydın tamamlanıp tamamlanmadığını görmek
# - Log kayıtları, günlük tablolar, aylık güncellenen dosyalar


# ----------------------------------------------------------------------
# 6) tail() ve n argümanı (pozitif): Son kaç satırı görmek istiyorsun?
# ----------------------------------------------------------------------
tail(mtcars, n = 3)

# Biraz daha fazla:
tail(mtcars, n = 10)


# ----------------------------------------------------------------------
# 7) tail() ve n argümanı (negatif): İlk k gözlemi hariç tutmak
# ----------------------------------------------------------------------
# tail(x, n = -k) => İLK k gözlemi hariç bırakır, geri kalanı gösterir.
#
# Ne zaman işe yarar?
# - İlk satırlarda başlık kayması / meta satırları / örnek kayıtlar varsa
# - Veri setinin “gövdesini” görmek istiyorsan
#
# Dikkat:
# - Yine büyük veri setlerinde uzun çıktı üretebilir.
tail(mtcars, n = -2)


# ----------------------------------------------------------------------
# 8) head() vs tail(): Aynı araç, farklı soru
# ----------------------------------------------------------------------
# head(): “Verinin yapısı nasıl başlıyor?”
# tail(): “Verinin son durumu ne?”
#
# İkisini birlikte kullanmak iyi bir alışkanlıktır:
# - Uçları kontrol edersin
# - Birçok veri hatası uçlarda görünür (başlık kayması, eksik güncelleme vb.)
head(mtcars, n = 6)
tail(mtcars, n = 6)


# ----------------------------------------------------------------------
# 9) İlk/son gözlemlerin önemi: Basit kontroller
# ----------------------------------------------------------------------
# Örnek: Veri son satırlarda eksik mi? (NA kontrolü)
# (mtcars'ta NA yok; bu sadece refleks göstermek için.)
anyNA(head(mtcars))
anyNA(tail(mtcars))

# Örnek: Değişken adları / sütunlar mantıklı mı?
names(mtcars)

# Örnek: Boyut bilgisi (kaç satır, kaç sütun?)
dim(mtcars)

# Bu noktada genellikle bir sonraki adıma geçilir:
# - str() ile yapı
# - summary() ile özet




