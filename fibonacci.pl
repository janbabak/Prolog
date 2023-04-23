r() :- reconsult("fibonacci.pl").
/* 
    0 -> 0,
    1 -> 1,
    2 -> 1,
    3 -> 2,
    4 -> 3,
    5 -> 5,
    6 -> 8,
    7 -> 13,
    8 -> 21
       .
       .
       .
*/

% my_fibonacci(+N, -FibOfN)
my_fibonacci(0, 0) :- !.
my_fibonacci(1, 1) :- !.
my_fibonacci(N, Result) :- !,
    N2 is N - 1,
    N3 is N - 2,
    my_fibonacci(N2, Result2),
    my_fibonacci(N3, Result3),
    Result is Result2 + Result3.
    