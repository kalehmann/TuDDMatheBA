PROGRAM RoundingError
  IMPLICIT NONE
  !! Choose REAL type with decimal precision >=P and decimal range >=R :
  INTEGER, PARAMETER :: real_kind= SELECTED_REAL_KIND(P=6, R=37)
  !INTEGER, PARAMETER :: real_kind= SELECTED_REAL_KIND(P=15, R=307)
  !INTEGER, PARAMETER :: real_kind= SELECTED_REAL_KIND(P=18, R=4931)
  REAL(KIND=real_kind) :: x, y, z
  WRITE(*,*) ' Please enter integer or real values for x and y: '
  READ (*,*) x, y
  WRITE(*,*) ' x**4 = ', x ** 4
  z= x**4 - 4*y**4 - 4*y**2
  WRITE(*,*) ' x**4 - 4*y**4 - 4*y**2 = ', z
  z= x*x*x*x - 4*y*y*y*y - 4*y*y
  WRITE(*,*) ' x*x*x*x - 4*y*y*y*y - 4*y*y = ', z
  z= (x**2)**2 - (2*y**2)**2 - (2*y)**2
  WRITE(*,*) ' (x**2)**2 - (2*y**2)**2 - (2*y)**2 = ', z
  z= (x**2)**2 - (2*y)**2*(y**2 + 1)
  WRITE(*,*) ' (x**2)**2 - (2*y)**2*(y**2 + 1) = ', z
  z= (x*x - 2*y*(y+1)) * (x*x + 2*y*(y+1)) + 8*y**3
  WRITE (*,*) ' (x*x-2*y*(y+1)) * (x*x+2*y*(y+1)) + 8*y**3 = ', z
  z= (x**2 - 2*y**2) * (x**2 + 2*y**2) - 4*y**2
  WRITE (*,*) ' (x**2-2*y**2) * (x**2+2*y**2) - 4*y**2 = ', z
END PROGRAM RoundingError
