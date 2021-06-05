!! Albina Oscherowa
!! Karsten Lehmann

!! Haelt eine Zeichenkette mit 80 Zeichen als Datenstrom mit
!! aktueller Leseposition
MODULE stringmod
  IMPLICIT NONE

  PRIVATE data, index

  PUBLIC getnextchar, readstring

  CHARACTER(LEN=80) :: data
  INTEGER(KIND=1) :: index
CONTAINS
  !! Liesst die maximal 80 Zeichen lange Kette ein
  SUBROUTINE getnextchar(c)
    CHARACTER(LEN=1), INTENT(OUT) :: c
    c = data(index:index)
    index = index + 1
  END SUBROUTINE getnextchar

  !! Gibt das naechste Zeichen der Kette zurueck
  SUBROUTINE readstring()
    READ(*,'(A)') data
    index = 1
  END SUBROUTINE readstring
END MODULE stringmod
