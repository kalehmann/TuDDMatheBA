!! Albina Oscherowa
!! Karsten Lehmann

!! Dieses Programm errechnet Zahlen aus der Fibonacci-Folge mit zwei unterschiedlichen
!! Methoden, einmal rekursiv und einmal iterativ.

!! Ab einer Eingabe von 93 tritt dabei ein Ueberlauf auf.
!!
!! Um auch für einen groesseren Index eine Ausgabe zu erhalten, kann man den Code zur
!! Verwendung von Gleitkommazahlen auskommentieren, dann tritt der Ueberlauf ab der Eingabe
!! 1477 auf.
!!
!! Bei der rekursiven Methode ruft sich die Funktion zur Berechnung der Zahl bei jedem
!! Aufruf zweimal selbst auf (bis die Abruchbedingung erreicht ist).
!! Die Komplexität steigt somit exponentiell an, damit auch die benoetigte Zeit.
!! Bei der iterativen Methode steigt die benoetigte Zeit mit dem Index lienar an.
PROGRAM fibonacci
  IMPLICIT NONE

  INTEGER :: i
  INTEGER(kind=8) :: fibo_i, fibo_r
  !!INTEGER, PARAMETER :: real_kind = SELECTED_REAL_KIND(P=15, R=307)
  !!REAL(kind=real_kind) :: fibo_i, fibo_r

  DO
     WRITE(*,*) "Die wie-vielte Fibonaccizahl ist gesucht ? "
     READ(*,*) i

     IF (i < 0) THEN
        EXIT
     END IF

     fibo_i = fibo_iterativ(i)
     fibo_r = fibo_rekursiv(i)

     WRITE(*,*) "Die Fibonacci-Zahl ist iterativ berechnet ", fibo_i
     WRITE(*,*) "Die Fibonacci-Zahl ist rekursiv berechnet ", fibo_r
  END DO
     
CONTAINS
  FUNCTION fibo_iterativ(max_i) RESULT (f)  
    INTEGER, intent(in) :: max_i
    INTEGER :: i
    INTEGER(kind=8) :: f, f1, f2
    !!REAL(kind=real_kind) :: f, f1, f2
    
    f2 = 0
    f1 = 1
    
    IF (max_i == 0) THEN
       f1 = 0
    END IF

    DO i = 2, max_i
       f = f1
       f1 = f1 + f2
       f2 = f
       IF (f1 < f .or. f1 < f2) THEN
          WRITE(*,*) "Fehler, Überlauf!!, index ", i
          
          STOP 1
       END IF
    END DO
    
    f = f1
  END FUNCTION fibo_iterativ

  RECURSIVE FUNCTION fibo_rekursiv(i) RESULT (f)
    INTEGER, intent(in) :: i
    INTEGER(kind=8) :: f
    !!REAL(kind=real_kind) :: f

    IF (i == 0) THEN
       f = 0
    ELSE IF (i == 1) THEN
       f = 1
    ELSE 
       f = fibo_rekursiv(i - 1) + fibo_rekursiv(i - 2)
    END IF
    IF (f < 0) THEN
       WRITE(*,*) "Fehler, Überlauf!!, index ", i
          
       STOP 1
    END IF
  END FUNCTION fibo_rekursiv
END PROGRAM fibonacci
