PROGRAM loop01
  IMPLICIT NONE
  INTEGER :: i, imax

  WRITE(*,*) "Max i"
  READ(*,*) imax

  DO i = 1, imax
     WRITE(*,*) 2**i
  END DO
END PROGRAM Loop01
