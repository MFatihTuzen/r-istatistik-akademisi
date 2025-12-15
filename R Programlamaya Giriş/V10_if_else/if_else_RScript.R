#######################################################################
# R PROGRAMLAMAYA GİRİŞ — KONTROL İFADELERİ: if / else
# Yazar   : Dr. M. Fatih Tüzen
# Amaç    : if, else if, else, ifelse(), case_when(), mantıksal operatörler
#######################################################################

## -------------------------------------------------------------------
## 0) ORTAM AYARLARI (opsiyonel)
## -------------------------------------------------------------------
rm(list = ls())          # Çalışma alanını temizler
set.seed(123)            # Rastgelelik kullanılan yerler için tekrarlanabilirlik

## -------------------------------------------------------------------
## 1) MANTİKSAL TEMEL: TRUE / FALSE / NA
## -------------------------------------------------------------------
x <- 5
y <- 2
z <- NA

# Temel karşılaştırmalar
x > y        #> TRUE
x < y        #> FALSE
x == 5       #> TRUE
x != 5       #> FALSE

# NA ile karşılaştırma her zaman NA dönebilir (belirsiz)
z == 10      #> NA
is.na(z)     #> TRUE

# Güvenli kontrol örneği: NA'ları önce ele
if (!is.na(z) && z > 10) {
  message("z > 10")
} else {
  message("z NA veya 10'dan büyük değil")
}


## -------------------------------------------------------------------
## 2) if YAPISI (tek durum)
## -------------------------------------------------------------------
x <- 10
if (x > 5) {
  message("x 5'ten büyük")
}


# Tek satırda da yazılabilir; fakat okunabilirlik için {} önerilir
if (x %% 2 == 0) message("x çifttir")


## -------------------------------------------------------------------
## 3) if ... else (ikili durum)
## -------------------------------------------------------------------
x <- 3
if (x > 5) {
  message("Büyük")
} else {
  message("Küçük veya eşit")
}


## -------------------------------------------------------------------
## 4) if ... else if ... else (çoklu durum zinciri)
## -------------------------------------------------------------------
x <- 10
if (x > 10) {
  message("Büyük")
} else if (x == 10) {
  message("Eşit")
} else {
  message("Küçük")
}


## -------------------------------------------------------------------
## 5) MANTİKSAL OPERATÖRLER: &, |, !  (ve kısa devre: &&, ||)
## -------------------------------------------------------------------
x <- 7
(x > 0) & (x < 10)    # VE  -> TRUE ancak her iki koşul da TRUE ise

(x > 10) | (x == 7)   # VEYA -> TRUE koşullardan en az biri TRUE ise

!(x == 7)             # DEĞİL -> FALSE (çünkü x == 7 TRUE idi)


# Kısa devre operatörleri (ilk öğe üzerinden çalışır): &&, ||
# Tipik kullanım: akış kontrolünde tek bir TRUE/FALSE değeri istediğimizde
c(TRUE, FALSE) & c(FALSE, TRUE)   # vektörel

c(TRUE, FALSE) && c(FALSE, TRUE)  # sadece ilk öğeler: TRUE && FALSE -> FALSE


## -------------------------------------------------------------------
## 6) GERÇEK HAYAT ÖRNEĞİ: Sıcaklık Yorumu
## -------------------------------------------------------------------
temp <- 25
if (temp < 0) {
  mesaj <- "Donma noktası altı!"
} else if (temp < 15) {
  mesaj <- "Soğuk bir gün"
} else if (temp < 30) {
  mesaj <- "Ilık bir hava"
} else {
  mesaj <- "Oldukça sıcak!"
}
mesaj


## -------------------------------------------------------------------
## 7) VEKTÖREL KOŞULLAR: ifelse()
## -------------------------------------------------------------------
# if -> tek karar; ifelse -> vektör üzerinde eleman bazlı karar
puan <- c(42, 57, 88, 73, NA)

# Basit sınıflama
sonuc <- ifelse(puan >= 60, "Geçti", "Kaldı")
sonuc


