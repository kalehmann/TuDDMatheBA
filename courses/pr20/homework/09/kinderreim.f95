!! Albina Oscherowa (4694823)
!! Karsten Lehmann (4935758)
MODULE mod_cycle
  IMPLICIT NONE

  TYPE KIND
     CHARACTER(len=12) :: name
     INTEGER :: alter
  END TYPE KIND

  TYPE CYC_NODE
     TYPE(KIND) :: kind
     TYPE(CYC_NODE), POINTER :: next
  END TYPE CYC_NODE

CONTAINS
  SUBROUTINE Build_Cycle(cyc, data_error)
    TYPE(CYC_NODE), INTENT(OUT), POINTER :: cyc
    LOGICAL, INTENT(OUT) :: data_error

    CHARACTER(len=9) :: fn = 'KREIM.DAT'
    INTEGER :: ioerr
    TYPE(CYC_NODE), POINTER :: tmp

    data_error = .TRUE.
    ALLOCATE(cyc)
    cyc%next => cyc
    tmp => cyc
    OPEN(unit=44, file=fn, action='READ', IOSTAT=ioerr)
    IF (ioerr .ne. 0) THEN
       RETURN
    END IF
    DO
       READ(44, *, IOSTAT=ioerr) tmp%next%kind
       IF (ioerr .gt. 0) THEN
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

  SUBROUTINE Count_Cycle(cyc, count)
    TYPE(CYC_NODE), INTENT(INOUT), POINTER :: cyc
    INTEGER, INTENT(IN) :: count
    INTEGER :: n

    DO n = 1, count,  -1
       cyc => cyc%next
    END DO
  END SUBROUTINE Count_Cycle

  SUBROUTINE Del_Next(cyc)
    TYPE(CYC_NODE), INTENT(IN), POINTER :: cyc
    TYPE(CYC_NODE), POINTER :: tmp

    tmp => cyc%next
    cyc%next => tmp%next
    DEALLOCATE(tmp)
  END SUBROUTINE Del_Next

  LOGICAL FUNCTION Last_One(cyc)
    TYPE(CYC_NODE), INTENT(IN), POINTER :: cyc
    Last_One = ASSOCIATED(cyc, cyc%next)
  END FUNCTION Last_One
  
  SUBROUTINE Put_Cycle(cyc)
    TYPE(CYC_NODE), INTENT(IN), POINTER :: cyc
    TYPE(CYC_NODE), POINTER :: tmp

    tmp => cyc
    DO
       WRITE(*,*) tmp%kind
       tmp => tmp%next
       IF (ASSOCIATED(tmp, cyc)) THEN
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
     WRITE(*,*) ""
     WRITE(*,*) "Es sind noch im Kreis:"
     CALL Put_Cycle(cyc)

     IF (Last_One(cyc)) THEN
        DEALLOCATE(cyc)
        EXIT
     END IF
     CALL Count_Cycle(cyc, 21)
     CALL Count_Cycle(cyc, cyc%kind%alter)
     CALL Del_Next(cyc)
  END DO
END PROGRAM kinderreim
