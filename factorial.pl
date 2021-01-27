r() :- reconsult("factorial.pl").

% my_factorial(+N, -N!)
my_factorial(0, 1) :- !.
my_factorial(1, 1) :- !.
my_factorial(N, Result) :- !,
    N2 is N -1,
    my_factorial(N2, Result2),
    Result is Result2 * N.