MODULE stringmod
  IMPLICIT NONE

  PRIVATE data, index

  PUBLIC getnextchar, readstring

  CHARACTER(LEN=80) :: data
  INTEGER(KIND=1) :: index
CONTAINS
  SUBROUTINE getnextchar(c)
    CHARACTER(LEN=1), INTENT(OUT) :: c
    c = data(index:index)
    index = index + 1
  END SUBROUTINE getnextchar

  SUBROUTINE readstring()
    READ(*,'(A)') data
    index = 1
  END SUBROUTINE readstring
END MODULE stringmod
