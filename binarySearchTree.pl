r() :- reconsult("binarySearchTree.pl").

/* binary search tree (bst) is represented like structure
   bst(Value, LeftSubTree, RightSubTree)
   empty tree is nil */
bst(_,_,_).

/* insert value into tree
   bstInsert(+Value, +Bst, -ResultTree) */
bstInsert(Element, nil, bst(Element, nil, nil)) :- !.
bstInsert(Element, bst(Val, L, R), bst(Val, L, R)) :- Element = Val, fail, !.
bstInsert(Element, bst(Val, L, R), bst(Val, NewLeft, R)) :-
    Element < Val,
    bstInsert(Element, L, NewLeft),
    !.
bstInsert(Element, bst(Val, L, R), bst(Val, L, NewRight)) :-
    Element > Val,
    bstInsert(Element, R, NewRight),
    !.

/* check if bst contain element or not
   bstContain(+Element, +Bst) */
bstContain(_, nil) :- fail, !.
bstContain(Element, bst(Element, _, _)) :- !.
bstContain(Element, bst(Val, L, _)) :-
    Element < Val,
    bstContain(Element, L),
    !.
bstContain(Element , bst(Val, _, R)) :-
    Element > Val,
    bstContain(Element, R),
    !.

/* create bst from list, root contain last element of the list
   bstFromList(+List, -Bst) */
bstFromList([], nil) :- !.
bstFromList([Element], bst(Element, nil, nil)) :- !.
bstFromList([H|T], Res) :-
    bstFromList(T, SubRes),
    bstInsert(H, SubRes, Res),
    !.

/* create bst from list by inserting elements one by one
   bstFromList2(+List, -Bst) */
bstFromList2([], nil) :- !.
bstFromList2([Element], bst(Element, nil, nil)) :- !.
bstFromList2([H|T], Res) :- bstFromList2Aux([H|T], nil, Res), !.

/* auxiliary function, accumulator is bst
   bstFromList2Aux(+List, +Accumulator, -Bst) */
bstFromList2Aux([], Acc, Acc) :- !.
bstFromList2Aux([H|T], Acc, Res) :-
    bstInsert(H, Acc, SubRes),
    bstFromList2Aux(T, SubRes, Res),
    !.

/* return list of elements, from traversing bst in in-order (left, val, right)
   bstInOrder(+Bst, -Res) */
bstInOrder(nil, []) :- !.
bstInOrder(bst(Val, nil, nil), [Val]) :- !.
bstInOrder(bst(Val, L, R), Res) :-
    bstInOrder(L, ResL),
    bstInOrder(R, ResR),
    appendList(ResL, [Val|ResR], Res),
    !.

/* append list1 behind list2
   appendList(+List1, +List2, -Result) */
appendList([], List2, List2) :- !.
appendList(List1, [], List1) :- !.
appendList([H1|T1], [H2|T2], [H1|SubRes]) :- appendList(T1, [H2|T2], SubRes), !.

/* sort list, which does not contain duplicity
   treeSort(+List, -SortedList) */
treeSort(List, SortedList) :-
    bstFromList(List, Bst),
    bstInOrder(Bst, SortedList),
    !.

/* delete element from bst
   bstDelete(+Element, +Bst, -Res) */
bstDelete(_, nil, nil) :- !.
bstDelete(Element, bst(Element, nil, nil), nil) :- !.
bstDelete(Element, bst(Element, nil, R), R) :- !.
bstDelete(Element, bst(Element, L, nil), L) :- !.
bstDelete(Element, bst(Element, L, R), bst(MostLeft, L, RWithoutMostLeft)) :-
    bstMostLeft(R, MostLeft),
    bstDelete(MostLeft, R, RWithoutMostLeft),
    !.
bstDelete(Element, bst(Val, L, R), bst(Val, NewL, R)) :-
    Element < Val,
    bstDelete(Element, L, NewL),
    !.
bstDelete(Element, bst(Val, L, R), bst(Val, L, NewR)) :-
    Element > Val,
    bstDelete(Element, R, NewR),
    !.

/* return most left element from bst
   bstMostLeft(+Bts, -MostLeftElement) */
bstMostLeft(bst(Val, nil, _), Val) :- !.
bstMostLeft(bst(_, L, _), Res) :- bstMostLeft(L, Res), !.
