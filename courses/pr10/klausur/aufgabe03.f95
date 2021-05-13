!! Karsten Lehmann (4935758)

MODULE mod_gso
  IMPLICIT NONE
  INTEGER, PARAMETER :: real_kind = SELECTED_REAL_KIND(P=10, R=100)
CONTAINS
  FUNCTION y(x) RESULT(res)
    REAL(KIND=real_kind), DIMENSION(:,:), INTENT(IN) :: x
    REAL(KIND=real_kind), ALLOCATABLE, DIMENSION(:,:) :: res

    INTEGER :: i, k, n
    REAL(KIND=real_kind), ALLOCATABLE, DIMENSION(:) :: s
    n = SIZE(x, 1)
    ALLOCATE(res(n,n))
    ALLOCATE(s(n))
    res(1,1:n) = x(1,1:n)
    DO k = 2, n
       s = DOT_PRODUCT(x(k,1:n),res(1,1:n)) / DOT_PRODUCT(res(1,1:n), res(1,1:n)) * res(1,1:n)
       DO i = 2, k - 1
          s = s + DOT_PRODUCT(x(k,1:n),res(i,1:n)) / DOT_PRODUCT(res(i,1:n), res(i,1:n)) * res(i,1:n)
       END DO
       res(k,1:n) = x(k,1:n) - s
       res(k,1:n) = res(k,1:n) / SQRT(res(k,1:n) * res(k,1:n))
    END DO
    DEALLOCATE(s)
  END FUNCTION y
END MODULE mod_gso

PROGRAM Aufgabe03
  USE mod_gso
  IMPLICIT NONE

  INTEGER :: i, j, n
  REAL(KIND=real_kind), ALLOCATABLE, DIMENSION(:,:) :: x, xo

  DO
     WRITE(*,*) "Eingabe Zeilenzahl : "
     READ(*,*) n
     IF (n .LE. 0) THEN
        EXIT
     END IF
     ALLOCATE(x(n, n))
     DO i = 1, n
        WRITE(*,*) "Eingabe der Matrix, Zeile", i
        READ(*,*) x(i,1:n)
     END DO

     xo = y(x)

     DO i = 1, n
        WRITE(*,*) xo(i, 1:n)
     END DO

     DEALLOCATE(x)
     DEALLOCATE(xo)
  END DO

END PROGRAM Aufgabe03
