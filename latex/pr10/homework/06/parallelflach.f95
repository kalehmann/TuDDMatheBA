!! Albina Oscherowa
!! Karsten Lehmann
MODULE PF
  IMPLICIT NONE
  
  PRIVATE

  PUBLIC L, KREUZ, F, OB


CONTAINS
  REAL FUNCTION L(a)
    REAL, DIMENSION(3), INTENT(IN) :: a
    L = SQRT(DOT_PRODUCT(a, a))
  END FUNCTION L

  FUNCTION KREUZ(a, b)
    REAL, DIMENSION(3)  :: KREUZ
    REAL, DIMENSION(3), INTENT(IN) :: a, b
    KREUZ = (/ &
        & a(2) * b(3) - a(3) * b(2), &
        & a(3) * b(1) - a(1) * b(3), &
        & a(1) * b(2) - a(2) * b(1) &
    &/)
  END FUNCTION KREUZ

  REAL FUNCTION F(a, b)
    REAL, DIMENSION(3), INTENT(IN) :: a, b
    F = L(KREUZ(a, b))
  END FUNCTION F

  REAL FUNCTION OB(a, b, c)
    REAL, DIMENSION(3), INTENT(IN) :: a, b, c
    OB = 2 * (F(a,b) + F(b,c) + F(c,a))
  END FUNCTION OB
END MODULE PF

PROGRAM pm
  USE PF
  IMPLICIT NONE
  
  REAL, DIMENSION(3) :: a, b, c
  LOGICAL :: run = .true.
  CHARACTER :: char
  
  WRITE(*,*) 'Parallelflach'
  DO WHILE(run)
     WRITE(*,*) 'Vektor a'
     READ(*,*) a
     WRITE(*,*) 'Vektor b'
     READ(*,*) b 
     WRITE(*,*) 'Vektor c'
     READ(*,*) c
     
     WRITE(*,*) 'Oberflaeche: ', OB(a,b,c)
     WRITE(*,*) 'Nochmal? (j/n)'
     READ(*,*) char
     run = char .eq. 'j'
  END DO
END PROGRAM pm
