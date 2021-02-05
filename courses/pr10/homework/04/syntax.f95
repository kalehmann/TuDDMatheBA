PROGRAM syntax
  IMPLICIT NONE

  REAL :: N=3, A=0.5, B=4.0, C=5.0

  IF (-C*B/A < -2**(N-1)**N/B/B .EQV. C >= C/B/A .AND. .NOT. A==C-B-A .OR. 8*A>B) THEN
     WRITE(*,*) "Wahr"
  ELSE
     WRITE(*,*) "Falsch"
  END IF
  
END program syntax
