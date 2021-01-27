r() :- reconsult("occurrenceCounter.pl").
% count numbers of occurrences of all numbers in list
% e.g. result of [1, 2, 3, 2, 1] is [[1, 2], [2, 2], [3, 1]]
% count_all(+List, -CountedValues)
count_all([], []) :- !.
count_all([H|T], [[H, CntH]|Res]) :-
    count(H, [H|T], CntH),
    delete_all([H|T], H, DeletedH),
    count_all(DeletedH, Res),
    !.

% delete all occurrences of element from list
% delete_all(+List, +Element, -ListWithoutElements)
delete_all([], _, []).
delete_all([H|T], H, Res) :- delete_all(T, H, Res), !.
delete_all([H|T], Element, [H|Res]) :-
    H \= Element,
    delete_all(T, Element, Res).

% return number of occurences of element in list
% count(+Element, +List, -NumOfOccurrences)
count(_, [], 0) :- !.
count(E, [E|T], Cnt2) :- count(E, T, Cnt), Cnt2 is Cnt + 1. 
count(E, [H|T], Cnt) :-
    E \= H,
    count(E, T, Cnt),
    !.