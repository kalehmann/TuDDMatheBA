!! Albina Oscherowa (4694823)
!! Karsten Lehmann (4935758)
PROGRAM Potenz_b
  !! Das Programm aus a) erweitert, um anstatt der fehlerhaften Potenzen
  !! auszugeben mit einer Fehlermeldung abzubrechen.
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