# NA'yı güvenli ele alma (öncelik NA kontrolünde)
sonuc2 <- ifelse(is.na(puan), "Bilinmiyor",
                 ifelse(puan >= 60, "Geçti", "Kaldı"))
sonuc2


## -------------------------------------------------------------------
## 8) ÇOKLU KOŞULLARDA OKUNABİLİRLİK: dplyr::case_when()
## -------------------------------------------------------------------
# Not: Otomatik kurulum yapmıyoruz; varsa yüklenir, yoksa örneği atlıyoruz
if (requireNamespace("dplyr", quietly = TRUE)) {
  library(dplyr)
  
  # Örnek veri çerçevesi
  df <- tibble::tibble(
    id = 1:8,
    gelir = c(12000, 35000, 60000, 90000, 150000, NA, 48000, 300000)
  )
  
  # Basit vergi dilimi örneği (temsili)
  df <- df |>
    mutate(
      vergi_dilimi = case_when(
        is.na(gelir)           ~ "bilinmiyor",
        gelir <  20000         ~ "düşük",
        gelir <  80000         ~ "orta",
        gelir <  200000        ~ "yüksek",
        TRUE                   ~ "çok yüksek"
      ),
      # oranı da örnekleyelim
      vergi_orani = case_when(
        vergi_dilimi == "düşük"       ~ 0.10,
        vergi_dilimi == "orta"        ~ 0.20,
        vergi_dilimi == "yüksek"      ~ 0.30,
        vergi_dilimi == "çok yüksek"  ~ 0.35,
        TRUE                           ~ NA_real_
      )
    )
  
  print(df)

} else {
  message("dplyr bulunamadı; case_when() örneği atlandı.")
}

## -------------------------------------------------------------------
## 9) UYGULAMA: Stok Uyarı Sistemi
## -------------------------------------------------------------------
stok <- c(0, 3, 7, 15, 2, NA)

uyari <- ifelse(is.na(stok), "veri yok",
                ifelse(stok == 0, "acil sipariş",
                       ifelse(stok < 5, "düşük stok",
                              "yeterli")))
cbind(stok, uyari)


## -------------------------------------------------------------------
## 10) ̇SIK YAPILAN HATALAR (ANTI-PATTERNS)
## -------------------------------------------------------------------
# 10.1 Eşitlikte = yerine == yazmamak
a <- 5
# if (a = 5) {...}  # HATA: atama operatörü; çalıştırmayın!

# 10.2 if ile vektör kullanmak: sadece ilk öğe değerlendirilir
v <- c(TRUE, FALSE, FALSE)
if (v) { message("Bu mesaj yalnızca ilk öğe TRUE olduğu için görünüyor") }

# Doğrusu: any(v) veya all(v) ile açıkça belirtin
any(v)  #> TRUE
all(v)  #> FALSE

# 10.3 if(NA) yazmak (kararsız durum)
flag <- NA
# if (flag) message("...")  # HATA: kullanmayın
if (isTRUE(flag)) message("flag TRUE") else message("flag TRUE değil veya NA")


## -------------------------------------------------------------------
## 11) İYİ UYGULAMALAR
## -------------------------------------------------------------------
# 11.1 Koşulları isimlendirerek okunabilirlik kazandırın
yas <- 17
reşit_mi <- yas >= 18
if (isTRUE(reşit_mi)) {
  msg <- "Erişkin"
} else {
  msg <- "Reşit değil"
}
msg


# 11.2 Savunmacı programlama: tür/alan kontrolü
x <- 12
stopifnot(is.numeric(x), length(x) == 1)  # Beklenti sağlanmazsa hata verir

# 11.3 Sınırları netleştirin (dahil mi hariç mi?)
gelir <- 20000
if (gelir < 20000) {
  dilim <- "düşük"
} else if (gelir >= 20000 && gelir < 80000) {
  dilim <- "orta"
} else {
  dilim <- "yüksek veya üzeri"
}
dilim

