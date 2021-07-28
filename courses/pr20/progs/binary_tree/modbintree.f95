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

  !! A recursive function samestruct, which compares two binary trees.
  !! The binary trees (do not have to be heaps) are given by pointers
  !! to their root nodes.
  !! The function returns .TRUE. if the trees have the same struture.
  !! Note that they may have different contents.
  RECURSIVE FUNCTION samestruct(roota, rootb) RESULT (same)
    TYPE(node), POINTER, INTENT(IN) :: roota, rootb
    LOGICAL :: same

    IF (ASSOCIATED(roota%left)) THEN
       IF (ASSOCIATED(rootb%left)) THEN
          same = samestruct(roota%left, rootb%left)
          IF (.NOT. same) THEN
             RETURN
          END IF
       ELSE
          same = .FALSE.
          RETURN
       END IF
    ELSE
       IF (ASSOCIATED(rootb%left)) THEN
          same = .FALSE.
          RETURN
       END IF
    END IF

    IF (ASSOCIATED(roota%right)) THEN
       IF (ASSOCIATED(rootb%right)) THEN
          same = samestruct(roota%right, rootb%right)
          IF (.NOT. same) THEN
             RETURN
          END IF
       ELSE
          same = .FALSE.
          RETURN
       END IF
    ELSE
       IF (ASSOCIATED(rootb%right)) THEN
          same = .FALSE.
          RETURN
       END IF
    END IF

    same = .TRUE.
  END FUNCTION samestruct

  !! A subroutine swap, which exchanges to pointers to nodes.
  !! The references are exchanged instead of the node contents.
  SUBROUTINE swap(nodea, nodeb)
    TYPE(node), POINTER, INTENT(INOUT) :: nodea, nodeb
    TYPE(node), POINTER :: tmp
    tmp => nodea
    nodea => nodeb
    nodeb => tmp
  END SUBROUTINE swap

  !! A recursive function union, which unites two min-heaps and
  !! returns a pointer to the new min-heap.
  !! The binary trees are given by pointers
  !! to their root nodes.
  RECURSIVE FUNCTION union(heapa, heapb) RESULT(res)
    TYPE(node), POINTER, INTENT(INOUT) :: heapa, heapb
    TYPE(node), POINTER :: res
    INTEGER :: left_rank, right_rank

    !! If both heaps are empty (the pointers to their root nodes are not
    !! associated), a non-associated pointer is returned.
    IF (.NOT. ASSOCIATED(heapa) .AND. .NOT. ASSOCIATED(heapb)) THEN
       NULLIFY(res)
       RETURN
    END IF
    !! If one and only one of the heaps is empty, the other one is returned.
    IF (ASSOCIATED(heapa) .AND. .NOT. ASSOCIATED(heapb)) THEN
       res => heapa
       RETURN
    ELSE IF (ASSOCIATED(heapb) .AND. .NOT. ASSOCIATED(heapa)) THEN
       res => heapb
       RETURN
    END IF
    !! If both heaps are non-empty, the key values of their root elements are
    !! compared. If the key of the first node is smaller than the key of the
    !! second node, they will be exchanged with the swap routine.
    IF (heapa%key < heapb%key) THEN
       CALL swap(heapa, heapb)
    END IF
    !! The right subtree of the first (left) node will now be united
    !! with the second node.
    heapa%right => union(heapa%right, heapb)
    !! To make sure, taht the new heap satisfies the rank condition,
    !! the ranks of the left and right subtrees are compared and swapped
    !! if necessary. If a subtree is empty, the rank is zero.
    left_rank = 0
    IF (ASSOCIATED(heapa%left)) THEN
       left_rank = heapa%left%rank
    END IF
    right_rank = 0
    IF (ASSOCIATED(heapa%right)) THEN
       right_rank = heapa%right%rank
    END IF
    IF (right_rank < left_rank) THEN
       CALL swap(heapa%left, heapa%right)
    END IF
    !! Finally the rank must be calculated again.
    !! If the left or right subtree are empty, the rank is 1.
    !! Otherwise the rank is the minimum of the ranks of the subtrees
    !! increased by one.
    IF (ASSOCIATED(heapa%left) .AND. ASSOCIATED(heapa%right)) THEN
       heapa%rank = MIN(heapa%left%rank, heapa%right%rank) + 1
    ELSE
       heapa%rank = 1
    END IF

    res => heapa
  END FUNCTION union

  !! A subroutine insert, which generates a new heap node from a given key
  !! and inserts the value into the supplied min-heap.
  SUBROUTINE insert(key, heap)
    TYPE(node), POINTER, INTENT(INOUT) :: heap
    INTEGER, INTENT(IN) :: key
    TYPE(node), POINTER :: nnode

    ALLOCATE(nnode)
    nnode%rank = 1
    nnode%key = key

    heap => union(heap, nnode)
  END SUBROUTINE insert
END MODULE modbintree
