!! Karsten Lehmann (4935758)
PROGRAM aufgabe1
  USE IVALMOD
  IMPLICIT NONE
  REAL(kind=pr) :: a, b, eps
  TYPE(interval) :: res

  INTERFACE
     FUNCTION ifun(x) RESULT(y)
       IMPORT :: interval
       TYPE(interval), INTENT(IN) :: x
       TYPE(interval) :: y
     END FUNCTION ifun
  END INTERFACE

  WRITE(*,*) "Untere Grenze a? :"
  READ(*,*) a
  WRITE(*,*) "Obere Grenze b? :"
  READ(*,*) b
  WRITE(*,*) "Fehlertoleranz e? :"
  READ(*,*) eps

  res = trapez(f, d2f, a, b, eps)

  WRITE(*,*) "Lsg.: Interval von ", INF(res), " bis ", SUP(res)

CONTAINS
  TYPE(interval) FUNCTION f(x)
    TYPE(interval), INTENT(IN) :: x
    REAL(kind=pr) :: a, b, c, d
    a = 7
    b = 5
    c = 2
    d = 4

    f = x * x * x * x + IVAL(a) * x * x * x - IVAL(b) * x * x + IVAL(c) * x - IVAL(d)
  END FUNCTION f

  TYPE(interval) FUNCTION d2f(x)
    TYPE(interval), INTENT(IN) :: x
    REAL(kind=pr) :: a, b, c
    a = 12
    b = 42
    c = 10

    d2f = IVAL(a) * x * x + IVAL(b) * x - IVAL(c)
  END FUNCTION d2f

  RECURSIVE FUNCTION trapez(g, d2g, a, b, eps) RESULT (trap)
    REAL(kind=pr), INTENT(IN) :: a, b, eps
    TYPE(interval) :: trap
    PROCEDURE(ifun) :: g, d2g

    TYPE(interval) :: x, quaderr
    REAL(kind=pr) :: diam

    x = IVAL(a, b)
    quaderr = d2g(x)
    diam = SUP(quaderr) - INF(quaderr)
    IF (diam < eps) THEN
       trap = quaderr + IVAL(diam / 2) * (g(IVAL(a)) + g(IVAL(b)))
       RETURN
    END IF

    trap = trapez(g, d2g, a, (a+b)/2, eps/2) + trapez(g, d2g, (a+b)/2, b, eps/2)
  END FUNCTION trapez
END PROGRAM aufgabe1
