!! Karsten Lehmann (4935758)
PROGRAM aufgabe2
  USE modviergewinnt
  IMPLICIT NONE
  INTEGER :: aktiv, gewinn, j, m, n, spalte
  INTEGER, DIMENSION(:,:), ALLOCATABLE :: feld

  DO
     l1: DO
        WRITE(*,*) "Breite und Hoehe? :"
        READ(*,*) m, n
        IF ((m < 4 .AND. n < 4 ) .OR. m < 2 .OR. n < 2) THEN
           WRITE(*,*) "Zu wenig"
        ELSE
           EXIT l1
        END IF
     END DO l1
     ALLOCATE(feld(n, m))
     feld = 0
     aktiv = -1
     spielloop: DO
        CALL ausgabe(feld)
        gewinn = gewinn_nr(feld)
        IF (gewinn .ne. 0) THEN
           WRITE(*,*) "Der Gewinner ist " // zeichen(gewinn)
           EXIT spielloop
        END IF
        WRITE(*,*) 'Es spielt: ' // zeichen(aktiv)
        zugloop: DO
           WRITE(*,*) "Setze chip nach? :"
           READ(*,*) spalte
           IF  (spalte < 1) THEN
              WRITE(*,*) "nix da"
           ELSE IF (spalte > m) THEN
              WRITE(*,*) "feld zu klein"
           ELSE IF (feld(n, spalte) .NE. 0) THEN
              WRITE(*,*) "spalte voll"
           ELSE
              setzloop: DO j = 1, n
                  IF (feld(j, spalte) .eq. 0) THEN
                     feld(j, spalte) = aktiv
                     EXIT zugloop
                  END IF
              END DO setzloop
           END IF
        END DO zugloop
        aktiv = -1 * aktiv
     END DO spielloop
     DEALLOCATE(feld)
  END DO
  
CONTAINS
END PROGRAM aufgabe2
