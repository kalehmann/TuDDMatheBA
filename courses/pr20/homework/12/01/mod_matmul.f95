!! Albina Oscherowa
!! Karsten Lehmann
MODULE mod_matmul
  IMPLICIT NONE

  PRIVATE

  PUBLIC strassen_matmul, simple_matmul

CONTAINS
  FUNCTION T11(A) RESULT(B)
    REAL, DIMENSION(:,:), INTENT(IN) :: A
    REAL, DIMENSION(:,:) :: B(SIZE(A, DIM=1)/2, SIZE(A, DIM=2)/2)
    INTEGER :: n
    n = SIZE(A, DIM=1)

    B = A(1:n / 2, 1:n / 2)
  END FUNCTION T11

  FUNCTION T12(A) RESULT(B)
    REAL, DIMENSION(:,:), INTENT(IN) :: A
    REAL, DIMENSION(:,:) :: B(SIZE(A, DIM=1)/2, SIZE(A, DIM=2)/2)
    INTEGER :: n
    n = SIZE(A, DIM=1)

    B = A(1:n / 2, n / 2 + 1:n)
  END FUNCTION T12

  FUNCTION T21(A) RESULT(B)
    REAL, DIMENSION(:,:), INTENT(IN) :: A
    REAL, DIMENSION(:,:) :: B(SIZE(A, DIM=1)/2, SIZE(A, DIM=2)/2)
    INTEGER :: n
    n = SIZE(A, DIM=1)

    B = A(n / 2 + 1:n, 1:n / 2)
  END FUNCTION T21

  FUNCTION T22(A) RESULT(B)
    REAL, DIMENSION(:,:), INTENT(IN) :: A
    REAL, DIMENSION(:,:) :: B(SIZE(A, DIM=1)/2, SIZE(A, DIM=2)/2)
    INTEGER :: n
    n = SIZE(A, DIM=1)

    B = A(n / 2 + 1:n, n / 2 + 1:n)
  END FUNCTION T22

  RECURSIVE FUNCTION strassen_matmul(A, B) RESULT(C)
    REAL, DIMENSION(:,:), INTENT(IN) :: A, B
    REAL, DIMENSION(:,:) :: C(SIZE(A, DIM=1), SIZE(A, DIM=2))
    INTEGER :: n

    REAL, DIMENSION(:,:) :: M1(SIZE(A, DIM=1) / 2, SIZE(A, DIM=2) / 2), &
         & M2(SIZE(A, DIM=1) / 2, SIZE(A, DIM=2) / 2), &
         & M3(SIZE(A, DIM=1) / 2, SIZE(A, DIM=2) / 2), &
         & M4(SIZE(A, DIM=1) / 2, SIZE(A, DIM=2) / 2), &
         & M5(SIZE(A, DIM=1) / 2, SIZE(A, DIM=2) / 2), &
         & M6(SIZE(A, DIM=1) / 2, SIZE(A, DIM=2) / 2), &
         & M7(SIZE(A, DIM=1) / 2, SIZE(A, DIM=2) / 2)

    n = SIZE(A, DIM=1)
    IF (n .eq. 1) THEN
       C(1,1) = A(1,1) * B(1,1)

       RETURN
    END IF

    M1 = strassen_matmul(T12(A) - T22(A), T21(B) + T22(B))
    M2 = strassen_matmul(T11(A) + T22(A), T11(B) + T22(B))
    M3 = strassen_matmul(T11(A) - T21(A), T11(B) + T12(B))
    M4 = strassen_matmul(T11(A) + T12(A), T22(B))
    M5 = strassen_matmul(T11(A), T12(B) - T22(B))
    M6 = strassen_matmul(T22(A), T21(b) - T11(B))
    M7 = strassen_matmul(T21(A) + T22(A), T11(B))

    C(1:n/2, 1:n/2) = M1 + M2 - M4 + M6
    C(1:n/2, n/2+1:n) = M4 + M5
    C(n/2+1:n, 1:n/2) = M6 + M7
    C(n/2+1:n, n/2+1:n) = M2 - M3 + M5 - M7
  END FUNCTION strassen_matmul

  FUNCTION simple_matmul(A, B) RESULT(C)
    REAL, DIMENSION(:,:), INTENT(IN) :: A, B
    REAL, DIMENSION(:,:) :: C(SIZE(A, DIM=1), SIZE(A, DIM=2))
    INTEGER :: i, j, k
    REAL :: l

    DO i = 1, SIZE(A, DIM=1)
       DO j = 1, SIZE(B, DIM=2)
          l = 0
          DO k = 1, SIZE(A, DIM=2)
             l = l + A(i, k) * B(k, j)
          END DO
          C(i, j) = l
       END DO
    END DO
  END FUNCTION simple_matmul
END MODULE mod_matmul
