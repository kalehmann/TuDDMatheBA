!! Karsten Lehmann (4935758)

MODULE mod_roots
  IMPLICIT NONE

  INTEGER, PARAMETER :: real_kind = SELECTED_REAL_KIND(P=10, R=100)

CONTAINS
  SUBROUTINE roots(a, b, c, k, x1, x2, text)
    REAL(KIND=real_kind), INTENT(IN) :: a, b, c
    INTEGER, INTENT(OUT) :: k
    COMPLEX(KIND=real_kind), INTENT(OUT) :: x1, x2
    CHARACTER(len=50), INTENT(OUT) :: text
    REAL(KIND=real_kind) :: D

    IF (a == 0) THEN
       IF (b == 0) THEN
          IF (c == 0) THEN
             k = 3
             text = "Die Funktion verlaeuft auf der x-Achse"

             RETURN
          END IF
          k = 0
          text = "Die FUnktion verlaeuft parallel zur x-Achse"

          RETURN
       END IF
       x1 = cmplx(-b / c, 0)
       k = 1
       text = "Die Lineare Funktion schneidet die x-Achse"

       RETURN
    END IF

    D = b**2 - 4 * a * c
    IF (D == 0) THEN
       k = 1
       text = "Die Funktion hat eine doppelte reelle Nulstelle"
       x1 = cmplx(- b / (2 * a), 0)
       RETURN
    END IF
    k = 2

    IF (D > 0) THEN
       x1 = cmplx((-b + SQRT(D)) / (2 * a), 0)
       x2 = cmplx((-b - SQRT(D)) / (2 * a), 0)
       text = "Die Funktion hat zwei reelle Nullstellen"

       RETURN
    END IF

    !! D < 0
    x1 = cmplx(- b / (2 * a), SQRT(-D) / (2 * a))
    x2 = cmplx(- b / (2 * a), -1 * SQRT(-D) / (2 * a))
    text = "Die FUnktion hat 2 konjugiert komplexe Nullstellen"
  END SUBROUTINE roots
END MODULE mod_roots

PROGRAM Aufgabe01
  USE mod_roots
  IMPLICIT NONE

  REAL(KIND=real_kind) :: a, b, c
  INTEGER :: k
  COMPLEX(KIND=real_kind) :: x1, x2
  CHARACTER(len=50) :: text

  WRITE(*,*) "a * x ** 2 + b * x + c"
  WRITE(*,*) "Wer fuer a ?"
  READ(*,*) a
  WRITE(*,*) "Wer fuer b ?"
  READ(*,*) b
  WRITE(*,*) "Wer fuer c ?"
  READ(*,*) c

  CALL roots(a, b, c, k, x1, x2, text)

  IF (k == 0) THEN
     WRITE(*,*) "Anzahl Nullstellen : keine"
  ELSE IF (k == 1) THEN
     WRITE(*,*) "Anzahl Nullstellen : 1"
     WRITE(*,*) "x1 : ", REAL(x1)
  ELSE IF (k == 2) THEN
     WRITE(*,*) "Anzahl Nullstellen : 2"
     IF (AIMAG(x1) .ne. 0 .or. AIMAG(x2) .ne. 0) THEN
        WRITE(*,*) "x1 : ", x1
        WRITE(*,*) "x2 : ", x2
     ELSE
        WRITE(*,*) "x1 : ", REAL(x1)
        WRITE(*,*) "x2 : ", REAL(x2)
     END IF
  ELSE IF (k == 3) THEN
     WRITE(*,*) "Anzahl Nullstellen : unendlich"
  END IF

  WRITE(*,*) text

END PROGRAM Aufgabe01
