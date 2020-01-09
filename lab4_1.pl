%%% ZADANIE 1 %%%
% Napisz rekurencyjny predykat usuń/3, który usuwa z listy pierwsze wystąpienie danego elementu
usun(Element, [Element|List], List).
usun(Element, [OtherElement|List], [OtherElement|Filtred]) :- 
    Element \= OtherElement, 
    usun(Element,List,Filtred).

%%% ZADANIE 2 %%%
% Napisz rekurencyjny predykat usuń_wszystkie/3, który usuwa wszystkie wystąpienia danego elementu z listy
usun_wszystkie(_, [], []).
usun_wszystkie(Element, [Element|List], Filtred) :- 
    usun_wszystkie(Element,List,Filtred).
usun_wszystkie(Element, [OtherElement|List], [OtherElement|Filtred]) :- 
    Element \= OtherElement, 
    usun_wszystkie(Element,List,Filtred). 

%%% ZADANIE 3 %%%
% Napisz predykat dodaj/3, który dodaje element do listy na dowolnym jej indeksie
% np. dodaj(3,[1,2,1,2],X) da wynik X = [3,1,2,1,2] lub X = [1,3,2,1,2] lub ....
dodaj(Element, List, Result) :- usun(Element, Result, List).

%%% ZADANIE 4 %%%
% Lista jest palindromem, jeżeli czyta się jej elementy od prawej tak samo jak od lewej.
% Napisz predykat palindrom/1, który sprawdzi czy lista jest palindromem.
palindrom(List) :- reverse(List, List).

%%% ZADANIE 5 %%%
% Lista L2 jest podlistą L1 jeżeli znajdują się w niej jedynie elementy L1 (niekoniecznie wszystkie), w tej samej kolejności co w L1.
% Proszę napisać predykat podlista/2, który znajduje podlistę dla zadanej listy. 
% Dla zapytania podlista([a,b,c],X) mamy osiem możliwych wyników, gdzie X może być równy: [a,b,c], [a,b], [a,c], [a], [b,c], [b], [c], [].
podlista([], []).
podlista([Head|List], [Head|SubList]) :- podlista(List, SubList).
podlista([_|List], SubList) :- podlista(List, SubList). 

%%% ZADANIE 6 %%%
% Używając predykatów length/2 i append/3 napisz predykaty odetnij_z_lewej/3 i _odetnij_z_prawej/3, 
% które odcina zadaną liczbę elementów z początku lub końca listy.
odetnij_z_lewej(Length, List, Result) :- 
    length(Cut, Length), 
    append(Cut, Result, List).
odetnij_z_prawej(Length, List, Result) :-
    length(Cut, Length),
    append(Result, Cut, List).

%%% ZADANIE 7 %%%
% Napisz predykat zawiera/2, który sprawdza, czy lista L1 nie zawiera w sobie listy L2, 
% tj. dla zapytania zawiera([1,2,3,4],[2,3]) zwróci true, ponieważ [2,3] zawiera się w [1,2,3,4].
% Główna różnica od podlisty/2 polega na tym, że elementy L2 muszą występować obok siebie w L1.
zawiera(_, []).
zawiera(List, SubList) :- append([_,SubList,_], List), SubList \= [].

%%% ZADANIE 8 %%%
% Napisz predykat permutacja/2, który znajduje permutację zadanej listy 
% (permutacja ma te same elementy, ale niekoniecznie w tej samej kolejności).
permutacja([],[]).
permutacja([Head|List], Redsult) :- permutacja(List, Permuted), dodaj(Head, Permuted, Redsult).

%%% ZADANIE 9 %%%
% Napisz predykat podziel/3, który dzieli listę na dwie listy o możliwie zbliżonej długości.
%%% ROZWIAZANIE 1 %%%
podziel([SingleElement], [SingleElement], []).
podziel([Left,Right], [Left], [Right]).
podziel([Left,Right|Rest], [Left|LeftPart], [Right|RightPart]) :- podziel(Rest, LeftPart, RightPart).

%%% ZADANIE 10 %%%
% Napisz predykat spłaszcz/2, który zamieni listę list w płaską listę:
splaszcz([], []).
splaszcz(Element, [Element]) :- \+ is_list(Element).
splaszcz([Head|Tail], Result) :- splaszcz(Head, FlattedHead),
    splaszcz(Tail, FlattedTail),
    append(FlattedHead, FlattedTail, Result).