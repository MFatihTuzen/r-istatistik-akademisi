############################################################
# R Programlamaya Giriş — Matrisler (Örnek Kodlar)
############################################################

# ----------------------------------------------------------
# 1) Matris Nedir? (örnek kurulum)
# ----------------------------------------------------------
# Bu bölümde kavramsal açıklama var; kod minimal.
M_example <- matrix(1:6, nrow = 2, byrow = TRUE)
M_example
# beklenen: 2x3 matris

# ----------------------------------------------------------
# 2) R’de Matris Oluşturma
# ----------------------------------------------------------

# 2.1 matrix() ile
M1 <- matrix(1:6, nrow = 2, ncol = 3)        # sütun sütun doldurur
M2 <- matrix(1:6, nrow = 2, byrow = TRUE)    # satır satır doldurur
M1; M2
dim(M1)  # c(2, 3)

# 2.2 cbind() ve rbind() ile
v1 <- c(10, 20, 30)
v2 <- c(40, 50, 60)
MC <- cbind(v1, v2)  # 3x2
MR <- rbind(v1, v2)  # 2x3
MC; MR

# ----------------------------------------------------------
# 3) Matrislerde İndeksleme
# ----------------------------------------------------------
M <- matrix(1:9, nrow = 3, byrow = TRUE)
M
M[2, 3]          # tek eleman
M[, 2]           # 2. sütun (vektör)
M[1, ]           # 1. satır (vektör)
M[, 2, drop=FALSE]  # 2. sütunu matris olarak koru (3x1)
M[M %% 2 == 0]   # mantıksal indeksleme: çift sayılar

# ----------------------------------------------------------
# 4) Temel İşlemler (Eleman Bazlı)
# ----------------------------------------------------------
A <- matrix(c(2, 4, 6, 8), nrow = 2)   # 2x2
B <- matrix(c(1, 3, 5, 7), nrow = 2)   # 2x2

A + B
A - B
A * B       # eleman bazlı çarpım
A / B
A ^ 2

t(A)        # transpoz
rowSums(A)  # satır toplamları
colMeans(A) # sütun ortalamaları

apply(A, 1, sum)   # satır toplamı
apply(A, 2, max)   # sütun maksimumu

# ----------------------------------------------------------
# 5) Matematiksel Matris İşlemleri (Temel)
# ----------------------------------------------------------

# 5.1 Matris çarpımı vs. eleman bazlı
X <- matrix(1:6, nrow = 2, byrow = TRUE)  # 2x3
Y <- matrix(1:6, nrow = 3, byrow = TRUE)  # 3x2
X %*% Y    # sonuç: 2x2
# Not: X * Y hatalıdır (boyutlar eşleşmediği için), eleman bazlı çarpımda boyutlar aynı olmalı.

# 5.2 Birim matris ve determinant
I3 <- diag(3)  # 3x3 kimlik matrisi
I3
D <- matrix(c(2, 1, 0,
              0, 3, 0,
              1, 0, 4), nrow = 3, byrow = TRUE)
det(D)  # determinant değeri (0 değilse ters alınabilir)

# 5.3 Ters matris ve doğrusal denklem çözümü
# A2 x = b için çözüm
A2 <- matrix(c(2, 3,
               1, -1), nrow = 2, byrow = TRUE)
b <- c(8, 1)

solve(A2)      # A2'nin tersi
solve(A2, b)   # x vektörü; beklenen ~ c(2.2, 1.2)

# Alternatif basit ters örneği (köşegen matris):
E <- diag(c(2, 3))  # diag ile köşegen
solve(E)            # diag(c(1/2, 1/3))


