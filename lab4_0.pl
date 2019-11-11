translate(Item, NewItem) :- NewItem is Item + 1. % increment by one
condition(Item) :- string(Item). % is string
% reducer(Item1, Item2, Result) :- Result is Item1 + Item2. % sum
reducer(Item1, Item2, Result) :- Result = [Item1 | Item2]. % reverse 

map([], []).
map([H | T], [NewH | NewT]) :-
    translate(H, NewH),
    map(T, NewT).

filter([], []).
filter([H | T], [H | FilteredT] ) :-
    condition(H),
    filter(T, FilteredT).
filter([H | T], FilteredT) :-
    \+ condition(H),
    filter(T, FilteredT).

reduce([], Accumulator, Accumulator).
reduce([H | T], Accumulator, Result) :-
    reducer(H, Accumulator, NewAccumulator),
    reduce(T, NewAccumulator, Result).

% is_member(_, []) :- fail.
is_member(E, [E | _]).
is_member(E, [H | T]) :-
    E \= H, 
    is_member(E, T).


    


