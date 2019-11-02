%%%% Misja 1 - Długość listy %%%%

% Długość listy powinna działać tak samo jak tłumaczenie liczby Peano na liczbę naturalną (de facto długość liczby Peano). 
% Poniżej znajduje się definicja długości liczby Peano, 
% proszę napisać analogiczną definicję dla list list_number/2

% peano_number(liczba peano, liczba naturalna)
peano_number(zero, 0).
peano_number(s(P), Z) :-
    peano_number(P, Y),
    Z is Y + 1.

list_number([],0).
list_number([_|X],L) :- 
    list_number(X, Y),
	L is Y + 1.

%%%%% Misja 2 - Łączenie list %%%%

% Dodawanie list to nic innego jak połączenie ich (konkatenacja) w jedną dużą listę, np. [a,b,c] + [1,2,3] = [a,b,c,1,2,3] . 
% Poniżej znajduje się definicja dodawania liczb Peano, 
% proszę napisać analogiczną definicję sklejania list.

% peano_add(liczba peano, liczba peano, liczba peano)
peano_add(X, zero, X).
peano_add(X, s(Y), s(Z)) :- peano_add(X, Y, Z).


list_add([], L, L).
list_add([A|T], X, [A|P]) :- list_add(T, X, P).

%%%% Misja 3 - Map/Filter/Reduce w akcji %%%%

% Proszę zaimplementować dwa predykaty list_number_mfr/2 i list_add_mfr/3, które będą dawać te same wyniki, co list_number/2 i list_add/3.
list_number_mfr(L, Length) :- foldl(increment, L, 0, Length).
list_add_mfr(L1, L2, L3) :- reverse(L1, RL1), foldl(add, RL1, L2, L3).

increment(_,P,W) :- W is P + 1.
add(LI,P,[LI|P]). 