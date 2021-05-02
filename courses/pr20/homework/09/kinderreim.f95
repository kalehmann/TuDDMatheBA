!! Albina Oscherowa (4694823)
!! Karsten Lehmann (4935758)

!! In dieser Datei wird der Kinderreim "Eene meene muh" zum Auszahlen von
!! Personen aus der Datei "kreim.dat" genutzt.

MODULE mod_cycle
  !! Dieses Modul enthaelt Helferfunktionen und Datentypen zum Erstellen
  !! und Verwalten einer zyklischen Liste von Personen
  IMPLICIT NONE

  !! Datentyp zum Speichern des Namens und Alters einer Person
  TYPE KIND
     CHARACTER(len=12) :: name
     INTEGER :: alter
  END TYPE KIND

  !! Ein Knoten/Element in die zyklischen Liste.
  !! Der Knoten kennt das naechste Element der Liste
  TYPE CYC_NODE
     TYPE(KIND) :: kind
     TYPE(CYC_NODE), POINTER :: next
  END TYPE CYC_NODE

CONTAINS
  !! Erstellt die zyklische Liste aus der Datei "kreim.dat".
  !! Der letzte Eintrag der Liste verlinkt den Anfang der Liste
  !! als naechsten Eintrag.
  SUBROUTINE Build_Cycle(cyc, data_error)
    TYPE(CYC_NODE), INTENT(OUT), POINTER :: cyc
    LOGICAL, INTENT(OUT) :: data_error
    INTEGER :: ioerr
    TYPE(CYC_NODE), POINTER :: tmp

    data_error = .TRUE.
    ALLOCATE(cyc)
    cyc%next => cyc
    tmp => cyc
    OPEN(unit=44, file='kreim.dat', action='READ', IOSTAT=ioerr)
    IF (ioerr .ne. 0) THEN
       !! Fehler beim Oeffnen der Datei
       RETURN
    END IF
    DO
       READ(44, *, IOSTAT=ioerr) tmp%next%kind
       IF (ioerr .gt. 0) THEN
          !! Fehler beim Lesen der Zeile
          RETURN
       ELSE IF (ioerr .lt. 0) THEN
          !! Ende der Datei
          DEALLOCATE(tmp%next)
          EXIT
       END IF
       tmp => tmp%next
       ALLOCATE(tmp%next)
    END DO
    CLOSE(44)

    tmp%next => cyc
    data_error = .FALSE.
  END SUBROUTINE Build_Cycle

  !! Nimmt einen Zeiger auf ein Element der zyklischen Liste entgegen
  !! und schiebt diesen count Elemente weiter.
  SUBROUTINE Count_Cycle(cyc, count)
    TYPE(CYC_NODE), INTENT(INOUT), POINTER :: cyc
    INTEGER, INTENT(IN) :: count
    INTEGER :: n

    DO n = 1, count
       cyc => cyc%next
    END DO
  END SUBROUTINE Count_Cycle

  !! Loescht das naechste Element der zyklischen Liste und aktualisiert
  !! den Zeiger auf das naechste Element des aktuellen Elementes.
  SUBROUTINE Del_Next(cyc)
    TYPE(CYC_NODE), INTENT(IN), POINTER :: cyc
    TYPE(CYC_NODE), POINTER :: tmp

    tmp => cyc%next
    cyc%next => tmp%next
    DEALLOCATE(tmp)
  END SUBROUTINE Del_Next

  !! Prueft, ob das uebergebene Element das letzte Element in der zyklischen
  !! Liste ist.
  LOGICAL FUNCTION Last_One(cyc)
    TYPE(CYC_NODE), INTENT(IN), POINTER :: cyc
    Last_One = ASSOCIATED(cyc, cyc%next)
  END FUNCTION Last_One

  !! Gibt Namen und Alter der Personen der zyklischen Liste aus.
  SUBROUTINE Put_Cycle(cyc)
    TYPE(CYC_NODE), INTENT(IN), POINTER :: cyc
    TYPE(CYC_NODE), POINTER :: tmp

    tmp => cyc
    DO
       WRITE(*,*) tmp%kind
       tmp => tmp%next
       !! Teste ob der Anfang wieder erreicht wurde
       IF (ASSOCIATED(tmp, cyc)) THEN
          WRITE(*,*)
          RETURN
       END IF
    END DO
  END SUBROUTINE Put_Cycle
END MODULE mod_cycle

PROGRAM kinderreim
  USE mod_cycle
  IMPLICIT NONE

  TYPE(CYC_NODE), POINTER :: cyc
  LOGICAL :: err
  CALL Build_Cycle(cyc, err)
  IF (err) THEN
     WRITE(*,*) "Fehler beim Lesen der Datei"
     STOP 1
  END IF

  DO
     WRITE(*,*) "Es sind noch im Kreis:"
     CALL Put_Cycle(cyc)

     IF (Last_One(cyc)) THEN
        !! Es gibt einen Gewinner
        WRITE(*,*) "", "Das letzte Kind im Kreis ist ", cyc%kind%name
        DEALLOCATE(cyc)
        EXIT
     END IF
     !! Zaehle die 21 Silben des Reims
     CALL Count_Cycle(cyc, 21)
     !! Zaehle das Alters des Kindes und loesche das gewaehlte Kind.
     !! Da nur eine Prozedur zum Loeschen des naechsten Kindes zur Verfuegung
     !! steht, wird einmal weniger gezaehlt.
     CALL Count_Cycle(cyc, cyc%kind%alter - 1)
     WRITE(*,*) "Es scheidet aus: ", cyc%next%kind%name, ACHAR(10) !! 10 ist der Ascii Code des Zeilenumbruchs
     CALL Del_Next(cyc)
  END DO
END PROGRAM kinderreim
