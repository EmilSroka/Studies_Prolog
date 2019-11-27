% Na potrzeby zadań
:- use_module(library(assoc)).

% Może się przydać predykat wkładający elementy do 
% listy na wskazanym indeksie
insert(Element, 0, Lista, [Element|Lista]).
insert(Element, I, [H|T], [H|NT]) :-
    I > 0,
    NI is I - 1,
    insert(Element, NI, T, NT).


%%% 1 
suma(A,B,C) :- C is A + B.

/*
func_call(Predicate, Result) :-
    Predicate =.. List,
    append(List, [Result], ListWithResult),
    Query =.. ListWithResult,
    call(Query).
*/

func_call(Predicate, Result) :- call(Predicate, Result).

% func_call(suma(1,3),X), X = 4.
% func_call(append([1],[2,3]),X), X = [1,2,3].
% func_call(length([1,2,3]), X), X = 3.

%%% 2
/*
func_call(Predicate, Index, Result) :-
    Predicate =.. List,
    length(Empty,Index),
    append(Empty,Rest,List),
    append(Empty,[Result],Tmp),
    append(Tmp,Rest,QueryList),
    Query =.. QueryList,
    call(Query), !.
*/

func_call(Predicate, Index, Result) :-
    Predicate =.. List,
    insert(Result, Index, List, ListWithResult),
    Query =.. ListWithResult,
    call(Query), !.

% func_call(append([1],[1,2,3]),2,X), X = [2,3].

%%% 3

klucz_mniejszy_od_wartosci(K-V) :- K < V.

include_assoc(_, Assoc, Assoc) :- Assoc == t, !.

include_assoc(Predicate, Assoc, Result) :- 
    foreach( gen_assoc(Key, Assoc, Value), (
        (min_assoc(Assoc, Key, Value) -> (
                del_min_assoc(Assoc, Key, Value, SubAssoc),
                include_assoc(Predicate, SubAssoc, SubResult),
                (func_call(Predicate, Key-Value) -> put_assoc(Key, SubResult, Value, Result) ; true)
            ) ; (
                true
        ))
    )), !.

% list_to_assoc([1-2,7-4,5-6], A), include_assoc(klucz_mniejszy_od_wartosci, A, R), assoc_to_list(R, Wynik), Wynik = [1-2,5-6].

%%% 4

dodaj(X,Y,Z) :- Z is X + Y.

reduce(_, [], X, X).
reduce(Predicate, [H | T], Accumulator, Result) :-
    Query =.. [Predicate, H, Accumulator, NewAccumulator],
    call( Query ),
    reduce(Predicate, T, NewAccumulator, Result).

% reduce(dodaj, [1,2,3], 0, X).

%%% 5
:- dynamic save/1.

findallSave(Result) :-
    ( retract( save(X) ) -> ( 
        findallSave(SubResult),
        Result = [X | SubResult]
    ) ; (
        Result = []   
    )). 
    
findallTest(X, Query, Result) :-
    forall(call(Query), assert( save(X) ) ),
    findallSave(Result).

findall_assoc_save(Result) :-
    ( retract( save(X) ) -> ( 
        findall_assoc_save(SubResult),
        put_assoc(X, SubResult, t, Result)
    ) ; (
        empty_assoc(Result)   
    )). 
    
findall_assoc(X, Query, Result) :-
    forall(call(Query), assert( save(X) ) ),
    findall_assoc_save(Result).

% findall_assoc(X, between(1,5,X), Tablica), assoc_to_list(Tablica, [1-t,2-t,3-t,4-t,5-t]).