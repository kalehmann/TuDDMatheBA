!! Albina Oscherowa (4694823)
!! Karsten Lehmann (4935758)
PROGRAM zahlenraten
  IMPLICIT NONE

  CHARACTER :: c
  INTEGER :: i, l, r, z
  LOGICAL :: erraten, weiterspielen

  weiterspielen = .true.

  DO WHILE (weiterspielen .eqv. .true.)
  
     WRITE(*,*) "=================================================================="
     WRITE(*,*) " Zahlenraten"
     WRITE(*,*) "=================================================================="
     WRITE(*,*) "Der Computer wird Sie nach einer oberen und unteren Grenze fragen."
     WRITE(*,*) "Denken Sie sich anschliessend eine Zahl zwischen beiden Grenzen"
     WRITE(*,*) "und der Computer versucht dann diese Zahl zu erraten."
     WRITE(*,*) "Wenn ihre gedachte Zahl größer als die vom Computer erratene Zahl"
     WRITE(*,*) "ist, dann geben Sie '>' ein, ist die Zahl kleiner '<'."
     WRITE(*,*) "Wenn der Computer richtig geraten hat, bestätigen Sie dies mit '='."
     
     WRITE(*,*) "Wählen Sie die untere Grenze: "
     READ(*,*) l
  
     DO
        WRITE(*,*) "Wählen Sie die obere Grenze: "
        READ(*,*) r
        
        IF (l < r) THEN
          EXIT
       END IF
    END DO

    i = 0
    erraten = .false.
    
    DO WHILE (erraten .eqv. .false.)
       z = (l + r) / 2
       WRITE(*,*) "Ich rate: ", z
       i = i + 1
       DO
          WRITE(*,*) "Was halten Sie von dem Ergebnis? (<,>,=)"
          READ(*,*) c
          IF (c == '>' .or. c == '<' .or. c == '=') THEN
             EXIT
          END IF
       END DO
       IF (c == '=') THEN
          erraten = .true.
          WRITE(*,*) "Ich habe folgende Zahl an Versuchen benötigt: ", i
          WRITE(*,*) "Möchten Sie noch einmal spielen? (y,n)"
          DO
             READ(*,*) c
             IF (c == 'y' .or. c == 'n') THEN
                EXIT
             END IF
          END DO
          IF (c == 'n') THEN
             weiterspielen = .false.
          END IF
       ELSE
          IF ((r - l) < 2) THEN
             WRITE(*,*) "Logikfehler !"
             STOP 1
          ELSE
             IF ((r - l) == 2 .and. c == ">") THEN
                l = r
             ELSE
                IF (c == '>') THEN
                   l = z
                ELSE
                   r = z
                END IF
             END IF
          END IF
       END IF
    END DO
 END DO
END PROGRAM zahlenraten
