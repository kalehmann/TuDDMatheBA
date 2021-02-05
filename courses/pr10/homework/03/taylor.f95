!! Albina Oscherowa
!! Karsten Lehmann

!! Dieses Programm berechnet e^x einmal mit der Taylor Methode
!! und einmal mit der EXP Funktion.
!! Anschliessend werden die Werte und deren Differenzen ausgegeben.
!! Dabei wird ersichtlich, dass die absoluten Differenzen fuer
!! negative Werte von x groesser als fuer positive Werte von x sind.
!! Relativ zu EXP(x) bleibt die Absolute Differenz bei positiven
!! Werten von x allerdings fast konstant, waehrend sie bei negativen
!! Werten von x bei kleinerem x sehr stark ansteigt.

PROGRAM taylor
  IMPLICIT NONE
  INTEGER, PARAMETER :: real_kind = SELECTED_REAL_KIND(P=15, R=307)
  REAL(kind=real_kind) :: sum, summand, x
  INTEGER :: i, k, n

  WRITE(*,*) "Ausgabe der Differenz von e^x zwischen der Taylor-&
       &Methode und der EXP Funktion fuer verschiedene Werte von x."
  
  DO n = -1, 1, 2
     DO  k = 1, 10
        x = n * 10 * k
        !! Die ersten beiden Summanden werden direkt zusammengefasst.
        sum = 1 + x
        i = 2
        summand = x
        DO
           summand = summand * x / i
           i = i + 1
           IF (sum == sum + summand) THEN
              EXIT
           END IF
           sum = sum + summand
        END DO
        WRITE(*,*) "x =", n * 10 * k, "|EXP - Taylor| = |", EXP(x), &
             " - ", sum , "| =", ABS(EXP(x) - sum), "Differenz relativ &
             &zu EXP(x) = ", ABS(EXP(x) - sum) / EXP(x) 
     END DO
  END DO
END PROGRAM taylor
