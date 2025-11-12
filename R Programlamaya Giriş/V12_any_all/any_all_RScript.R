############################################################
# R Programlamaya Giriş
# Konu: any() ve all() Fonksiyonları
# Hazırlayan: Dr. M. Fatih Tüzen
############################################################

# Mantıksal (logical) değerleri hatırlayalım
# TRUE → koşul sağlanmış, FALSE → koşul sağlanmamış
x <- c(TRUE, FALSE, TRUE)
x

############################################################
# any() Fonksiyonu
############################################################

# any() fonksiyonu, vektörde EN AZ bir TRUE varsa TRUE döner
any(c(TRUE, FALSE, FALSE))   # Sonuç: TRUE
any(c(FALSE, FALSE, FALSE))  # Sonuç: FALSE

# Sayısal örnek: herhangi bir pozitif sayı var mı?
numbers <- c(-2, 0, 5, -7)
any(numbers > 0)             # TRUE çünkü 5 > 0

# Veri içinde eksik değer (NA) var mı?
values <- c(2, 4, NA, 7)
any(is.na(values))           # TRUE çünkü bir NA var

# Eğer NA'ları dikkate almak istemezsek:
any(is.na(values), na.rm = TRUE)  # TRUE – NA'ları yok sayarak kontrol eder

############################################################
# all() Fonksiyonu
############################################################

# all() fonksiyonu, vektörde TÜM değerler TRUE ise TRUE döner
all(c(TRUE, TRUE, TRUE))     # TRUE
all(c(TRUE, FALSE, TRUE))    # FALSE

# Sayısal örnek: tüm sayılar pozitif mi?
numbers <- c(3, 5, 7)
all(numbers > 0)             # TRUE

# Eğer bir tanesi negatifse:
numbers <- c(3, -2, 5)
all(numbers > 0)             # FALSE

# Tüm değerler eksiksiz mi?
values <- c(1, 2, 3, NA)
all(!is.na(values))          # FALSE – çünkü bir tane NA var

############################################################
# any() ve all() Farkını Görelim
############################################################

check <- c(TRUE, FALSE)
any(check)   # TRUE – en az biri TRUE
all(check)   # FALSE – hepsi TRUE değil

# Küçük bir tablo gibi düşünelim:
# c(TRUE, FALSE)  → any = TRUE,  all = FALSE
# c(FALSE, FALSE) → any = FALSE, all = FALSE
# c(TRUE, TRUE)   → any = TRUE,  all = TRUE

############################################################
# if Koşullarında Kullanımı
############################################################

numbers <- c(3, -1, 4)

# En az bir negatif sayı var mı?
if (any(numbers < 0)) {
  print("Negatif sayı var.")
}

# Tüm sayılar pozitif mi?
if (all(numbers > 0)) {
  print("Tüm sayılar pozitif.")
} else {
  print("En az bir sayı pozitif değil.")
}

############################################################
# NA Değerleri ile Davranış
############################################################

# NA'lar bazen belirsiz sonuçlara neden olur:
any(c(TRUE, NA))   # Sonuç: TRUE (çünkü biri TRUE)
all(c(TRUE, NA))   # Sonuç: NA (emin olamıyor)

# na.rm = TRUE ile NA'ları yok sayabiliriz:
any(c(TRUE, NA), na.rm = TRUE)  # TRUE
all(c(TRUE, NA), na.rm = TRUE)  # TRUE

############################################################
# Mini Uygulama Örneği
############################################################

# 1. Bir vektörde sıfır var mı?
x <- c(1, 2, 3, 0)
any(x == 0)   # TRUE

# 2. Tüm değerler pozitif mi?
all(x > 0)    # FALSE – çünkü sıfır pozitif değil

# 3. Veri eksik mi?
y <- c(5, 6, NA, 8)
any(is.na(y))  # TRUE – eksik değer var

############################################################
# Özet
############################################################

# any() → En az bir koşul doğruysa TRUE
# all() → Tüm koşullar doğruysa TRUE
# na.rm = TRUE → Eksik değerleri yok say
# if içinde kullanımı → Mantıksal kontrolü kolaylaştırır

############################################################
# Bitti 🎬
############################################################
