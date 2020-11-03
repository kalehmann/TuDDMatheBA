PROGRAM namen
  IMPLICIT NONE

  CHARACTER(len=30) :: vorname, nachname
  
  WRITE(*,*) "Vorname: "
  READ(*,*) vorname
  WRITE(*,*) "Nachname: "
  READ(*,*) nachname
  
  WRITE(*,*) "Hallo ", TRIM(vorname), " ", TRIM(nachname) , "!"
  WRITE(*,*) TRIM(vorname), " ist ein schoener Name. :)"
END PROGRAM namen
