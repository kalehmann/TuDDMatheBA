!! Albina Oscherowa (4694823)
!! Karsten Lehmann (4935758)
PROGRAM connect_four
  !! Das Spiel Vier Gewinnt in Fortran
  IMPLICIT NONE
  INTEGER :: m, &        ! Breite des Spielfeldes
       &     n, &        ! Hoehe des Spielfeldes
       &     s, &        ! Die Spalte des naechsten Chips
       &     spieler, &  ! Der aktive Spieler
       &     status      ! Der aktuelle Status des Spiels
  INTEGER, DIMENSION(:,:), ALLOCATABLE :: spielfeld
  CHARACTER, PARAMETER :: out(-1:1) = (/ 'O', ' ', 'X' /)

  DO
     CALL LESEGROESSE(m, n)
     ALLOCATE(spielfeld(n, m))
     spielfeld = 0
     spieler = -1
     DO
        !! ACHAR(27) - Escape character
        !! [2J - Control sequence "erase display"
        !! Siehe https://www.vt100.net/docs/vt100-ug/chapter3.html#ED
        !! [1;1H - Control sequence "Cursor position"
        !! Siehe https://www.vt100.net/docs/vt100-ug/chapter3.html#CUP
        !! Die naechste Zeile leert die Ausgabe und setzt den Cursor in die
        !! linke obere Ecke.
        WRITE(*,'(A)') ACHAR(27) // "[2J" // ACHAR(27) // "[1;1H"
        WRITE(*,'(A, A)') 'Aktiver Spieler: ', out(spieler)
        CALL AUSGABE(spielfeld)
        status = GEWINNER(spielfeld)
        IF (status .ne. 0) THEN
           WRITE(*,*) "Der Spieler " // out(status) // " hat gewonnen"
           EXIT
        END IF
        DO
           WRITE(*,*) "Chip in Spalte : "
           READ(*,*) s
           IF (s < 1) THEN
              WRITE(*,*) "Keine Spalten kleiner als 1"
           ELSE IF (s > m) THEN
              WRITE(*,*) "Spalte zu groß"
           ELSE IF (spielfeld(n, s) .ne. 0) THEN
              WRITE(*,*) "Spalte bereits voll"
           ELSE
              CALL SETZE(spielfeld, s, spieler)
              EXIT
           END IF
        END DO
        IF (spieler .eq. 1) THEN
           spieler = -1
        ELSE
           spieler = 1
        END IF
     END DO
     DEALLOCATE(spielfeld)
  END DO
CONTAINS
  SUBROUTINE AUSGABE(spielfeld)
    !! Gibt das Spielfeld im Terminal aus.
    INTEGER :: m, &  ! Breite des Spielfeldes
         &     n, &  ! Hoehe des Spielfeldes
         &     i, &  ! Zaehler fuer die Breite
         &     j     ! Zaehler fuer die Hoehe
    INTEGER, DIMENSION(:,:), INTENT(IN) :: spielfeld

    m = SIZE(spielfeld, 2)
    n = SIZE(spielfeld, 1)

    WRITE(*, "(A)", ADVANCE="no") "┌───"
    DO i = 1, m - 1
       WRITE(*, "(A)", ADVANCE="no") "┬───"
    END DO
    WRITE(*, '(A)') "┐"
    WRITE(*, "(A)", ADVANCE="no") "│"
    DO i = 1, m
       WRITE(*, "(I2, A)", ADVANCE="no") i, " │"
    END DO
    WRITE(*,*) ""
    WRITE(*, '(A)', ADVANCE="no") "├───"
    DO i = 2, m
       WRITE(*, "(A)", ADVANCE="no") "┼───"
    END DO
    WRITE(*,'(A)') "┤"
    DO j = n, 1, -1
       WRITE(*, "(A)", ADVANCE="no") "│"
       DO i = 1, m
          WRITE(*, "(A2, A)", ADVANCE="no") out(spielfeld(j, i)), " │"
       END DO
       WRITE(*,*) ""
    END DO
    WRITE(*, '(A)', ADVANCE="no") "└───"
    DO i = 2, m
       WRITE(*, "(A)", ADVANCE="no") "┴───"
    END DO
    WRITE(*,'(A)') "┘"
  END SUBROUTINE AUSGABE

  INTEGER FUNCTION GEWINNER(spielfeld)
    !! Ermittelt, ob bereits ein Spieler gewonnen hat.
    INTEGER :: m, &  ! Breite des Spielfeldes
         &     n, &  ! Hoehe des Spielfeldes
         &     i, &  ! Zaehler fuer die Breite
         &     j     ! Zaehler fuer die Hoehe
    INTEGER, DIMENSION(:,:), INTENT(IN) :: spielfeld
    INTEGER, DIMENSION(16) :: test
    m = SIZE(spielfeld, 2)
    n = SIZE(spielfeld, 1)

    DO i = 1, n
       DO j = 1, m - 3
          IF (ABS(SUM(spielfeld(i, j:j + 3))) .eq. 4) THEN
             GEWINNER = spielfeld(i, j)
             RETURN
          END IF
       END DO
    END DO
    DO i = 1, n - 3
       DO j = 1, m
          IF (ABS(SUM(spielfeld(i:i + 3, j))) .eq. 4) THEN
             GEWINNER = spielfeld(i, j)
             RETURN
          END IF
       END DO
    END DO
    DO i = 1, n - 3
       DO j = 1, m - 3
          test = RESHAPE(spielfeld(i:i + 3, j:j + 3), (/ 16 /))
          IF (ABS(SUM(test(::5))) .eq. 4 .or. ABS(SUM(test(4::3))) .eq. 4) THEN
             GEWINNER = spielfeld(i, j)
             RETURN
          END IF
       END DO
    END DO

    GEWINNER = 0
  END FUNCTION GEWINNER

  SUBROUTINE LESEGROESSE(m, n)
    !! Liesst solange Breite und Hoehe des Spielfeldes ein, bis diese den
    !! minimalen Anforderungen genuegen.
    INTEGER, INTENT(OUT) :: m, &  ! Breite des Spielfeldes
         &                  n     ! Hoehe des Spielfeldes
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

  SUBROUTINE SETZE(spielfeld, spalte, chip)
    !! Setzt einen Chip fuer einen Spieler in der gegebenen Spalte.
    INTEGER, DIMENSION(:,:), INTENT(INOUT) :: spielfeld
    INTEGER, INTENT(IN) :: spalte, chip
    INTEGER :: j, &  ! Zaehler fuer die Hoehe
         &     n     ! Hoehe des Spielfeldes
    n = SIZE(spielfeld, 1)

    DO j = 1, n
       IF (spielfeld(j, spalte) .eq. 0) THEN
          WRITE(*,*) "setze"
          spielfeld(j, spalte) = chip
          RETURN
       END IF
    END DO
  END SUBROUTINE SETZE
END PROGRAM connect_four
