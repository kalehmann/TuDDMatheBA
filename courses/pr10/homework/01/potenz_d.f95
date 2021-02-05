!! Albina Oscherowa (4694823)
!! Karsten Lehmann (4935758)
PROGRAM Potenz_d
  !! In diesem Beispiel wurde das Programm aus c) um einen ganzzahligen
  !! Datentyp mit 64 Bit erweitert. Somit können die Zweierpotenzen bis
  !! 2 ∗ ∗62 ausgegeben werden.
  IMPLICIT NONE
  INTEGER(kind=8) :: i, imax, pot

  WRITE(*,*) "Anzahl Potenzen"
  READ(*,*) imax

  pot = 1
  DO i = 1, imax
     IF (i > 62) THEN
        WRITE(*,*) "Groessere Potenzen koennen &
             &mit dem Datentyp nicht mehr abgebildet werden"
        EXIT
     END IF
     pot = pot * 2
     WRITE(*,*) pot
  END DO
END PROGRAM Potenz_d
