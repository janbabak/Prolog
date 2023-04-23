r() :- reconsult("mergeSort.pl").

% return length of list
% list_lenght(+List, -Length)
list_length([], 0) :- !.
list_length([_|T], Len) :-
    list_length(T, Len2),
    Len is Len2 + 1.

% delete las N elements from list - return first half
% delete_last_N(+List, +N, -NewList)
delete_last_N(List, 0, List) :- !.
delete_last_N(List, N, Res) :-
    N > 0,
    pop_back(List, List2),
    N2 is N - 1,
    delete_last_N(List2, N2, Res),
    !.

% pop last element from list
% pop_back(+List, -Result)
pop_back([], []) :- !.
pop_back([_], []) :- !.
pop_back([H|T], [H|SubRes]) :-
     pop_back(T, SubRes),
     !.

% delete first N elements from list - return second half
% delete_first_N(+List, +N, -NewList)
delete_first_N([], _, []).
delete_first_N(List, 0, List) :- !.
delete_first_N([_], _, []) :- !.
delete_first_N([_|T], N, Res) :-
    N > 0,
    N2 is N - 1,
    delete_first_N(T, N2, Res),
    !.

% split list into 2 halfs
% split(+List, -List1, -List2)
split([], [], []) :- !.
split(List, FirstHalf, SecondHalf) :-
    list_length(List, ListLength),
    Length1 is ListLength // 2,
    Length2 is ListLength - Length1,
    delete_first_N(List, Length1, SecondHalf),
    delete_last_N(List, Length2, FirstHalf),
    !.


% merge 2 sorted lists into one
% merge(+List1, +List2, -MergedList)
merge([], [], []) :- !.
merge(List1, [], List1) :- !.
merge([], List2, List2) :- !.
merge([H1|T1], [H2|T2], [H1|Res]) :-
    H1 =< H2,
    merge(T1, [H2|T2], Res),
    !.
merge([H1|T1], [H2|T2], [H2|Res]) :-
    H1 > H2,
    merge([H1|T1], T2, Res).

% merge sort
% merge_sort(+List, -SortedList)
merge_sort([], []) :- !.
merge_sort([H1], [H1]) :- !.
merge_sort([A, B], [A, B]) :-
    A =< B,
    !.
merge_sort([A, B], [B, A]) :-
    A > B,
    !.
merge_sort(List, Sorted) :-
    split(List, List1, List2),
    merge_sort(List1, SubRes1),
    merge_sort(List2, SubRes2),
    merge(SubRes1, SubRes2, Sorted),
    !.
