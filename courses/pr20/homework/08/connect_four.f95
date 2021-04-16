!! Karsten Lehmann (4935758)
PROGRAM connect_four
  IMPLICIT NONE
  INTEGER :: m, &  ! Breite des Spielfeldes
       &     n     ! Hoehe des Spielfeldes
  INTEGER, DIMENSION(:,:), ALLOCATABLE :: spielfeld

  DO
     CALL LESEGROESSE(m, n)
     ALLOCATE(spielfeld(m, n))

     DEALLOCATE(spielfeld)
  END DO

CONTAINS
  SUBROUTINE AUSGABE(spielfeld)

  END SUBROUTINE AUSGABE

  SUBROUTINE LESEGROESSE(m, n)
    INTEGER, INTENT(OUT) :: m, &  ! Breite des Spielfeldes
         &                    n     ! Hoehe des Spielfeldes
    DO
       WRITE(*,*) "Bitte geben Sie die Breite und die Hoehe des Spielfeldes ein"
       READ(*,*) m, n
       IF ((m < 4 .AND. n < 4 ) .OR. m < 2 .OR. n < 2) THEN
          WRITE(*,*) "Zu klein!"
       ELSE
          EXIT
       END IF
    END DO
  END SUBROUTINE LESEGROESSE
END PROGRAM connect_four
