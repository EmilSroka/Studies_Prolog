%%% WSTĘP %%%
% Na potrzeby zadań
:- use_module(library(assoc)).

% Może się przydać predykat wkładający elementy do listy na wskazanym indeksie
insert(Element, 0, Lista, [Element|Lista]).
insert(Element, I, [H|T], [H|NT]) :-
    I > 0,
    NI is I - 1,
    insert(Element, NI, T, NT).


%%% ZADANIE 1 %%%
% Napisz własną wersję call/1, która traktuje predykat jako funkcję. 
% Ostatni argument predykatu jest traktowany jako wynik zapytania i jest zapisywany w zmiennej podanej jako drugi argument
func_call(Predicate, Result) :- call(Predicate, Result). 

%%% ZADANIE 2 %%%
% func_call/3 działa tak samo jak func_call/2, z tą różnicą, że zmienna przechowująca wynik nie musi być ostatnim argumentem predykatu
func_call(Predicate, Index, Result) :-
    Predicate =.. List, 
    insert(Result, Index, List, Query),
    Function =.. Query,
    call(Function). 

%%% ZADANIE 3 %%%
% Napisz predykat include_assoc/3, który filtruje tablicę asocjacyjną (drugi argument) zadanym predykatem (pierwszy argument) 
% i zapisuje wynik w trzecim argumencie. Predykat ma działać analogicznie do include/3. 
% Predykat filtrujący powinien przyjmując jako argument parę klucz-wartosc.
klucz_mniejszy_od_wartosci(K-V) :- K < V.

include_assoc(_, Assoc, Assoc) :- empty_assoc(Assoc).
include_assoc(Predicate, Assoc, Result) :- 
    del_min_assoc(Assoc, Key, Value, SubAssoc),
    include_assoc(Predicate, SubAssoc, Filtered),
    handle_element(Filtered, Key-Value, Predicate, Result).

handle_element(Assoc, Key-Value, Predicate, Result) :- 
    call(Predicate, Key-Value),
    put_assoc(Key, Assoc, Value, Result).
handle_element(Assoc, Key-Value, Predicate, Assoc) :- \+ call(Predicate, Key-Value).

%%% TEST %%
% list_to_assoc([1-2,7-4,5-6], A), include_assoc(klucz_mniejszy_od_wartosci, A, R), assoc_to_list(R, Wynik),Wynik = [1-2,5-6].

%%% ZADANIE 4 %%%
% Wzorując się na na predykacie mapuj/3, napisz predykat reduce/4, który będzie zachowywał się dokładnie tak samo jak foldl/4:
% reduce(Predicate, List, Accumulator, Result)
reduce(_, [], Accumulator, Accumulator).
reduce(Predicate, [Head|Rest], Accumulator, Result) :-
    call(Predicate, Head, Accumulator, SubResult),
    reduce(Predicate, Rest, SubResult, Result).

%%% TEST %%%
dodaj(X,Y,Z) :- Z is X + Y.
% reduce(dodaj, [1,2,3], 0, X), X = 6.

%%% ZADANIE 5 %%%
% Napisz predykat findall_assoc/3, który działa dokładnie tak samo jak findall/3, zamiast listy tworząc jednak tablicę asocjacyjną. 
% Znalezione wartości mają być kluczami tablicy, ich wartości mogą być dowolne, np. mogą być stałą t.
% Polecam zacząć od odtworzenia zwykłego findall, dopiero potem do przejścia na tablicę asocjacyjną
:- dynamic save/1.

findall_list(X, Query, Result) :-
    forall(call(Query), assert(save(X))),
    findallSave(Result).

findallSave(Result) :- retract(save(X)),
    findallSave(SubResult),
    Result = [X | SubResult], !.
findallSave([]) :- \+ retract(save(_)).

findall_assoc(X, Query, Result) :-
    forall(call(Query), assert(save(X))),
    retrieve_data(Result).

retrieve_data(Result) :- retract(save(X)),
    retrieve_data(SubResult),
    put_assoc(X, SubResult, t, Result), !.
retrieve_data(Assoc) :- \+ retract(save(_)),
    empty_assoc(Assoc).

%%% TEST %%%
% findall_assoc(X, between(1,5,X), Tablica), assoc_to_list(Tablica, [1-t,2-t,3-t,4-t,5-t]).