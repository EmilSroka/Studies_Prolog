%%% WSTĘP %%%
% Długość listy powinna działać tak samo jak tłumaczenie liczby Peano na liczbę naturalną (de facto długość liczby Peano). 
% Poniżej znajduje się definicja długości liczby Peano.

% peano_number(liczba peano, liczba naturalna)
peano_number(zero, 0).
peano_number(s(P), Z) :-
    peano_number(P, Y),
    Z is Y + 1.

% Dodawanie list to nic innego jak połączenie ich (konkatenacja) w jedną dużą listę, np. [a,b,c] + [1,2,3] = [a,b,c,1,2,3] . 
% Poniżej znajduje się definicja dodawania liczb Peano.

% peano_add(liczba peano, liczba peano, liczba peano)
peano_add(X, zero, X).
peano_add(X, s(Y), s(Z)) :- peano_add(X, Y, Z).

%%% ZADANIE 1 %%%
% Proszę napisać definicję dla list list_number/2
list_number([],0).
list_number([_|SubList], Length) :- 
    list_number(SubList, SubResult),
	Length is SubResult + 1.


%%% ZADANIE 2 %%%
% Proszę napisać definicję sklejania list.
list_add([], List, List).
list_add([CurrentItem|SubList], SecondList, [CurrentItem|SubResult]) :- list_add(SubList, SecondList, SubResult).


%%%% ZADANIE 3 %%%%
% Proszę za pomocą Map/Filter/Reduce zaimplementować dwa predykaty list_number_mfr/2 i list_add_mfr/3, 
% które będą dawać te same wyniki, co list_number/2 i list_add/3.
list_number_mfr(List, Length) :- foldl(increment, List, 0, Length).

list_add_mfr(List1, List2, Result) :- foldl(add, List1, [], ReversedList1), foldl(add, ReversedList1, List2, Result).

increment(_, Acc, Res) :- Res is Acc + 1.

add(Item, Acc, [Item|Acc]). 