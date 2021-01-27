r() :- reconsult("unarySystem.pl").
/* numbers are reprezented in unary sztem by lists like this:
    0 = []
    1 = [x]
    2 = [x, x]
    3 = [x, x, x]
    4 = [x, x, x, x] 
 */

% zero(+Num) - check if number is zero
zero([]).

% return number incremented by 1
% successor(+Num, -IncrementedNum)
successor([], [x]).
successor([x|T], [x, x|T]).

% add 2 numbers
% add(+Num1, +Num2, -Sum)
add([], Num2, Num2) :- !.
add([x|T], Num2, [x|Res]) :- add(T, Num2, Res), !.

% multiply 2 numbers
% mul(+Num1, +Num2, -Product)
mul([], _, []) :- !.
mul([x], Num2, Num2) :- !.
mul([x|T], Num2, ResAdd) :-
    mul(T, Num2, ResMul),
    add(ResMul, Num2, ResAdd),
    !.