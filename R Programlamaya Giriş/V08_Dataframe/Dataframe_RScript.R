############################################################

# R Programlamaya Giriş: Veri YApıları — Dataframe’ler (Örnek Kodlar)

############################################################


# ==========================================================
# 1) DATAFRAME NEDİR? (örnek kurulum)
# ----------------------------------------------------------
# Dataframe: Eşit uzunlukta vektörlerden oluşan, liste tabanlı (S3) bir tablodur.
# - Satırlar gözlemleri, sütunlar değişkenleri temsil eder.
# - Sütun tipleri farklı olabilir (numeric/character/logical/factor).
# - Vektör uzunlukları eşit değilse data.frame oluşturulamaz.
# ----------------------------------------------------------
mini <- data.frame(
  id  = 1:5,                      # integer vektör (1,2,3,4,5)
  grp = c("A","A","B","B","C"),   # character vektör
  x   = c(10, NA, 13, 9, 12)      # numeric vektör (NA içerebilir)
  # stringsAsFactors = FALSE       # R >= 4.0'da zaten FALSE
)

mini
#>   id grp  x
#> 1  1   A 10
#> 2  2   A NA
#> 3  3   B 13
#> 4  4   B  9
#> 5  5   C 12



# ==========================================================
# 2) OLUŞTURMA VE HIZLI İNCELEME
# ----------------------------------------------------------
# Temel tanı fonksiyonları:
# - str(obj): yapıyı gösterir (sınıf, sütun tipleri, örnekler).
# - head/tail(obj, n): ilk/son n satırı gösterir (varsayılan n=6).
# - dim(obj), nrow(obj), ncol(obj): boyutlar.
# - names/colnames(obj): sütun adları.
# - class(obj), typeof(obj): sınıf ve depolama tipi.
# ----------------------------------------------------------
str(mini)
head(mini, 3)
tail(mini, 2)
dim(mini); nrow(mini); ncol(mini)
names(mini); colnames(mini)
class(mini); typeof(mini)



# ==========================================================
# 3) İNDEKSLEME 101: [, $, [[ ]]
# ----------------------------------------------------------
# Sözdizimi: df[ satirlar , sutunlar ]
# - Satır/sütun seçiminde üç yöntem: konum, isim, negatif (hariç bırakma).
# - Tek sütun seçerken tabloyu korumak için: drop = FALSE
# - '$' isimle hızlı erişim sağlar (kısmi eşleşme yapabilir → uyarı açık).
# - '[[ ]]' tek sütun/öğe döndürür ve kısmi eşleşme yapmaz (daha güvenli).
# ----------------------------------------------------------

## 3.1 Konumla seçim
mini[1:3, 1:2]                  # ilk 3 satır, ilk 2 sütun
mini[c(2,5), c(3,1)]            # 2. ve 5. satır; 3. ve 1. sütun

## 3.2 İsimle seçim
mini[, c("grp","x"), drop = FALSE]   # tabloyu koru (data.frame)
mini[["grp"]]                         # vektör döner (güvenli erişim)
mini$grp                              # vektör; kısmi eşleşme uyarısı açıksa görürsünüz

## 3.3 Negatif indeks (hariç bırakma)
mini[-1, ]                        # 1. satırı hariç bırak
mini[, -1]                        # 1. sütunu hariç bırak (id gider)

## 3.4 Tek sütunda drop davranışı
mini[, "grp"]                     # vektör (drop varsayılan TRUE)
mini[, "grp", drop = FALSE]       # tek sütun ama TABLO (drop=FALSE)



# ==========================================================
# 4) KOŞULLU FİLTRELEME (mantıksal)
# ----------------------------------------------------------
# Mantıksal bağlaçlar: & (ve), | (veya), ! (değil)
# Karşılaştırmalar: ==, !=, >, >=, <, <=
# Küme seçimi: %in%
# which(): TRUE olanların indeksini verir (okunabilirlik/perf. için yararlı olabilir)
# ----------------------------------------------------------
data(iris)   # gömülü veri seti

## 4.1 Tek koşul
head( iris[ iris$Species == "setosa", c("Sepal.Length","Species") ] , 6 )

## 4.2 Birden fazla koşul
sub_multi <- iris[ iris$Species != "setosa" & iris$Sepal.Length > 7,
                   c("Sepal.Length","Species") ]
head(sub_multi)

## 4.3 Küme bazlı seçim
sel <- iris[ iris$Species %in% c("setosa","versicolor"), ]
head(sel)

