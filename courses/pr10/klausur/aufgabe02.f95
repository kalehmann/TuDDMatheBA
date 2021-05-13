!! Karsten Lehmann (4935758)

MODULE mod_kreisinterval
  IMPLICIT NONE

  INTEGER, PARAMETER :: real_kind = SELECTED_REAL_KIND(P=10, R=100)

  TYPE kreisinterval
     COMPLEX(KIND=real_kind) :: m
     REAL(KIND=real_kind) :: r
  END type kreisinterval

  TYPE(kreisinterval), PARAMETER :: zero = kreisinterval(m=cmplx(0, 0), r=0)

  INTERFACE OPERATOR(*)
     MODULE PROCEDURE ki_mul
  END INTERFACE OPERATOR(*)

  INTERFACE OPERATOR(.subset.)
     MODULE PROCEDURE ki_subset
  END INTERFACE OPERATOR(.subset.)
CONTAINS
  TYPE(kreisinterval) FUNCTION ki_mul(k1, k2)
    TYPE(kreisinterval), INTENT(IN) :: k1, k2
    ki_mul%m = k1%m * k2%m
    ki_mul%r = ABS(k1%m) * k2%r + ABS(k2%m) * k1%r + k1%r * k2%r
  END FUNCTION ki_mul

  LOGICAL FUNCTION ki_subset(k1, k2)
    TYPE(kreisinterval), INTENT(IN) :: k1, k2
    ki_subset = ABS(k2%m - k1%m) .LE. k2%r - k1%r
  END FUNCTION Ki_Subset
END MODULE mod_kreisinterval

PROGRAM Aufgabe02
  USE mod_kreisinterval
  IMPLICIT NONE

  TYPE(kreisinterval), DIMENSION(5) :: Z
  INTEGER :: n
  REAL(KIND=real_kind) :: r, i
  LOGICAL :: invalid

  DO n = 1, 3
     invalid = .true.
     DO WHILE (invalid)
        WRITE(*,*) "Eingabe Kreisinterval", n
        WRITE(*,*) "Mittelpunkt? (Real-Teil, Imaginaer_Teil)"
        READ(*,*) r, i
        Z(n)%m = cmplx(r, i,KIND=real_kind)
        WRITE(*,*) "Radius?"
        READ(*,*) Z(n)%r
        IF ((.NOT. (Z(n) .subset. zero)) .AND. (Z(n)%r .GT. 0)) THEN
           invalid = .false.
           CYCLE
        END IF
        IF (Z(n) .subset. zero) THEN
           WRITE(*,*) "Fehler, das eingegebene Intervall entspricht dem Nullintervall"
           CYCLE
        END IF
        IF ( Z(n)%r .LT. 0) THEN
           WRITE(*,*) "Fehler, der eingegebene Radius ist negativ"
        END IF
     END DO
  END DO

  Z(4) = (Z(1) * Z(2)) * Z(3)
  Z(5) = Z(1) * (Z(2) * Z(3))

  WRITE(*,*) "Z4 = (Z1 * Z2) * Z3"
  WRITE(*,*) "Mittelpunkt : ", Z(4)%m, " Radius : ", Z(4)%r
  WRITE(*,*) "Z5 = Z1 * (Z2 * Z3)"
  WRITE(*,*) "Mittelpunkt : ", Z(5)%m, " Radius : ", Z(5)%r

  WRITE(*,*) "Ist Z4 eine Teilmenge von Z5 ? ", Z(4) .subset. Z(5)
  WRITE(*,*) "Ist Z5 eine Teilmenge von Z4 ? ", Z(5) .subset. Z(4)
END PROGRAM Aufgabe02
