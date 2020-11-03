PROGRAM kreisumfang
  IMPLICIT NONE

  ! Variable fuer Pi und den Radius
  REAL :: pi, r
  pi = 3.14

  ! Radius einlesen
  WRITE (*,*) "Bitte geben Sie den Radius ein! "
  READ (*,*) r

  WRITE(*,*) " Der Kreis mit dem Radius ", r, " hat den Umfang ", pi * r * 2
END PROGRAM kreisumfang
