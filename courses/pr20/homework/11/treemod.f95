MODULE treemod
  USE stringmod
  IMPLICIT NONE

  PUBLIC buildtree, printtree
  
  TYPE tree
     TYPE(tree), ALLOCATABLE :: left, right
     CHARACTER(LEN=1) :: operator
     CHARACTER(LEN=10) :: operand
  END type tree
CONTAINS
  LOGICAL FUNCTION islowerletter(c)
    CHARACTER(LEN=1), INTENT(IN) :: c
    islowerletter = 'a' <= c .AND. c <= 'z'
  END FUNCTION ISLOWERLETTER
  
  LOGICAL FUNCTION isnumber(c)
    CHARACTER(LEN=1), INTENT(IN) :: c
    isnumber = '0' <= c .AND. c <= '9'
  END FUNCTION isnumber

  RECURSIVE SUBROUTINE buildtree(t, sub)
    TYPE(tree), INTENT(OUT) :: t
    LOGICAL, INTENT(IN), OPTIONAL :: sub
    CHARACTER(LEN=1) :: c
    INTEGER(KIND=1) :: i
    ALLOCATE(t%left)
    ALLOCATE(t%right)
    
    c = ' '
    DO WHILE(c == ' ')
       CALL getnextchar(c)
    END DO
    IF (.NOT. PRESENT(sub) .AND. c .EQ. '(') THEN
       !! Ignore first bracket
       CALL getnextchar(c)
    END IF
    IF (c .eq. '(') THEN
       CALL buildtree(t%left, .TRUE.)
       t%left%operand = ' '
       CALL getnextchar(c)
    ELSE
       i = 1
       t%left%operand = ' '
       DO WHILE(isnumber(c) .OR. islowerletter(c))
          t%left%operand(i:i) = c
          CALL getnextchar(c)
          i = i + 1
       END DO
    END IF
    DO WHILE(c .eq. ' ')
       CALL getnextchar(c)
    END DO
    t%operator = c
    CALL getnextchar(c)
    DO WHILE(c == ' ')
       CALL getnextchar(c)
    END DO
    IF (c .eq. '(') THEN
       CALL buildtree(t%right, .TRUE.)
       t%right%operand = ' '
    ELSE
       i = 1
       t%right%operand = ' '
       DO WHILE(isnumber(c) .OR. islowerletter(c))
          t%right%operand(i:i) = c
          CALL getnextchar(c)
          i = i + 1
       END DO
    END IF
  END SUBROUTINE buildtree
  
  RECURSIVE SUBROUTINE printtree(t, sub)
    TYPE(tree), INTENT(IN) :: t
    LOGICAL, INTENT(IN), OPTIONAL :: sub
    WRITE(*,'(A)',ADVANCE='NO') '('
    IF (LEN_TRIM(t%left%operand) == 0) THEN
       CALL printtree(t%left, .TRUE.)
    ELSE
       WRITE(*,'(A)',ADVANCE='NO') TRIM(t%left%operand)
    END IF
    WRITE(*,'(A)',ADVANCE='NO') TRIM(t%operator)
    IF (t%right%operand == '') THEN
       CALL printtree(t%right, .TRUE.)
    ELSE
       WRITE(*,'(A)',ADVANCE='NO') TRIM(t%right%operand)
    END IF
    IF (PRESENT(sub)) THEN
       WRITE(*,'(A)',ADVANCE='NO') ')'
    ELSE
       WRITE(*,'(A)') ')'
    END IF
  END SUBROUTINE printtree
END MODULE treemod
