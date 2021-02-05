!! Albina Oscherowa (4694823)
!! Karsten Lehmann (4935758)
PROGRAM bauzins
  IMPLICIT NONE
  REAL :: kredithoehe, laufzeit, rate, restschuld, zinsen, &
       zinssatz, zinssumme
  WRITE (*,*) "Kredithoehe ?"
  READ (*,*) kredithoehe
  WRITE (*,*) "Zinssatz ?"
  READ (*,*) zinssatz

  zinsen = kredithoehe * zinssatz / 100
  
  DO
     WRITE (*,*) "Rate ?"
     READ (*,*) rate

     IF (rate > zinsen) THEN
        EXIT
     END IF
     WRITE (*,*) "Fehler: Die Rate muss groesser als ", &
          zinsen, " sein"
  END DO
  laufzeit = 0
  zinssumme = 0
  restschuld = kredithoehe

  DO WHILE (restschuld > 0)
     laufzeit = laufzeit + 1
     zinsen = restschuld * zinssatz / 100
     restschuld = restschuld + zinsen - rate
     zinssumme = zinssumme + zinsen
  END DO

  IF (restschuld < 0) THEN
     rate = rate + restschuld
     WRITE(*,*) "Letzte Rate :", rate
  END IF

  WRITE(*,*) "Laufzeit: ", laufzeit, " Zinssumme: ", &
       zinssumme
END PROGRAM bauzins
