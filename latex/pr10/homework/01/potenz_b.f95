PROGRAM Potenz_b
  IMPLICIT NONE
  INTEGER :: i, imax

  WRITE(*,*) "Anzahl Potenzen"
  READ(*,*) imax

  DO i = 1, imax
     IF (i > 30) THEN
        WRITE(*,*) "Groessere Potenzen koennen &
             &mit dem Datentyp nicht mehr abgebildet werden"
        EXIT
     END IF
     WRITE(*,*) 2**i
  END DO
END PROGRAM Potenz_b
