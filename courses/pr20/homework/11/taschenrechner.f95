!! Albina Oscherowa
!! Karsten Lehmann

!! Stack basierter Taschenrechner mit optionalem Infix-Modus
PROGRAM taschenrechner
  USE stackmod
  USE stringmod
  USE treemod
  IMPLICIT NONE

  CHARACTER(LEN=10) :: input
  TYPE(stack) :: s

  CALL init(s)
  WRITE(*,*) 'Stack based calculator'
  WRITE(*,*) ' Enter a number or operator - one per row'
  WRITE(*,*) ' ~ for negation'
  WRITE(*,*) ' + for addition'
  WRITE(*,*) ' - for subtraktion'
  WRITE(*,*) ' * for multiplikation'
  WRITE(*,*) ' : for division'
  WRITE(*,*) ' ^ for exponents'
  WRITE(*,*) ' = for the result'
  WRITE(*,*) ' i for infix mode'
  WRITE(*,*) ' q for exit'
  DO
     WRITE(*,'(A)',ADVANCE='NO') '> '
     READ(*,*) input
     IF (input .EQ. 'q') THEN
        EXIT
     ELSE IF (input .EQ. 'i') THEN
        CALL infix(s)
     END IF
     CALL stackcalc(s, input)
     WRITE(*,'(A)',ADVANCE='NO') 'Current stack  '
     CALL write(s)
     WRITE(*,*) '|'
  END DO
CONTAINS
  !! Nimmt die beiden obersten Elemente von Stack, addiert sie und fuegt
  !! das Ergebnis wieder dem Stack zu
  SUBROUTINE add(s)
    TYPE(stack), INTENT(INOUT) :: s
    CHARACTER(LEN=10) :: elementa , elementb
    CALL pop(s, elementa)
    CALL pop(s, elementb)
    WRITE(elementa,'(I10)') toint(elementa) + toint(elementb)
    CALL push(s, elementa)
  END SUBROUTINE add

  !! Nimmt die beiden obersten Elemente von Stack, subtrahiert sie und fuegt
  !! das Ergebnis wieder dem Stack zu
  SUBROUTINE sub(s)
    TYPE(stack), INTENT(INOUT) :: s
    CHARACTER(LEN=10) :: elementa , elementb
    CALL pop(s, elementa)
    CALL pop(s, elementb)
    WRITE(elementa,'(I10)') toint(elementa) - toint(elementb)
    CALL push(s, elementa)
  END SUBROUTINE SUB

  !! Nimmt die beiden obersten Elemente von Stack, multipliziert sie und fuegt
  !! das Ergebnis wieder dem Stack zu
  SUBROUTINE mul(s)
    TYPE(stack), INTENT(INOUT) :: s
    CHARACTER(LEN=10) :: elementa , elementb
    CALL pop(s, elementa)
    CALL pop(s, elementb)
    WRITE(elementa,'(I10)') toint(elementa) * toint(elementb)
    CALL push(s, elementa)
  END SUBROUTINE MUL

  !! Nimmt die beiden obersten Elemente von Stack, potenziert sie und fuegt
  !! das Ergebnis wieder dem Stack zu
  SUBROUTINE pot(s)
    TYPE(stack), INTENT(INOUT) :: s
    CHARACTER(LEN=10) :: elementa , elementb
    CALL pop(s, elementa)
    CALL pop(s, elementb)
    WRITE(elementa,'(I10)') toint(elementa) ** toint(elementb)
    CALL push(s, elementa)
  END SUBROUTINE pot

  !! Nimmt die beiden obersten Elemente von Stack, dividiert sie und fuegt
  !! das Ergebnis wieder dem Stack zu
  SUBROUTINE div(s)
    TYPE(stack), INTENT(INOUT) :: s
    CHARACTER(LEN=10) :: elementa , elementb
    CALL pop(s, elementa)
    CALL pop(s, elementb)
    WRITE(elementa,'(I10)') toint(elementa) / toint(elementb)
    CALL push(s, elementa)
  END SUBROUTINE div

  !! Nimmt das oberste Elemente von Stack, negiert es und fuegt
  !! das Ergebnis wieder dem Stack zu
  SUBROUTINE negate(s)
    TYPE(stack), INTENT(INOUT) :: s
    CHARACTER(LEN=10) :: element
    CALL pop(s, element)
    WRITE(element,'(I10)') -1 * toint(element)
    CALL push(s, element)
  END SUBROUTINE NEGATE

  !! ibt das oberste Element aus und entleert den Stack
  SUBROUTINE evaluate(s)
    TYPE(stack), INTENT(INOUT) :: s
    CHARACTER(LEN=10) :: element

    CALL pop(s, element)
    WRITE(*,*) 'Das Ergebnis ist ' // ADJUSTL(element)
    DO WHILE(.NOT. empty(s))
       CALL pop(s, element)
    END DO
  END SUBROUTINE evaluate

  !! Prueft ob die gegebene Zeichenkette einen Integer enthaelt
  LOGICAL FUNCTION isnumeric(s)
    CHARACTER(LEN=10), INTENT(IN) :: s
    INTEGER :: err, i
    READ(s,*,IOSTAT=err) i
    isnumeric = err .EQ. 0
  END FUNCTION isnumeric

  !! Konvertiert die Zeichenkette zu einem Integer
  INTEGER FUNCTION toint(s)
    CHARACTER(LEN=10), INTENT(IN) :: s
    READ(s,*) toint
  END FUNCTION toint

  !! Wertet input als Befehl fuer den Taschenrechner
  SUBROUTINE stackcalc(s, input)
    CHARACTER(LEN=10), INTENT(IN) :: input
    TYPE(stack), INTENT(INOUT) :: s

    IF (isnumeric(input)) THEN
       IF (toint(input) >= 0) THEN
          CALL push(s, input)
       END IF
    ELSE IF (input .EQ. '~') THEN
       CALL negate(s)
    ELSE IF (input .EQ. '+') THEN
       CALL add(s)
    ELSE IF (input .EQ. '-') THEN
       CALL sub(s)
    ELSE IF (input .EQ. '*') THEN
       CALL mul(s)
    ELSE IF (input .EQ. ':') THEN
       CALL div(s)
    ELSE IF(input .EQ. '^') THEN
       CALL pot(s)
    ELSE IF (input .EQ. '=') THEN
       CALL evaluate(s)
    ELSE
       WRITE(*,*) 'Unknown operation'
    END IF
  END SUBROUTINE stackcalc

  !! Startet den Infix-Modus
  SUBROUTINE infix(s)
    TYPE(stack), INTENT(INOUT) :: s
    TYPE(tree) :: t
    CHARACTER(LEN=80) :: buffer, part

    CALL readstring()
    CALL buildtree(t)
    CALL printtree(t, .TRUE., buffer)

    DO WHILE (LEN_TRIM(buffer) > 0)
       CALL split_space(buffer, part, buffer)
       WRITE(*,*) part
       CALL stackcalc(s, part(1:10))
    END DO
    CALL evaluate(s)
  END SUBROUTINE infix

  !! Spalten die Zeichenkette 'in' am ersten Leerzeichen in 'string1'
  !! und 'string2' auf.
  SUBROUTINE split_space(in, string1, string2)
    CHARACTER(80) :: in
    CHARACTER(80), INTENT(OUT) :: string1, string2
    INTEGER :: i

    in = TRIM(in)
    i = SCAN(in, ' ')
    string1 = in(1:i - 1)
    string2 = in(i + 1:)
  END SUBROUTINE split_space
END PROGRAM taschenrechner
