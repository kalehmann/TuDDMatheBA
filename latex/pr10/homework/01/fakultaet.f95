PROGRAM fakultaet
  IMPLICIT NONE
  INTEGER :: i, n, res

  WRITE(*,*) "Fakultaet von"
  READ(*,*) n

  res = 1
  DO i = 1, n
     res = res * i
  END DO
  WRITE(*,*) res
END PROGRAM fakultaet
