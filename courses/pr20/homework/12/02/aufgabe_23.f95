!! Albina Oscherowa
!! Karsten Lehmann
PROGRAM aufgabe_23
  IMPLICIT NONE

  INTEGER :: n, s
  LOGICAL, DIMENSION(:,:), ALLOCATABLE :: chessboard

  DO
     WRITE(*,*) "Width of the chess board? (Insert a number < 1 to abort)"
     READ(*,*) n
     IF (n < 1) THEN
        EXIT
     END IF
     ALLOCATE(chessboard(n,n))
     s = 0

     CALL set_queen(chessboard, 1, s)
     WRITE(*,'("Found ",I0," solutions")') s

     DEALLOCATE(chessboard)
  END DO
CONTAINS
  SUBROUTINE print_cb(cb)
    LOGICAL, DIMENSION(:,:), INTENT(IN) :: cb
    INTEGER :: i, j

    WRITE(*,'(A)',ADVANCE='NO') '╭'
    DO j = 1, SIZE(cb, DIM=1) - 1
       WRITE(*,'(A)',ADVANCE='NO') '─┬'
    END DO
    WRITE(*,'(A)') '─╮'
    DO i = 1, SIZE(cb, DIM=1)
       IF (i .ne. 1) THEN
          WRITE(*,'(A)',ADVANCE='NO') '├'
          DO j = 1, SIZE(cb, DIM=1) - 1
             WRITE(*,'(A)',ADVANCE='NO') '─┼'
          END DO
          WRITE(*,'(A)') '─┤'
          WRITE(*,'(A)',ADVANCE='NO') ''
       END IF
       DO j = 1, SIZE(cb, DIM=1)
          WRITE(*,'(A)',ADVANCE='NO') '│'
          IF (cb(i, j)) THEN
             WRITE(*,'(A)',ADVANCE='NO') 'O'
          ELSE
             WRITE(*,'(A)',ADVANCE='NO') ' '
          END IF
       END DO
       WRITE(*,'(A)') '│'
    END DO
    WRITE(*,'(A)',ADVANCE='NO') '╰'
    DO j = 1, SIZE(cb, DIM=1) - 1
       WRITE(*,'(A)',ADVANCE='NO') '─┴'
    END DO
    WRITE(*,'(A)') '─╯'
  END SUBROUTINE print_cb

  LOGICAL FUNCTION is_conflict(cb, row, column)
    LOGICAL, DIMENSION(:,:), INTENT(IN) :: cb
    INTEGER, INTENT(IN) :: row, column
    INTEGER :: i, n
    n = SIZE(cb, DIM=1)
    is_conflict = .FALSE.
    IF (n == 1) THEN
       RETURN
    END IF

    IF (ANY(cb(row,:)) .OR. ANY(cb(:,column))) THEN
       is_conflict = .TRUE.
       RETURN
    END IF

    DO i = 1, row - 1
       IF (column + row - i <= n) THEN
          IF (cb(i, column + row - i)) THEN
             is_conflict = .TRUE.
             RETURN
          END IF
       END IF
       IF (column - row + i >= 1) THEN
          IF (cb(i, column - row + i)) THEN
             is_conflict = .TRUE.
             RETURN
          END IF
       END IF
    END DO
  END FUNCTION is_conflict

  RECURSIVE SUBROUTINE set_queen(cb, row, solutions)
    LOGICAL, DIMENSION(:,:), INTENT(INOUT) :: cb
    INTEGER, INTENT(IN) :: row
    INTEGER, INTENT(INOUT) :: solutions
    INTEGER :: i

    IF (row > SIZE(cb, DIM=1)) THEN
       RETURN
    END IF

    DO i = 1, SIZE(cb, DIM=1)
       IF (.NOT. is_conflict(cb, row, i)) THEN
          cb(row, i) = .TRUE.
          IF (row == SIZE(cb, DIM=1)) THEN
             WRITE(*,*) "Found a solution"
             solutions = solutions + 1
             CALL print_cb(cb)
          ELSE
             CALL set_queen(cb, row + 1, solutions)
          END IF
       END IF
       cb(row, i) = .FALSE.
    END DO
  END SUBROUTINE SET_QUEEN
END PROGRAM aufgabe_23
