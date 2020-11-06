PROGRAM Potenz_c
  IMPLICIT NONE
  INTEGER :: i, imax, pot

  WRITE(*,*) "Anzahl Potenzen"
  READ(*,*) imax

  pot = 1
  DO i = 1, imax
     IF (i > 30) THEN
        WRITE(*,*) "Groessere Potenzen koennen &
             &mit dem Datentyp nicht mehr abgebildet werden"
        EXIT
     END IF
     pot = pot * 2
     WRITE(*,*) pot
  END DO
END PROGRAM Potenz_c
