%%% WSTĘP %%%
% Arytmetyka Peano
% We wspomnianej arytmetyce mamy jedną stałą, nazwijmy ją zero, która odpowiada zeru znanemu jeszcze z podstawówki. 
% Poza tym istnieje jeszcze jeden predykat następnika s (jak successor), która reprezentuję liczbę o jeden większą niż jego argument.
% Zatem, jezeli zero to 0, to s(zero) to 1, s(s(s(zero))) to 3, etc.

:- dynamic s/1.

%%% ZADANIE 1 %%%
% Liczby Peano mogą być ciut nieczytelne... 
% Uzupełnij predykat peano_number/2 tak, żeby tłumaczył liczby Peano na zwykłe liczby.

% peano_number(liczba peano, liczba naturalna)
peano_number(zero, 0).
peano_number(s(PeanoPredecessor), Int) :- peano_number(PeanoPredecessor, IntPredecessor), 
                                          Int is IntPredecessor + 1.

%%% ZADANIE 2 %%%
% Podstawową operacją arytmetyki jest dodawanie. W arytmetyce Peano jest ono zdefiniowane przez dwa aksjomaty:
% -> x + zero = x
% -> . x + s(y) = s(x + y) Proszę zaimplementować predykat peano_add/3 implementujący powyższe aksjomaty.

% peano_add(liczba peano, liczba peano, liczba peano)
peano_add(Peano, zero, Peano).
peano_add(Peano, s(PeanoAddendPredecessor), s(ResultPredecessor)) :- peano_add(Peano, PeanoAddendPredecessor, ResultPredecessor).

%%% ZADANIE 3 %%%
% Tu już bez zbędnych wstępów. Mamy dwa aksjomaty mnożenia:
% -> x * zero = zero
% -> x * s(y) = x * y + x Tym razem implementujemy peano_times/3:

% peano_times(liczba peano, liczba peano, liczba peano)
peano_times(_, zero, zero).
peano_times(Peano, s(FactorPredecessor), Result) :- peano_times(Peano, FactorPredecessor, Product), 
                                                    peano_add(Peano, Product, Result).
