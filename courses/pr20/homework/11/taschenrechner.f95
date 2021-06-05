PROGRAM taschenrechner
  USE stringmod
  USE treemod
  IMPLICIT NONE
  
  TYPE(tree) :: t
  CALL readstring()
  CALL buildtree(t)
  CALL printtree(t)
  CALL printtree(t, .TRUE.)
END PROGRAM taschenrechner
