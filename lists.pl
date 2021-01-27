r() :- reconsult("lists.pl").

% return true if list contains Value
% contain(+List, +Value)
contain([H|_], H).
contain([H|T], Value) :- H \= Value, contain(T, Value).

% return true is list does NOT contain Value
% not_contain(+List, +Value)
not_contain([], _).
not_contain([H|_], H) :- fail.
not_contain([H|T], Value) :- H \= Value, not_contain(T, Value).

% return n-th element from list indexed from 0
% nth(+List, +N, -List[N])
nth([H|_], 0, H) :- !.
nth([_|T], N, Element) :-
    N2 is N - 1,
    nth(T, N2, Element).

% return length of list
% list_lenght(+List, -Length)
list_length([], 0) :- !.
list_length([_|T], Len) :-
    list_length(T, Len2),
    Len is Len2 + 1.

% return lenght of list including sublists
% w_sublist_lenght(+List, -Length)
w_sublist_length([], 0) :- !. % first element is empty list
w_sublist_length([H|T], Len) :- % first element is a list
    is_list(H),
    w_sublist_length(H, Len2),
    w_sublist_length(T, Len3),
    Len is Len2 + Len3,
    !.
w_sublist_length([_|T], Len) :- % first element is not a list
    w_sublist_length(T, Len2),
    Len is Len2 + 1.

% push back element to list (append)
% push_back(+List, +Element, -List)
push_back([], Element, [Element]).
push_back([H|T], Element, [H|Res]) :- push_back(T, Element, Res).

% push element to front (prepend)
% push_front(+List, +Element, -List)
push_front([], Element, [Element]).
push_front([H|T], Element, [Element|Res]) :- push_front(T, H, Res).

% append List2 behind List1
% append(+List1, +List2, -ResultList)
append_list([], List2, List2).
append_list([H|T], List2, [H|Res]) :- append_list(T, List2, Res).

% delete first occurrence of element from list
% delete_first(+List, +Element, -ListWithoutElement)
delete_first([], _, []).
delete_first([H|T], H, T) :- !.
delete_first([H|T], Element, [H|Res]) :-
    H \= Element,
    delete_first(T, Element, Res).

% delete all occurrences of element from list
% delete_all(+List, +Element, -ListWithoutElements)
delete_all([], _, []).
delete_all([H|T], H, Res) :- delete_all(T, H, Res), !.
delete_all([H|T], Element, [H|Res]) :-
    H \= Element,
    delete_all(T, Element, Res).

% delete last occurrence of element from list
% delete_last(+List, +Element, -ListWithoutElement)
delete_last([], _, []) :- !.
delete_last([H|T], H, [H|Res]) :-
    contain(T, H),
    delete_last(T, H, Res),
    !.
delete_last([H|T], H, T) :- not_contain(T, H), !.
delete_last([H|T], Element, [H| Res]) :-
    H \= Element,
    delete_last(T, Element, Res),
    !.

% replase all occurrences of element in list by replacement
% replace(+List, +Element, +Replacement, -RerplacedList)
replace([], _, _, []).
replace([H|T], H, Replacement, [Replacement|Res]) :- replace(T, H, Replacement, Res), !.
replace([H|T], Element, Replacement, [H|Res]) :-
    Element \= H,
    replace(T, Element, Replacement, Res).

% return last element of list
% last(+List, -LastElement)
last([], []).
last([H], H) :- !.
last([_|T], Last) :- last(T, Last).

% return number of occurences of element in list
% count(+Element, +List, -NumOfOccurrences)
count(_, [], 0) :- !.
count(E, [E|T], Cnt2) :- count(E, T, Cnt), Cnt2 is Cnt + 1. 
count(E, [H|T], Cnt) :-
    E \= H,
    count(E, T, Cnt),
    !.

% flatten list
% flatten(+List, -FlattenList)
flatten([], []) :- !.
flatten([H|T], Res) :-
    is_list(H),
    flatten(H, FlattenH),
    flatten(T, FlattenT),
    append_list(FlattenH, FlattenT, Res),
    !.
flatten([H|T], [H|FlattenT]) :- flatten(T, FlattenT), !.

% reverse list - use auxiliary function with accumulator
% reverse(+List, -ReversedList)
reverse(List, Res) :- reverse_aux(List, [], Res).
% reverse_aux(+List, +Accumulator, -ReversedList)
reverse_aux([], Acc, Acc).
reverse_aux([H|T], Acc, Res) :- reverse_aux(T, [H|Acc], Res).

% check if list is sorted
% sorted(+List)
sorted(List) :- sorted_asc(List).
sorted(List) :- sorted_desc(List).
sorted_asc([]) :- !.
sorted_asc([_]) :- !.
sorted_asc([H1, H2|T]) :-
    H1 =< H2,
    sorted_asc([H2|T]),
    !.
sorted_desc([]) :- !.
sorted_desc([_]) :- !.
sorted_desc([H1, H2|T]) :-
    H1 >= H2,
    sorted_desc([H2|T]),
    !.

% return powerset (set of all subsets)
% power_set(+List, -PowerSetList)
% TODO
power_set( [], [[]]).
power_set( [X|Xs], PS) :-
  power_set(Xs, PS1),
  maplist( append([X]), PS1, PS2 ), % i.e. prepend X to each PS1
  append_list(PS1, PS2, PS).

% sum of list
% sum(+List, -Sum)
sum(List, Sum) :- sum_aux(List, 0, Sum), !.
sum_aux([], Accumulator, Accumulator) :- !.
sum_aux([H|T], Accumulator, Sum) :-
    Accumulator2 is Accumulator + H,
    sum_aux(T, Accumulator2, Sum),
    !.