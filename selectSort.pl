r() :- reconsult("selectSort.pl").

% select sort
% select_sort(+List, -sortedList)
select_sort([], []) :- !.
select_sort([H], [H]) :- !.
select_sort(List, [Min|SortedRest]) :-
    find_min(List, Min),
    delete_first(List, Min, ListWithoutMin),
    select_sort(ListWithoutMin, SortedRest),
    !.

% find minimum of list
% find_min(+List, -Min)
find_min([H], H) :- !.
find_min([H|T], H) :-
    find_min(T, MinOfT),
    H =< MinOfT,
    !.
find_min([H|T], MinOfT) :-
    find_min(T, MinOfT),
    H > MinOfT,
    !.

% delete first occurrence of element from list
% delete_first(+List, +Element, -ListWithoutElement)
delete_first([], _, []).
delete_first([H|T], H, T) :- !.
delete_first([H|T], Element, [H|Res]) :-
    H \= Element,
    delete_first(T, Element, Res).
    