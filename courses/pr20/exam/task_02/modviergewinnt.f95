!! Karsten Lehmann (4935758)
MODULE modviergewinnt
  IMPLICIT NONE
  CHARACTER, PARAMETER :: zeichen(-1:1) = (/ 'O', ' ', 'X' /)

CONTAINS

  SUBROUTINE AUSGABE(spielfeld)
    INTEGER :: m, n, i, j
    INTEGER, DIMENSION(:,:), INTENT(IN) :: spielfeld

    m = SIZE(spielfeld, 2)
    n = SIZE(spielfeld, 1)

    DO i = 1, m
       WRITE(*, "(I2, A)", ADVANCE="no") i, " "
    END DO
    WRITE(*,*) ""
    DO i = 1, 3 * m
       WRITE(*, '(A)', ADVANCE="no") "="
    END DO
    WRITE(*,*) ""
    DO j = n, 1, -1
       DO i = 1, m
          WRITE(*, "(A2, A)", ADVANCE="no") zeichen(spielfeld(j, i)), "|"
       END DO
       WRITE(*,*) ""
    END DO
  END SUBROUTINE AUSGABE

  INTEGER FUNCTION Gewinn_Nr(spielfeld)
    INTEGER :: m, n, i, j
    INTEGER, DIMENSION(:,:), INTENT(IN) :: spielfeld
    INTEGER, DIMENSION(16) :: flachesfeld
    m = SIZE(spielfeld, 2)
    n = SIZE(spielfeld, 1)

    !! Spalten
    DO i = 1, n
       DO j = 1, m - 3
          IF (ABS(SUM(spielfeld(i, j:j + 3))) .eq. 4) THEN
             Gewinn_Nr = spielfeld(i, j)
             RETURN
          END IF
       END DO
    END DO
    !! Reihen
    DO i = 1, n - 3
       DO j = 1, m
          IF (ABS(SUM(spielfeld(i:i + 3, j))) .eq. 4) THEN
             Gewinn_Nr = spielfeld(i, j)
             RETURN
          END IF
       END DO
    END DO
    !! Test auf Diagonalen
    DO i = 1, n - 3
       DO j = 1, m - 3
          flachesfeld= RESHAPE(spielfeld(i:i + 3, j:j + 3), (/ 16 /))
          IF (ABS(SUM(flachesfeld(::5))) .eq. 4) THEN
             Gewinn_Nr = spielfeld(i, j)
             RETURN
          END IF
          IF (ABS(SUM(flachesfeld(4::3))) .eq. 4) THEN
             Gewinn_Nr = spielfeld(i + 3, j)
             RETURN
          END IF
       END DO
    END DO

    Gewinn_Nr = 0
  END FUNCTION Gewinn_Nr
END MODULE modviergewinnt
