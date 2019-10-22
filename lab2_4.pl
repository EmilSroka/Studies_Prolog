% We wspomnianej arytmetyce mamy jedną stałą, nazwijmy ją zero, która odpowiada zeru znanemu jeszcze z podstawówki. 
% Poza tym istnieje jeszcze jeden predykat następnika s (jak successor), która reprezentuję liczbę o jeden większą niż jego argument.
% Zatem, jezeli zero to 0, to s(zero) to 1, s(s(s(zero))) to 3, etc.

% Misja 1: tłumaczenie
% Liczby Peano mogą być ciut nieczytelne... 
% Uzupełnij predykat peano_number/2 tak, żeby tłumaczył liczby Peano na zwykłe liczby.

% Misja 2
% Podstawową operacją arytmetyki jest dodawanie. W arytmetyce Peano jest ono zdefiniowane przez dwa aksjomaty:
% -> x + zero = x
% -> . x + s(y) = s(x + y) Proszę zaimplementować predykat peano_add/3 implementujący powyższe aksjomaty.

% Misja 3: mnożenie
% Tu już bez zbędnych wstępów. Mamy dwa aksjomaty mnożenia:
% -> x * zero = zero
% -> x * s(y) = x * y + x Tym razem implementujemy peano_times/3:

% peano_number(s(s(s(zero))), X).
% peano_add(s(s(s(zero))), s(s(zero)), X), peano_number(X,R).
% peano_subtract(s(s(s(s(zero)))), s(s(zero)), X), peano_number(X,R).
% peano_times(s(s(s(zero))), s(s(zero)), X), peano_number(X,R).
% peano_greater_than(s(s(zero)), X).
% peano_divide(s(s(s(s(s(s(zero)))))), s(s(zero)), X), peano_number(X,R).
% peano_mod(s(s(s(zero))), s(s(zero)), X), peano_number(X,R).
% peano_is_even(s(s(zero))), peano_number(s(s(zero)),R).
% peano_is_odd(s(s(zero))), peano_number(s(s(zero)),R).

:- dynamic s/1.

% peano_number(liczba peano, liczba naturalna)
peano_number(X, Y) :- X = zero, Y = 0.
peano_number(X, Y) :- X = s(PredecessorX), peano_number(PredecessorX, PredecessorY), Y is PredecessorY + 1.

% peano_add(liczba peano, liczba peano, liczba peano)
peano_add(X, zero, X).
peano_add(X, Y, Z) :- Y = s(Predecessor), peano_add(X, Predecessor, Tmp), Z = s(Tmp).

peano_subtract(X, zero, X).
peano_subtract(X, Y, Z) :- Y = s(Predecessor), peano_subtract(X, Predecessor, Tmp), s(Z) = Tmp.

% peano_mul(liczba peano, liczba peano, liczba peano)
peano_times(_, zero, zero).
peano_times(X, Y, Z) :- Y = s(PredecessorY), peano_times(X, PredecessorY, Result1), peano_add(X, Result1, Z).

peano_greater_than(s(X),X).
peano_greater_than(s(X),Y) :- peano_greater_than(X,Y).

peano_divide(X,Y,zero) :- peano_greater_than(Y,X).
peano_divide(X,Y,Z) :- peano_subtract(X, Y, Dec), peano_divide(Dec, Y, Tmp), Z = s(Tmp).

peano_mod(X,Y,Z) :- peano_greater_than(Y,X), Z = X.
peano_mod(X,Y,Z) :- peano_subtract(X,Y,DifferenceXY), peano_mod(DifferenceXY, Y, Z).

peano_is_even(X) :- peano_mod(X,s(s(zero)),zero).
peano_is_odd(X) :- peano_mod(X,s(s(zero)),s(zero)).