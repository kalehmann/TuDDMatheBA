!! Albina Oscherowa
!! Karsten Lehmann

!! Dieses Programm berechynet die Kreiszahl Pi nach dem Verfahren von Archimedes.
!! Das Ergebnis des Programms ist dabei auf 32 Stellen nach dem Komma genau.
!! Relativ zur Genauigkeit des verwendeten Datentypes (es werden 35 Stellen nach dem
!! Komma ausgeben) ist das Ergbenis akzeptabel.

!! Das Programm bildet insgesamt 55 Intervalle bis zum Abruch. Auf das Ergebnis gesehen sind
!! dies weniger als 2 Intervalle pro Nachkommastelle.

!! Die 35 von Ludolph van Ceulen mit Hand berechneten Nachkommastellen von Pi koennen mit
!! dem Programm nicht bestaetigt werden. Wo Ludolph am Ende auf 950288 kommt, gibt dieses
!! Programm 950434 aus.
PROGRAM kreis
  IMPLICIT NONE

  INTEGER :: n
  INTEGER, PARAMETER :: real_kind= SELECTED_REAL_KIND(P=33, R=4931)
  REAL(KIND=real_kind) :: i, a
  
  n = 0
  i = 3
  a = 2 * sqrt(i)

  DO
     a = harm(i, a)
     i = geom(i, a)

     WRITE(*,*) n, ": Interval von ", i, " bis ", a
     n = n + 1
     IF (a - i <= SPACING(i)) THEN
        WRITE(*,*) "PI = ", i
        EXIT
     END IF
  END DO

CONTAINS
  FUNCTION geom(a, b) RESULT (c)
    INTEGER, PARAMETER :: real_kind= SELECTED_REAL_KIND(P=33, R=4931)
    REAL(KIND=real_kind), INTENT(IN) :: a, b
    REAL(KIND=real_kind) :: c
    c = SQRT(a * b)
  END FUNCTION geom
  
  FUNCTION harm(a, b) RESULT (c)
    INTEGER, PARAMETER :: real_kind= SELECTED_REAL_KIND(P=33, R=4931)
    REAL(KIND=real_kind), INTENT(IN) :: a, b
    REAL(KIND=real_kind) :: c
    c = 2  / (1/a + 1/b)
  END FUNCTION harm
END PROGRAM kreis
