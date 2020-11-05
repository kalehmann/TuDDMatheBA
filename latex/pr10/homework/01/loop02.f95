PROGRAM loop02
  IMPLICIT NONE
  INTEGER :: i, imax

  WRITE(*,*) "Max i"
  READ(*,*) imax

  DO i = 1, imax
     WRITE(*,*) 2**i
     IF (i > 29) THEN
        WRITE(*,*) "Groessere Potenzen koennen &
             &mit dem Datentyp nicht mehr abgebildet werden"
        
        EXIT
     END IF
  END DO
END PROGRAM Loop02
