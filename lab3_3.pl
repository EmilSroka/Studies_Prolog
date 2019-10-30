% peano_number(liczba peano, liczba naturalna)
peano_number(zero, 0).
peano_number(s(P), Z) :-
    peano_number(P, Y),
    Z is Y + 1.

list_number([],0).
list_number([_|X],L) :- 
    list_number(X, Y),
	L is Y + 1.


% peano_add(liczba peano, liczba peano, liczba peano)
peano_add(X, zero, X).
peano_add(X, s(Y), s(Z)) :- peano_add(X, Y, Z).

list_add([], L, L).
list_add([A|T], X, [A|P]) :- list_add(T, X, P).



increment(_,P,W) :- W is P + 1.
list_number_mfr(L, Length) :- foldl(increment, L, 0, Length).

add(LI,P,[LI|P]). 
list_add_mfr(L1, L2, L3) :- reverse(L1, RL1), foldl(add, RL1, L2, L3).