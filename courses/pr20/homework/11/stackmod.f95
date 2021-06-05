!! Albina Oscherowa
!! Karsten Lehmann

!! Verwaltet einen Stack mit 10 Zeichen langen Zeichenketten.
MODULE stackmod
  IMPLICIT NONE

  TYPE stackelement
     CHARACTER(LEN=10) :: data
     TYPE(stackelement), POINTER :: previous
  END type stackelement

  TYPE stack
     TYPE(stackelement), POINTER :: current
     INTEGER :: size
  END type stack
CONTAINS
  !! Initialisiert den Stack
  SUBROUTINE init(s)
    TYPE(stack), INTENT(OUT) :: s
    NULLIFY(s%current)
    s%size = 0
  END SUBROUTINE init

  !! Prueft ob der Stack leer ist
  LOGICAL FUNCTION empty(s)
    TYPE(stack), INTENT(IN) :: s
    empty = s%size == 0
  END FUNCTION empty

  !! Fuegt dem Stack ein Element zu
  SUBROUTINE push(s, data)
    TYPE(stack), INTENT(OUT) :: s
    CHARACTER(LEN=10), INTENT(IN) :: data
    TYPE(stackelement), POINTER :: current
    ALLOCATE(current)
    current%data = data
    current%previous => s%current
    s%current => current
    s%size = s%size + 1
  END SUBROUTINE push

  !! Entnimmt dem Stack ein Element
  SUBROUTINE pop(s, data)
    TYPE(stack), INTENT(OUT) :: s
    CHARACTER(LEN=10), INTENT(OUT) :: data
    TYPE(stackelement), POINTER :: current

    data = s%current%data
    IF (empty(s)) THEN
       WRITE(*,*) 'Failed to pop element from empty stack'
       STOP 1
    END IF
    current => s%current
    s%current => s%current%previous
    DEALLOCATE(current)
    s%size = s%size - 1
  END SUBROUTINE pop

  !! Gibt das oberste Element des Stacks zurueck (ohne Modifikation)
  CHARACTER(LEN=10) FUNCTION top(s)
    TYPE(stack), INTENT(IN) :: s
    top = s%current%data
  END FUNCTION top

  !! Gibt den Stackinhalt aus
  SUBROUTINE write(s)
    TYPE(stack), INTENT(IN) :: s
    TYPE(stackelement), POINTER :: current

    current => s%current
    DO WHILE(ASSOCIATED(current))
       WRITE(*,'(A)', ADVANCE='NO') TRIM(current%data) // ' '
       current => current%previous
    END DO
  END SUBROUTINE write
END MODULE stackmod
