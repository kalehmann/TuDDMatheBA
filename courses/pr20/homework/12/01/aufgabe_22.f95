PROGRAM aufgabe_22
  USE mod_matmul

  IMPLICIT NONE

  INTEGER :: k
  REAL, DIMENSION(:,:), ALLOCATABLE :: A, B, C
  REAL :: start, end, t1, t2, t3
  WRITE(*,*) "k ?"
  READ(*,*) k

  ALLOCATE(A(2**k,2**k))
  ALLOCATE(B(2**k,2**k))
  ALLOCATE(C(2**k,2**k))

  CALL get_mat(A)
  CALL get_mat(B)

  WRITE(*,*) "First matrix is"
  CALL print_mat(A)
  WRITE(*,*) "Second matrix is"
  CALL print_mat(B)

  WRITE(*,*) ""
  WRITE(*,*) "Multiplication using builtin matmul function"
  CALL CPU_TIME(start)
  C = MATMUL(A, B)
  CALL CPU_TIME(end)
  CALL print_mat(C)
  t1 = end - start

  WRITE(*,*) ""
  WRITE(*,*) "Multiplication using simple_matmul function"
  CALL CPU_TIME(start)
  C = simple_matmul(A, B)
  CALL CPU_TIME(end)
  CALL print_mat(C)
  t2 = end - start

  WRITE(*,*) ""
  WRITE(*,*) "Multiplication using strassen_matmul function"
  CALL CPU_TIME(start)
  C = strassen_matmul(A, B)
  CALL CPU_TIME(end)
  CALL print_mat(C)
  t3 = end - start

  WRITE(*,'("Time elapsed for matmul: ",f10.7," seconds")') t1
  WRITE(*,'("Time elapsed for simple_matmul: ",f10.7," seconds")') t2
  WRITE(*,'("Time elapsed for strassen_matmul: ",f10.7," seconds")') t3

  DEALLOCATE(A)
  DEALLOCATE(B)
  DEALLOCATE(C)
CONTAINS
  SUBROUTINE get_mat(A)
    REAL, DIMENSION(:,:), INTENT(OUT) :: A
    INTEGER :: i
    CHARACTER(LEN=255) :: fpath

    WRITE(*,*) "Read matrix from file (leave blank for Hilbert-Mattrix) ?"
    READ(*,'(A)') fpath
    IF (LEN_TRIM(fpath) == 0) THEN
       CALL hilbert_mat(A)
    ELSE
       OPEN(UNIT=42, FILE=fpath)
       DO i = 1, SIZE(A, DIM=1)
          READ(42,*) A(i,:)
       END DO
       CLOSE(42)
    END IF
  END SUBROUTINE get_mat

  SUBROUTINE hilbert_mat(A)
    REAL, DIMENSION(:,:), INTENT(OUT) :: A
    INTEGER :: i, j

    DO i = 1, SIZE(A, DIM=1)
       DO j = 1, SIZE(A, DIM=2)
          A(i, j) = 1.0 / (i + j - 1)
       END DO
    END DO
  END SUBROUTINE hilbert_mat

  SUBROUTINE print_mat(A)
    REAL, DIMENSION(:,:), INTENT(IN) :: A
    INTEGER :: i, j

    IF (SIZE(A, DIM=1) > 4) THEN
       WRITE(*,*) "Do not print large matrix"
       RETURN
    END IF

    DO i = 1, SIZE(A, DIM=1)
       IF (i == 1) THEN
          WRITE(*,'(A)', ADVANCE='NO') '╭'
       ELSE IF (i == SIZE(A, DIM=1)) THEN
          WRITE(*,'(A)', ADVANCE='NO') '╰'
       ELSE
          WRITE(*,'(A)', ADVANCE='NO') '│'
       END IF
       DO j = 1, SIZE(A, DIM=2)
          WRITE(*,'(F10.4)', ADVANCE='no') A(i, j)
       END DO
       IF (i == 1) THEN
          WRITE(*,*) '╮'
       ELSE IF (i == SIZE(A, DIM=1)) THEN
          WRITE(*,*) '╯'
       ELSE
          WRITE(*,*) '│'
       END IF
    END DO
  END SUBROUTINE print_mat
END PROGRAM aufgabe_22