## 4.4 which() ile indeks üzerinden
rows <- which(iris$Sepal.Length > 7 & iris$Species != "setosa")
iris[ rows, c("Sepal.Length","Species") ]



# ==========================================================
# 5) NA YÖNETİMİ (Giriş)
# ----------------------------------------------------------
# - NA tespiti: is.na(x)
# - Tam satırlar: complete.cases(df)
# - na.omit(df): NA içeren satırları düşürür (dikkat: veri kaybı!)
# - Basit doldurma: eğitim amaçlı (ör. ortalama ile)
# ----------------------------------------------------------
na_df <- data.frame(
  id  = 1:6,
  grp = c("A","A","B","B","B","C"),
  x   = c(10, NA, 13,  9, 12, NA),
  y   = c( 5,  7, NA,  4,  6,  3)
)

is.na(na_df$x)                        # hangi gözlemler NA?

na_df[ complete.cases(na_df), ]       # NA içermeyen "tam" satırlar

na_omit <- na.omit(na_df)             # NA içeren satırları düşürür
na_omit

# Basit doldurma (x sütunu için ortalama ile) — sadece eğitim amaçlı:
x_mean <- mean(na_df$x, na.rm = TRUE) # NA’ları yoksayarak ortalama
na_fill <- na_df
na_fill$x[ is.na(na_fill$x) ] <- x_mean
na_fill



# ==========================================================
# 6) SÜTUN İŞLEMLERİ (ekle, sil, yeniden adlandır, sırala)
# ----------------------------------------------------------
# - Ekleme: df$yeni <- ifade
# - Silme: df$kolon <- NULL
# - Yeniden adlandırma: names(df)[names(df)=="eski"] <- "yeni"
# - Sıra değiştirme: df[c("B","A","C")] gibi sütun adları vektörü ver
# ----------------------------------------------------------
df2 <- mini

## 6.1 Ekleme
df2$ratio <- df2$x / 2

## 6.2 Yeniden adlandırma
names(df2)[ names(df2) == "x" ] <- "x_val"

## 6.3 Sıra değiştirme
df2 <- df2[c("id","grp","x_val","ratio")]

## 6.4 Silme
df2$ratio <- NULL

df2
#>   id grp x_val
#> 1  1   A    10
#> 2  2   A    NA
#> 3  3   B    13
#> 4  4   B     9
#> 5  5   C    12



# ==========================================================
# 7) SIRALAMA (order) ve ALT KÜMELER
# ----------------------------------------------------------
# order(..., decreasing=FALSE, na.last=TRUE)
# - Çok anahtarlı sıralama: order(anahtar1, anahtar2, ...)
# - Azalan için:
#     * sayısal:  -x
#     * karakter/faktör: -xtfrm(x)  (çünkü '-' karaktere uygulanamaz)
# ----------------------------------------------------------

## 7.1 Her ikisi de ARTAN
ord1 <- order(iris$Sepal.Length, iris$Species)
head( iris[ord1, c("Sepal.Length","Species")], 10 )

## 7.2 Sepal.Length AZALAN, Species ARTAN
ord2 <- order(-iris$Sepal.Length, iris$Species)
head( iris[ord2, c("Sepal.Length","Species")], 10 )

## 7.3 Her ikisi de AZALAN (karakter/faktör için xtfrm)
ord3 <- order(-iris$Sepal.Length, -xtfrm(iris$Species))
head( iris[ord3, c("Sepal.Length","Species")], 10 )

## 7.4 Küresel azalan (tüm anahtarlar ↓)
ord4 <- order(iris$Sepal.Length, iris$Species, decreasing = TRUE)
head( iris[ord4, c("Sepal.Length","Species")], 10 )


# ==========================================================
# 8) GÜVENLİ ERİŞİM & KISMİ EŞLEŞME (mini demo)
# ----------------------------------------------------------
# '$' operatörü isimleri kısmi eşleştirebilir (örn. 'gr' → 'grp').
# Bu, yanlış sütunu döndürebilir veya NULL üretebilir.
# Güvenli kalıplar:
# - df[["kolon"]]
# - df[, "kolon", drop = FALSE]
# Geliştirmede uyarı açmak: options(warnPartialMatchDollar = TRUE)
# ----------------------------------------------------------
demo <- data.frame(group = 1:3, grp = 4:6)
names(demo)
#> [1] "group" "grp"

demo$gr           # kısmi eşleşme uyarısı; davranış veri/ortama göre değişebilir
demo[["grp"]]     # güvenli ve açık
demo[, "grp", drop = FALSE]  # tablo olarak döndür




