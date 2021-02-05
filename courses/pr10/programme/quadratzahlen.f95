!! Sucht für die Zahlen von 1 bis 100 alle moeglichen, diese aus 4 Quadratzahlen
!! zusammen zu setzen.
PROGRAM quadzahlen
  IMPLICIT NONE
  INTEGER :: i

  DO i=1, 100
     CALL VIERQUADRATE(i)
  END DO

CONTAINS
  SUBROUTINE VIERQUADRATE(x)
    INTEGER :: i,j,k,l,x
    DO i=1,10
       IF (x == i ** 2) THEN
         WRITE(*,*) x, " = ", i**2
       END IF
       DO j=1,10
          IF (x == i ** 2 + j ** 2) THEN
             WRITE(*,*) x, " = ", i**2, " + ", j**2
          END IF
          DO k=1,10
             IF (x == i ** 2 + j ** 2 + k ** 2) THEN
                WRITE(*,*) x, " = ", i**2, " + ", j**2, " + ", k**2
             END IF
             DO l=1,10
                IF (x == i ** 2 + j ** 2 + k ** 2 + l ** 2) THEN
                   WRITE(*,*) x, " = ", i**2, " + ", j**2, " + ", k**2, " + ", l**2
                END IF
             END DO
          END DO
       END DO
    END DO
  END SUBROUTINE VIERQUADRATE
END PROGRAM quadzahlen
