!! Albina Oscherowa
!! Karsten Lehmann

!! Die erste Primzahl größer als 10**9 ist 1 000 000 007. Diese Zahl
!! ist auch gleichzeitig eine Mirpzahl.
!! Um Primzwillinge zu zählen, sind die Kommentare vor der Zeile
!! 21 zu entfernen.
PROGRAM MIRP
  IMPLICIT NONE
  INTEGER :: a, b

  DO
     WRITE(*,*) "Bitte gib a und b mit 2 <= a < b <= 10**9 ein"
     READ (*,*) a, b
     IF (a <= b .and. 1 < a .and. b <= 10**9 + 1000) THEN
        EXIT
     END IF
  END DO

  call MirpZFinden(a,b)
  !!call PrimZwillinge(a, b)
  
CONTAINS
  SUBROUTINE MirpZFinden(a, b)
    INTEGER, INTENT(IN) :: a, b
    INTEGER :: n

    DO n = a, b
       IF (Prim(n)) THEN
          IF (Prim(Umkehrzahl(n))) THEN
             IF (n < 10) THEN
                WRITE(*,*) "Mirbzahl   : ", n
             ELSE
                WRITE(*,*) "Mirbzahlen : ", n, " und ", Umkehrzahl(n)
             END IF
          ELSE
             WRITE(*,*) "Primzahl   : ", n
          END IF
       END IF
    END DO
  END SUBROUTINE MirpZFinden

  SUBROUTINE PrimZwillinge(a,b)
    INTEGER, INTENT(IN) :: a, b
    INTEGER :: n, primzahlen = 0, primzwillingspaare = 0

    DO n = a, b
       IF (Prim(n)) THEN
          IF (Prim(n + 2)) THEN
             WRITE(*,*) "Primzwillinge : ", n, " und ", n + 2
             primzwillingspaare = primzwillingspaare + 1
          ELSe
             WRITE(*,*) "Primzahl      : ", n
             primzahlen = primzahlen + 1
          END IF
       END IF
    END DO
    WRITE(*,*) "Anzahl Primzahlen : ", primzahlen, "Anzahl Primzwillingspaare : ", primzwillingspaare
  END SUBROUTINE PrimZwillinge
    
  FUNCTION Prim (zahl)
    INTEGER :: zahl, n 
    LOGICAL :: Prim
    Prim = .true.
    IF (2 == zahl) THEN
       RETURN
    END IF
    IF (zahl == 1 .or. 0 == MOD(zahl, 2)) THEN
       Prim = .false.
       RETURN
    END IF

    DO n = 3, INT(SQRT(zahl * 1.0)), 2  
       IF (MOD(zahl, n) == 0) THEN
          Prim = .false.
          RETURN
       END IF
    END DO
  END FUNCTION Prim
       
  FUNCTION Umkehrzahl (eingabe)
    INTEGER :: untere10nerPotenz, zahl, eingabe, Umkehrzahl, n
    zahl = eingabe
    n = 0
    Umkehrzahl = 0
    DO WHILE (zahl .ne. 0)
       untere10nerPotenz = 10**INT(LOG10(zahl * 1.0))
       Umkehrzahl = Umkehrzahl + zahl / untere10nerPotenz * 10**n 
       n = n + 1
       zahl = zahl - (zahl / untere10nerPotenz) * untere10nerPotenz 
    END DO
  END FUNCTION Umkehrzahl
END PROGRAM MIRP
