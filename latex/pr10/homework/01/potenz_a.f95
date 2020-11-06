!! Albina Oscherowa (4694823)
!! Karsten Lehmann (4935758)
PROGRAM Potenz_a
  !! Dieses Programm gibt eine bestimmte Anzahl an Zweierpotenzen aus. Ab
  !! einer Eingabe von 31 werden die letzten Potenzen Fehlerhaft ausgegeben.
  !! Für 2 31 wird anstatt 2147483648 der Wert −2147483648 ausgegeben. Für
  !! alle weiteren Potenzen wird 0 ausgegeben.
  IMPLICIT NONE
  INTEGER :: i, imax

  WRITE(*,*) "Anzahl Potenzen"
  READ(*,*) imax

  DO i = 1, imax
     WRITE(*,*) 2**i
  END DO
END PROGRAM Potenz_a
