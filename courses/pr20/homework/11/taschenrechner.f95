PROGRAM taschenrechner
  USE stringmod
  USE treemod
  IMPLICIT NONE
  
  TYPE(tree) :: t
  CALL readstring()
  CALL buildtree(t)
  CALL printtree(t)
END PROGRAM taschenrechner
