!! Albina Oscherowa
!! Karsten Lehmann
MODULE MZEIT
  IMPLICIT NONE

  PRIVATE

  PUBLIC zeit, OPERATOR(<), zeit_neu

  TYPE zeit
     INTEGER :: stunden, minuten
     REAL :: sekunden
  END type zeit

  INTERFACE zeit
     MODULE PROCEDURE zeit_neu
  END INTERFACE zeit

  INTERFACE OPERATOR (<)
     MODULE PROCEDURE zeit_kleiner
  END INTERFACE OPERATOR (<)
CONTAINS
    TYPE(zeit) FUNCTION zeit_neu(h, m, s)
      INTEGER, INTENT(IN) :: h, m
      REAL, INTENT(IN) :: s
      zeit_neu%stunden = h
      zeit_neu%minuten = m
      zeit_neu%sekunden = s
    END FUNCTION zeit_neu

    LOGICAL FUNCTION zeit_kleiner(a, b)
        TYPE(zeit), INTENT(IN) :: a, b
        zeit_kleiner = a%stunden * 3600 + a%minuten * 60 + a%sekunden < b%stunden * 3600 + b%minuten * 60 + b%sekunden
    END FUNCTION zeit_kleiner
END MODULE MZEIT

MODULE MERGEBNIS
  USE MZEIT
  IMPLICIT NONE

  PRIVATE 

  PUBLIC ergebnis

  TYPE ergebnis
     TYPE(zeit) :: zeit
     CHARACTER(len=30) :: name
  END type ergebnis
END MODULE MERGEBNIS

PROGRAM marathon
  USE MERGEBNIS
  USE MZEIT
  IMPLICIT NONE

  TYPE(ergebnis), dimension(:), allocatable :: liste
  TYPE(ergebnis) :: eg
  TYPE(zeit) :: bzeit 
  INTEGER :: z, n
  CHARACTER(len=30) :: ausgabe

  bzeit = zeit( 0, 0, 0 )

  WRITE(*,*) "Maximale Teilnehmerzahl : "
  READ(*,*) z
  WRITE(*,*) "Wohin ausgeben : "
  READ(*,*) ausgabe

  allocate(liste(z))
  call leseliste(liste, n)
  
  OPEN(UNIT=30, FILE=ausgabe, ACTION='WRITE')
  ! Liste Sortieren
  DO z = 1, n
    eg = naechstBestesErgebnis(bzeit, liste)
    WRITE(30,*) z, '. Platz, Name: ', eg%name,' Zeit: ', eg%zeit%stunden, 'Stunden', eg%zeit%minuten, &
        &'Minuten',  eg%zeit%sekunden, 'Sekunden'
    WRITE(*,*) z, '. Platz, Name: ', eg%name,' Zeit: ', eg%zeit%stunden, 'Stunden', eg%zeit%minuten, &
        &'Minuten',  eg%zeit%sekunden, 'Sekunden'
    bzeit = eg%zeit
  END DO
  CLOSE (30)
  deallocate(liste)
CONTAINS
  TYPE(ergebnis) FUNCTION naechstBestesErgebnis(alteZeit, liste)
    TYPE(zeit), INTENT(IN) :: alteZeit
    TYPE(ergebnis), dimension(:), INTENT(IN) :: liste
    INTEGER :: n

    naechstBestesErgebnis%zeit = zeit(8,0,0)

    DO n=1, SIZE(liste)
      IF (alteZeit < liste(n)%zeit) THEN
        IF (liste(n)%zeit < naechstBestesErgebnis%zeit) THEN
          naechstBestesErgebnis = liste(n)
        END IF
      END IF
    END DO
  END FUNCTION naechstBestesErgebnis

  SUBROUTINE leseliste(liste, teilnehmer)
    TYPE(ergebnis), dimension(:), INTENT(INOUT) :: liste
    TYPE(ergebnis) :: zeile
    CHARACTER(len=12) :: fn = 'marathon.dat'
    INTEGER, INTENT(OUT) :: teilnehmer
    INTEGER :: ioerr, max_tn
    LOGICAL :: file_exists = .false.

    INQUIRE(FILE=fn, EXIST=file_exists)
    IF (.NOT. file_exists) THEN
       WRITE(*,*) 'Fehler, die Datei marathon.dat existiert nicht'
       STOP 1
    END IF

    teilnehmer = 0
    max_tn = SIZE(liste)

    OPEN(UNIT=13, FILE=fn, ACTION='READ')    
    DO
       READ(13,*, IOSTAT=ioerr, END=10) zeile
       IF (teilnehmer == max_tn) THEN
          WRITE(*,*) "Fehler, die Teilnehmerzahl uebersteigt die maximalen Teilnehmer!"
          STOP 1
       END IF
       IF (ioerr .ne. 0) THEN
          WRITE(*,*) 'Fehler beim Lesen der Datei marathon.dat'
          STOP 1
       END IF
       teilnehmer = teilnehmer + 1
       liste(teilnehmer) = zeile
    END DO
    10 CLOSE (13)
  END SUBROUTINE leseliste
END PROGRAM marathon

