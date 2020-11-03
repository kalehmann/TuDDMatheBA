PROGRAM taschenrechner
  IMPLICIT NONE

  INTEGER :: a, b, ergebnis
  
  READ (*,*) a, b
  ergebnis = a + b
  WRITE(*,*) " a + b = ", ergebnis
END PROGRAM taschenrechner
