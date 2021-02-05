!! Albina Oscherowa
!! Karsten Lehmann
MODULE mod_rb
  IMPLICIT NONE
  PRIVATE

  PUBLIC RingBuffer, current, free, next, previous, ringbuffer_init, set

  TYPE RingBuffer
     INTEGER, ALLOCATABLE :: data(:)
     INTEGER :: zeiger
   CONTAINS
     PROCEDURE, PUBLIC :: current, free, length, next, previous, set
  END type RingBuffer
  
CONTAINS  
  !! Gibt das aktuelle Element des Ringbuffers zurueck.
  INTEGER FUNCTION current(this)
    CLASS(RingBuffer) :: this
    current = this%data(this%zeiger)
  END FUNCTION current

  !! Gibt den Speicher des Ringbuffers frei
  SUBROUTINE free(this)
    CLASS(RingBuffer) :: this
    DEALLOCATE(this%data)
  END SUBROUTINE free
  
  !! Gibt die laenge des Ringbuffers zurueck
  INTEGER FUNCTION length(this)
    CLASS(RingBuffer) :: this
    length = SIZE(this%data)
  END FUNCTION length
  
  !! Selektiert das naechste Element des Ringbuffers.
  SUBROUTINE next(this)
    CLASS(RingBuffer) :: this
    this%zeiger = MODULO(this%zeiger + 1, SIZE(this%data))
  END SUBROUTINE next

  !! Selektiert das vorherige Element des Ringbuffers. 
  SUBROUTINE previous(this)
    CLASS(RingBuffer) :: this
    this%zeiger = MODULO(this%zeiger + SIZE(this%data) - 1, SIZE(this%data))    
  END SUBROUTINE previous

  !! Erstellt einen neuen Ringbuffer und allokiert Speicher
  TYPE(RingBuffer) FUNCTION ringbuffer_init(data_size)
    INTEGER, INTENT(IN) :: data_size
    ALLOCATE(ringbuffer_init%data(0:data_size-1))
    ringbuffer_init%zeiger = 0
  END FUNCTION ringbuffer_init

  !! Weist dem aktuellen Element des Ringbuffers einen neuen
  !! Wert zu.
  SUBROUTINE set(this, value)
    CLASS(RingBuffer) :: this
    INTEGER, INTENT(IN) :: value
    this%data(this%zeiger) = value
  END SUBROUTINE set
END MODULE mod_rb


PROGRAM fibo
  USE mod_rb
  IMPLICIT NONE

  INTEGER :: an, fn, n, p
  TYPE(RingBuffer) :: a, f

  WRITE(*,*) 'Ordnung (>0) : '
  READ(*,*) p

  IF (p < 1) THEN
     WRITE(*,*) 'Fehler, die Ordnung muss >0 sein.'
     STOP 1
  END IF

  a = ringbuffer_init(p)
  f = ringbuffer_init(p)
  
  DO n=1, p
     WRITE(*,*) n, '. Werte fuer a und f'
     READ(*,*) an, fn
     CALL a%set(an)
     CALL a%next()
     CALL f%set(fn)
     CALL f%next()
  END DO
  
  DO n=p, 100
     IF (ABS(f%current()) > HUGE(1)/p) THEN
        WRITE(*,*) 'Integerueberlauf'
        STOP 1
     END IF
     CALL f%set(fi(a, f))
     WRITE(*,*) f%current()
     CALL f%next()
  END DO

  CALL a%free()
  CALL f%free()

CONTAINS
   INTEGER FUNCTION fi(a, f)
     TYPE(RingBuffer), INTENT(IN) :: a, f
     INTEGER :: n
     fi = 0

     DO n=1, f%length()
        fi = fi + a%current() * f%current()
        CALL f%previous()
        CALL a%next()
     END DO
   END FUNCTION fi
END PROGRAM fibo
