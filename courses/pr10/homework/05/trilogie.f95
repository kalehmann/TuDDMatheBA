!! Albina Oscherowa
!! Karsten Lehmann

!! Implementierung einer dreiwertigen Logik mit einem neuen Typen trilog.
!! Die Implementierung wird mit allen Kombinationen von A, B und C fuer
!!  - A und (B oder C) = (A und B) oder (A und C)
!!  - A oder (B und C) = (A oder B) und (A oder C)
!! sowie
!!  - nicht (A und B) = (nicht A) oder (nicht B)
!!  - nicht (A oder B) = (nicht A) und (nicht B)
!! gestestet und haelt dieser Testung stand.
MODULE trilogie
  IMPLICIT NONE

  PRIVATE

  PUBLIC trilog, OPERATOR(.AND.), OPERATOR(.OR.), &
       & OPERATOR(.NOT.), text, true, false, maybe

  CHARACTER, PARAMETER :: TEXT_TRILOG(-1:1) = (/ 'F', '?', 'T' /)
  
  TYPE trilog
     PRIVATE
     INTEGER :: n
  END type trilog
  
  TYPE(trilog), PARAMETER :: false = trilog(-1),  &
       &                     true = trilog(1),    &
       &                     maybe = trilog(0)

  INTERFACE trilog
     MODULE PROCEDURE trilog_new
  END INTERFACE trilog
  
  INTERFACE OPERATOR (.AND.)
     MODULE PROCEDURE trilog_and
  END INTERFACE OPERATOR (.AND.)

  INTERFACE OPERATOR (.OR.)
     MODULE PROCEDURE trilog_or
  END INTERFACE OPERATOR (.OR.)

  INTERFACE OPERATOR (.NOT.)
     MODULE PROCEDURE trilog_not
  END INTERFACE OPERATOR (.NOT.)

  INTERFACE OPERATOR (==)
     MODULE PROCEDURE trilog_eq
  END INTERFACE OPERATOR (==)

CONTAINS
  TYPE(trilog) FUNCTION trilog_new(n)
    INTEGER, INTENT(IN) :: n
    IF (0 == n) THEN
       trilog_new%n = 0
    ELSE
       trilog_new%n = SIGN(1, n)
    END IF
  END FUNCTION trilog_new
  
  TYPE(trilog) FUNCTION trilog_and(a, b)
    TYPE(trilog), INTENT(IN) :: a, b
    trilog_and = trilog(MIN(a%n, b%n))
  END FUNCTION trilog_and

  TYPE(trilog) FUNCTION trilog_or(a, b)
    TYPE(trilog), INTENT(IN) :: a, b
    trilog_or = trilog(MAX(a%n, b%n))
  END FUNCTION trilog_or

  TYPE(trilog) FUNCTION trilog_not(a)
    TYPE(trilog), INTENT(IN) :: a
    trilog_not = trilog(a%n * (-1))
  END FUNCTION trilog_not

  LOGICAL FUNCTION trilog_eq(a, b)
    TYPE(trilog), INTENT(IN) :: a, b
    trilog_eq = a%n == b%n
  END FUNCTION trilog_eq

  CHARACTER FUNCTION text(a)
    TYPE(trilog), INTENT(IN) :: a
    text = TEXT_TRILOG(a%n)
  END FUNCTION text
END MODULE trilogie

PROGRAM trilog_test
  USE trilogie
  IMPLICIT NONE

  INTEGER :: a, b, c
  TYPE(trilog), DIMENSION(3), PARAMETER :: v = (/ false, maybe, true /)

  WRITE(*,*) " A | nicht A"
  WRITE(*,*) "------------"
  DO a = 1, 3
     WRITE(*,*) " ", text(v(a)), " | ", text(.NOT. v(a))
  END DO
  WRITE(*,*) ""
  
  WRITE(*,*) " A | B | A und B | A oder B" 
  WRITE(*,*) "---------------------------" 
  DO a = 1, 3
     DO b = 1, 3
        WRITE(*,*) " ", text(v(a)), " | ", text(v(b)), " | ", text(v(a) .AND. v(b)), &
             & "       | ", text(v(a) .OR. v(b))
     END DO
  END DO
  WRITE(*,*) ""
  
  WRITE(*,*) " A | B | C | A und (B oder C) | (A und B) oder (A und C) | A oder (B und C) | (A oder B) und (A oder C)"
  WRITE(*,*) "-------------------------------------------------------------------------------------------------------"
  DO a = 1, 3
     DO b = 1, 3
        DO c = 1, 3
           WRITE(*,*) " ", text(v(a)), " | ", text(v(b)), " | ", &
                & text(v(c)), " | ", text(v(a) .AND. (v(b) .OR. v(c))), &
                & "                | ", &
                & text((v(a) .AND. v(b)) .OR. (v(a) .AND. v(c))), &
                & "                        | ", &
                & text(v(a) .OR. (v(b) .AND. v(c))), &
                & "                | ", &
                & text((v(a) .OR. v(b)) .AND. (v(a) .OR. v(c)))
        END DO
     END DO
  END DO

  WRITE(*,*) ""
  WRITE(*,*) " A | B | nicht (A und B) | (nicht A) und (nicht B) | nicht (A oder B) | (nicht A) und (nicht B)"
  WRITE(*,*) "-----------------------------------------------------------------------------------------------"  
  DO a = 1, 3
     DO b = 1, 3
        WRITE(*,*) " ", text(v(a)), " | ", text(v(b)), &
             & " | ", text(.NOT. (v(a) .AND. v(b)) ), &
             & "               | ", &
             & text( (.NOT. v(a)) .OR. (.NOT. v(b)) ), &
             & "                       | ", &
             & text(.NOT. (v(a) .OR. v(b))), &
             & "                | ", &
             & text(.NOT. v(a) .AND. .NOT. v(b))
     END DO
  END DO  
END PROGRAM trilog_test
