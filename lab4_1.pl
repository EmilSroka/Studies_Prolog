% Napisz rekurencyjny predykat usuń/3, który usuwa z listy pierwsze wystąpienie danego elementu, 
% np. dla zapytania usuń(3,[1,3,2,1,2,3],X) oczekiwanym wynikiem jest X = [1,2,1,2,3].
usun(Element, [H | T], T) :- Element = H.
usun(Element, [H | T], [H | SubResult]) :- Element \= H, usun(Element, T, SubResult).

% Napisz rekurencyjny predykat usuń_wszystkie/3, który usuwa wszystkie wystąpienia danego elementu z listy, 
% np. dla zapytania usuń_wszystkie(3,[1,2,3,1,2,3],X) oczekiwanym wynikiem jest X = [1,2,1,2].
usun_wszystkie(_, [], []).
usun_wszystkie(Element, [H | T], [H | SubResult]) :- Element \= H, 
    usun_wszystkie(Element, T, SubResult).
usun_wszystkie(Element, [H|T], SubResult) :- Element = H, 
    usun_wszystkie(Element, T, SubResult).

% Napisz predykat dodaj/3, który dodaje element do listy na dowolnym jej indeksie, 
% np. dodaj(3,[1,2,1,2],X) da wynik X = [3,1,2,1,2] lub X = [1,3,2,1,2] lub ....
% Podpowiedzi: dodawanie elementu do odwrotność jego usuwania
dodaj(Element, List, Result) :- usun(Element, Result, List).

% Lista jest palindromem, jeżeli czyta się jej elementy od prawej tak samo jak od lewej. 
% Napisz predykat palindrom/1, który sprawdzi czy lista jest palindromem.
% Podpowiedzi: proszę użyć predykatu odwracającego listę
%%% palindrom(List) :- reverse(List, ReversedList), List = ReversedList.
palindrom(List) :- reverse(List, List).

% Lista L2 jest podlistą L1 jeżeli znajdują się w niej jedynie elementy L1 (niekoniecznie wszystkie), w tej samej kolejności co w L1. 
% Proszę napisać predykat podlista/2, który znajduje podlistę dla zadanej listy. 
% Dla zapytania podlista([a,b,c],X) mamy osiem możliwych wyników, gdzie X może być równy: 
% [a,b,c], [a,b], [a,c], [a], [b,c], [b], [c], [].
podlista([], []).
podlista([H | T], [H | SubList]) :- podlista(T, SubList).
podlista([_ | T], SubList) :- podlista(T, SubList).

% Używając predykatów length/2 i append/3 napisz predykaty odetnij_z_lewej/3 i _odetnij_z_prawej/3, 
% które odcina zadaną liczbę elementów z początku lub końca listy, np. dla odetnij_z_lewej(3,[1,2,3,4],X) powinno dać X=[4].
odetnij_z_lewej(Length, List, Result) :- 
    length(Cut, Length), 
    append(Cut, Result, List).
odetnij_z_prawej(Length, List, Result) :- 
    length(Cut, Length), 
    append(Result, Cut, List).

% Napisz predykat zawiera/2, który sprawdza, czy lista L1 zawiera w sobie listę L2, 
% tj. dla zapytania zawiera([1,2,3,4],[2,3]) zwróci true, ponieważ [2,3] zawiera się w [1,2,3,4].
/*
zawiera(_, []).
zawiera(Set, Subset) :- 
    append(Subset,_,Set), 
    Subset \= [].
zawiera([_ | Set], Subset) :- 
    zawiera(Set, Subset), 
    Subset \= [].
*/
zawiera( _, []).
zawiera( List, SubList) :- append([_,SubList,_], List), SubList \= [].

% Napisz predykat permutacja/2, który znajduje permutację zadanej listy (permutacja ma te same elementy, ale niekoniecznie w tej samej kolejności), 
% np. dla zapytania permutacja([d,w,a], X) otrzymamy X równe: [d,a,w], [w,d,a], [w,a,d], [a,d,w], [a,w,d]. 
% Me: a co z [d, w, a] ?
permutacja([],[]).
permutacja([H | T],Result) :- 
    permutacja(T, SubResult), 
    dodaj(H, SubResult, Result).

% Napisz predykat podziel/3, który dzieli listę na dwie listy o możliwie zbliżonej długości, np.
% podziel([1],L,P) da L=[1],P=[], podziel([1,2],L,P) da L=[1],P=[2], podziel([1,2,3],L,P) da L=[1,3],P=[2]
/* 
podziel(List, L, R) :- 
    append(L, R, List),
    length(L, LLength),
    length(R, RLength),
    ( LLength = RLength ; LLength is RLength + 1 ).
*/
podziel([], [], []).
podziel([H | T], [H | SL], SR) :- length(T, Length), 0 is Length mod 2, podziel(T, SL, SR).
podziel([H | T], SL, [H | SR]) :- length(T, Length), 1 is Length mod 2, podziel(T, SL, SR).

% Napisz predykat spłaszcz/2, który zamieni listę list w płaską listę:
% Podpowiedzi: 
% należy użyć append/3, 
% ostatni przykład a -> [a] pokazuje jak prosta wersja predykatu radzi sobie z nie-listami
% to zadanie jest trudne, warto je sobie zostawić na koniec
splaszcz([], []).
splaszcz(Element, [Element]) :- \+ is_list(Element).
splaszcz([H | T], Result) :- 
    \+ is_list(H), 
    splaszcz(T, FlattedT), 
    append([H], FlattedT, Result).
splaszcz([H | T], Result) :-
    is_list(H),
    splaszcz(H, FlattedH),
    splaszcz(T, FlattedT),
    append(FlattedH, FlattedT, Result).