!! Albina Oscherowa (4694823)
!! Karsten Lehmann (4935758)
PROGRAM fakultaet
  !!  In diesem Programm wird anstatt Zweierpotenzen die Falkultät einer Zahl
  !! berechnet. Diese Programm leidet unter dem selben Problem wie das
  !! Programm a), die Fakultät wird mit −2147483648 falsch ausgegeben.
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
