PROGRAM loop03
  IMPLICIT NONE
  INTEGER :: i, imax, pot

  WRITE(*,*) "Max i"
  READ(*,*) imax

  pot = 1
  DO i = 1, imax
     pot = pot * 2
     WRITE(*,*) pot
     IF (i > 29) THEN
        WRITE(*,*) "Groessere Potenzen koennen mit dem Datentyp nicht mehr abgebildet werden"  
        EXIT
     END IF
  END DO
END PROGRAM Loop03
