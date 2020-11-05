PROGRAM loop04
  IMPLICIT NONE
  INTEGER(kind=8) :: i, imax, pot

  WRITE(*,*) "Max i"
  READ(*,*) imax

  pot = 1
  DO i = 1, imax
     pot = pot * 2
     WRITE(*,*) pot
     IF (i > 61) THEN
        WRITE(*,*) "Groessere Potenzen koennen mit dem Datentyp nicht mehr abgebildet werden"  
        EXIT
     END IF
  END DO
END PROGRAM Loop04
