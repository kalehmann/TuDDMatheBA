PROGRAM Potenz_a
  IMPLICIT NONE
  INTEGER :: i, imax

  WRITE(*,*) "Anzahl Potenzen"
  READ(*,*) imax

  DO i = 1, imax
     WRITE(*,*) 2**i
  END DO
END PROGRAM Potenz_a
