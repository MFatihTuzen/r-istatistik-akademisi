############################################################
# R Programlama ve İstatistik Akademisi
# Konu: Veri Import ve Export Mantığı (CSV & Excel)
# Örnek veri: tips (seaborn-data)
# Not: Bu script eğitim amaçlıdır. Kod bloklarını adım adım çalıştırın.
############################################################

############################################################
# 0) Kurulum ve Hazırlık
############################################################

# Bu ders için kullanacağımız paket:
# - openxlsx: Excel okuma/yazma (Excel programına ihtiyaç duymaz)
#
# Eğer yüklü değilse:
# install.packages("openxlsx")

library(openxlsx)

# Veri kaynağı (tips.csv):
# https://raw.githubusercontent.com/mwaskom/seaborn-data/master/tips.csv
url_tips <- "https://raw.githubusercontent.com/mwaskom/seaborn-data/master/tips.csv"


############################################################
# 1) Çalışma Dizini ve Dosya Yolu Mantığı
############################################################

# R, dosyaları "rastgele" yerlerden okumaz.
# read.csv("tips.csv") gibi bir kullanımda R, dosyayı çalışma dizininde arar.

# Çalışma dizinini gör:
getwd()

# İstersen çalışma dizinini değiştir:
# (Kendi bilgisayarındaki gerçek bir klasörü yazmalısın.)
# setwd("C:/projeler/r-egitim")

# En sık hata: Dosya bilgisayarda vardır ama R yanlış klasöre bakıyordur.
# Çözüm: getwd() ile nereye baktığını kontrol et, dosyayı o klasöre koy
# veya dosya yolunu tam ver (absolute path).


############################################################
# 2) Veri Dosyasını Hazırlama (tips.csv dosyasını indirme)
############################################################

# Bu video "webden doğrudan okuma" değil, dosya temelli import/export üzerine.
# Bu yüzden veri dosyasını önce indirip klasöre koyuyoruz.

download.file(url_tips, destfile = "tips.csv", mode = "wb")

# Dosya gerçekten indi mi?
file.exists("tips.csv")


############################################################
# 3) CSV Import: read.table() Mantığı
############################################################

# read.table() en genel okuma fonksiyonudur.
# CSV de temelde bir metin dosyasıdır; ayırıcı (sep) ve ondalık (dec) kritiktir.

tips_rt <- read.table(
  file = "tips.csv",
  header = TRUE,            # İlk satır değişken isimleri mi?
  sep = ",",                # Ayırıcı karakter (virgül)
  dec = ".",                # Ondalık ayracı (nokta)
  stringsAsFactors = FALSE  # Metinleri factor'a çevirmesin
)

# Hızlı kontrol (okuma doğru mu?)
head(tips_rt)
str(tips_rt)


############################################################
# 4) CSV Import: read.csv() (Virgüllü CSV)
############################################################

# read.csv() aslında read.table(..., sep=",", dec=".", header=TRUE) kısayoludur.
tips <- read.csv("tips.csv")

# Kontrol: Boyutlar, ilk satırlar, değişken tipleri
dim(tips)
head(tips)
str(tips)

# Önemli not:
# R bazen "hata vermeden" yanlış okuyabilir.
# Bu yüzden import sonrası str() / head() gibi kontroller alışkanlık olmalı.


############################################################
# 5) CSV Export: write.csv() ile "comma-separated" dosya üretme
############################################################

# write.csv: Varsayılan ayırıcı virgül, ondalık nokta
# row.names=FALSE: satır numaralarının ayrı sütun gibi yazılmasını engeller (genellikle istenmez).
write.csv(
  tips,
  file = "tips_comma.csv",
  row.names = FALSE
)

file.exists("tips_comma.csv")


############################################################
# 6) CSV Export: write.csv2() ile "semicolon-separated" dosya üretme
############################################################

# write.csv2: Varsayılan ayırıcı noktalı virgül, ondalık virgül
# Avrupa/Türkiye Excel yerel ayarlarına daha uyumlu olabilir.
write.csv2(
  tips,
  file = "tips_semicolon.csv",
  row.names = FALSE
)

file.exists("tips_semicolon.csv")


############################################################
# 7) CSV Import: read.csv2() ve Varsayımlar
############################################################

# read.csv2 varsayımları:
# - sep=";"
# - dec=","
#
# DİKKAT:
# Bazı durumlarda dosyada ondalık "." olsa bile read.csv2 yine okuyabilir.
# Ama bu garanti değildir; doğru yaklaşım dosya yapısını bilerek fonksiyon seçmektir.

tips_sc <- read.csv2("tips_semicolon.csv")

# Kontrol
head(tips_sc)
str(tips_sc)

# Tip kontrolü (örnek): total_bill ve tip sayısal mı?
is.numeric(tips_sc$total_bill)
is.numeric(tips_sc$tip)


############################################################
# 8) Excel Export: Tek sheet olarak Excel'e yazma (openxlsx)
############################################################

# Basit kullanım: tek sheet ile dosya yazdırma
write.xlsx(
  x = tips,
  file = "tips.xlsx",
  sheetName = "tips"
)

file.exists("tips.xlsx")

# Excel dosyasındaki sheet isimlerini gör:
getSheetNames("tips.xlsx")


############################################################
# 9) Excel Import: Excel'den veri okuma (openxlsx)
############################################################

tips_excel <- read.xlsx(
  xlsxFile = "tips.xlsx",
  sheet = 1
)

# Kontrol
head(tips_excel)
str(tips_excel)


############################################################
# 10) Excel Export: Çoklu sheet ile "mini rapor" üretme
############################################################

# Excel dosyaları tek dosyada birden fazla tablo saklamak için idealdir.
# Burada:
# - Sheet 1: Ham veri
# - Sheet 2: Basit özet tablo
# oluşturacağız.

# 10.1) Basit bir özet tablo üretelim
# Amaç: "ham veri + özet" yapısını göstermek (raporlama mantığı)
summary_tips <- aggregate(
  tip ~ day,
  data = tips,
  FUN = mean
)

# Daha okunur olması için kolon adını düzenleyelim
names(summary_tips) <- c("day", "mean_tip")

summary_tips


# 10.2) Workbook oluştur, sheet ekle, veri yaz, kaydet
wb <- createWorkbook()

# Ham veri sayfası
addWorksheet(wb, "Ham Veri")
writeData(wb, sheet = "Ham Veri", x = tips)

# Özet sayfası
addWorksheet(wb, "Ozet")
writeData(wb, sheet = "Ozet", x = summary_tips)

# Kaydet (overwrite=TRUE: dosya varsa üzerine yazar)
saveWorkbook(
  wb,
  file = "tips_rapor.xlsx",
  overwrite = TRUE
)

file.exists("tips_rapor.xlsx")
getSheetNames("tips_rapor.xlsx")


############################################################
# 11) Hızlı Kontrol Rehberi (İyi Alışkanlıklar)
############################################################

# Her import işleminden sonra:
# - head()
# - str()
# - summary()
#
# gibi kontrolleri yapmayı alışkanlık hâline getirin.

# Örnek kontrol:
summary(tips)

# Dosyaların nerede oluştuğunu unutma:
getwd()


