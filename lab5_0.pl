mapuj(_, [], []).
mapuj(Predykat, [H|T], [MH|MT]) :-
    Zapytanie =.. [Predykat, H, MH],
    call(Zapytanie),
    mapuj(Predykat, T, MT).

razy_dwa(X,Y) :- Y is X * 2.

% mapuj(razy_dwa, [1,2,3], Wynik).

