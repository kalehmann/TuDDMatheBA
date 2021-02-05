!! Albina Oscherowa (4694823)
!! Karsten Lehmann (4935758)
PROGRAM zyklus
  IMPLICIT NONE
  INTEGER :: n, max, min, sum, avg, i, x

  WRITE (*,*) "Dieses Programm gibt das Minimum, das &
       &Maximum, den Durchschnitt"
  WRITE (*,*) "und die Summe einer Endlichen Menge von &
       &ganzen Zahlen aus."
 
  
  DO
     WRITE (*,*) "Maechtigkeit der Menge :"
     READ (*,*) n
     IF (n > 0) THEN
        EXIT
     END IF
  END DO
  
  max = 0
  min = HUGE(min)
  sum = 0
  avg = 0
  i = 0

  DO WHILE (i < n)
     i = i + 1
     WRITE(*,*) "Die ", i, ". Zahl der Menge: "
     READ(*,*) x
     IF (x > max) THEN
        max = x
     END IF
     IF (x < min) THEN
        min = x
     END IF
     sum = sum + x
     avg = sum / i
  END DO

  WRITE(*,*) "Maximum: ", max, " Minimum: ", min, " Summe: ", &
       sum, " Durchschnitt: ", avg
END PROGRAM zyklus
