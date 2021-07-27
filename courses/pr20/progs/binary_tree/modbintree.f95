!! Copyright (C)  2021  Karsten Lehmann.
!!
!! Permission is granted to copy, distribute and/or modify this file
!! under the terms of the GNU Free
!! Documentation License version 1.3 as published by the Free Software
!! Foundation and appearing in the file included in the packaging of
!! this file.  Please review the following information to ensure
!! the GNU Free Documentation License version 1.3 requirements
!! will be met: http://www.gnu.org/copyleft/fdl.html.
MODULE modbintree
  IMPLICIT NONE

  !! Definition of a data type node, which represents a node of the binary
  !! tree (heap). The type consists of an integer component for the key, an
  !! integer component for the rank and two pointers to the child nodes.
  TYPE node
     INTEGER :: key, rank
     TYPE(node), POINTER :: left, right
  END type node
CONTAINS

  !! A recursive function keysum, which calculates the sum of the keys of
  !! all nodes in a binary tree. The binary tree (does not have to be a heap)
  !! is given by a pointer to its root node.
  RECURSIVE FUNCTION keysum(root) RESULT (ksum)
    TYPE(node), POINTER, INTENT(IN) :: root
    INTEGER :: ksum

    ksum = root%key
    IF (ASSOCIATED(root%left)) THEN
       ksum = ksum + keysum(root%left)
    END IF
    IF (ASSOCIATED(root%right)) THEN
       ksum = ksum + keysum(root%right)
    END IF
  END FUNCTION keysum

  !! A recursive function numleaves, which counts the number of leaves in
  !! a binary tree. The binary tree (does not have to be a heap)
  !! is given by a pointer to its root node.
  RECURSIVE FUNCTION numleaves(root) RESULT (lnum)
    TYPE(node), POINTER, INTENT(IN) :: root
    INTEGER :: lnum
    lnum = 0
    IF (.NOT. ASSOCIATED(root%left) .AND. .NOT. ASSOCIATED(root%right)) THEN
       lnum = 1
    ELSE
       IF (ASSOCIATED(root%left)) THEN
          lnum = lnum + numleaves(root%left)
       END IF
       IF (ASSOCIATED(root%right)) THEN
          lnum = lnum + numleaves(root%right)
       END IF
    END IF
  END FUNCTION numleaves

  !! A recursive function numinner, which counts the number of inner (non-leave)
  !! nodes in a binary tree. The binary tree (does not have to be a heap)
  !! is given by a pointer to its root node.
  RECURSIVE FUNCTION numinner(root) RESULT (inum)
    TYPE(node), POINTER, INTENT(IN) :: root
    INTEGER :: inum
    inum = 0
    IF (ASSOCIATED(root%left) .OR. ASSOCIATED(root%right)) THEN
       inum = 1
       IF (ASSOCIATED(root%left)) THEN
          inum = inum + numinner(root%left)
       END IF
       IF (ASSOCIATED(root%right)) THEN
          inum = inum + numinner(root%right)
       END IF
    END IF
  END FUNCTION numinner

END MODULE modbintree
