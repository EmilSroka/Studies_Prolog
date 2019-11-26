%%% 1 
suma(A,B,C) :- C is A + B.

func_call(Predicate, Result) :-
    Predicate =.. List,
    append(List, [Result], ListWithResult),
    Query =.. ListWithResult,
    call(Query).

% func_call(suma(1,3),X), X = 4.

%%% 2
func_call(Predicate, Index, Result) :-
    Predicate =.. List,
    length(Empty,Index),
    append(Empty,Rest,List),
    append(Empty,[Result],Tmp),
    append(Tmp,Rest,QueryList),
    Query =.. QueryList,
    call(Query), !.


% func_call(append([1],[1,2,3]),2,X), X = [2,3].