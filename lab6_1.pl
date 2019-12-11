%%% 1
func_call(Name/_/Index, Args, Result) :-
    nth1(1, FuncAndArgs, Name, Args),
    nth0(Index, FullArray, Result, FuncAndArgs),
    Function =.. FullArray,
    call(Function), !.

% func_call(length/2/2, [[1,2,3]], X).
% func_call(append/3/2, [[1,2],[1,2,3,4]], X).


%%% 2
func_call(Name/Length, Args, Result) :- 
    func_call(Name/_/Length, Args, Result), !.

% func_call(length/2, [[1,2,3]], X).
% func_call(append/3, [[1,2],[1,2,3,4]], X).

func_call(Name, Arguments, Result) :- 
    current_predicate(Name/Length),
    func_call(Name/_/Length, Arguments, Result), !.

/*
func_call(Name, Arguments, Result) :- 
    length(Arguments, L), Index is L + 1,
    func_call(Name/_/Index, Arguments, Result), !.
*/

% func_call(length, [[1,2,3]], X).
% func_call(append, [[1,2],[1,2,3,4]], X).


%%% 3
:- op(700, xfy, <#).
:- op(600, yfx, #).

/*
Result <# Function # Args :- 
    func_call(Function, Args, Result). 
*/
% X <# length/2 # [[1,2,3]]
% X <# append/3 # [[1,2],[3,4]]

/*
Result <# Function # ArgsChain :- 
    parse_args_chain(ArgsChain, Args),
    func_call(Function, Args, Result).

parse_args_chain(H # T, [H|TArgs]) :- 
    !, parse_args_chain(T, TArgs).
    
parse_args_chain(H, [H]).
*/

% X <# length/2 # [1,2,3]
% X <# append/3 # [1,2] # [3,4]


%%% 4
curry_call(function(Function/NoOfArgs/ResultIndex, Args), Arg, Result) :-
    append(Args, [Arg], NewArgs),
    length(NewArgs, Length),
    ( 
        NoOfArgs is Length + 1 ->
        func_call(Function/NoOfArgs/ResultIndex, NewArgs, Result) ;
        Result = function(Function/NoOfArgs/ResultIndex, NewArgs)
    ), !.

% curry_call(function(append/3/3, []), [1,2], X), curry_call(X, [3,4], Y).

curry_call(function(Function/NoOfArgs, Args), Arg, Result) :- 
    curry_call(function(Function/NoOfArgs/NoOfArgs, Args), Arg, Result).

curry_call(function(Function, Args), Arg, Result) :- 
    current_predicate(Function/Index),
    curry_call(function(Function/Index, Args), Arg, Result).


%%% 5
/*
Result <# Function # ArgsChain :-
    initial_function(Function, IF),
    curry(IF, ArgsChain, Result), !.

initial_function(function(F,A), function(F,A)) :- !.
initial_function(F, function(F, [])).
                    
curry(F, A # T, Result) :-
    !, curry_call(F, A, SubResult),
    curry(SubResult, T, Result).

curry(F, A, Result) :-
    curry_call(F, A, Result).
*/

% X <# append/3 # [1,2], Y <# X # [3,4].

%%% 6
% :- op(600, fx, #).

Result <# Function # ArgsChain :-
    initial_function(Function, IF),
    curry(IF, ArgsChain, Result), !.

initial_function(function(F,A), function(F,A)) :- !.
initial_function(F, function(F, [])).

/* 
curry(F, A # T , Result) :-
    !, ( 
        A = # (OtherFunction # OtherArgs) ->
        Sub <# OtherFunction # OtherArgs, curry(F, Sub # T ,Result) ;
        curry(F, A, SubResult), curry(SubResult, T, Result)
    ).

curry(F, A, Result) :-
    (  
        A = # (OtherFunction#OtherArgs) -> 
        Sub <# OtherFunction # OtherArgs, curry(F, Sub, Result) ;
        curry_call(F, A, Result)
    ).
*/


curry(F, A # T , Result) :-
    !, curry_unpack(A, UnpackedA),
    curry_call(F, UnpackedA, SubResult),
    curry(SubResult, T, Result).

curry(F, A, Result) :-
    curry_unpack(A, UnpackedA),
    curry_call(F, UnpackedA, Result).

curry_unpack(#(OtherFunction # OtherArgs), OtherResult) :-
    !, OtherResult <# OtherFunction # OtherArgs.

curry_unpack(A, A).



%%% 7
/*
:- op(650, yfx, ##).

curry(_, A ## T , Result) :-
    !, 
    curry_unpack(A, UnpackedA),
    curry_unpack(T, UnpackedT),
    curry_call(UnpackedA, UnpackedT, Result).

curry(F, A # T , Result) :-
    !, 
    curry_unpack(A, UnpackedA),
    curry_call(F, UnpackedA, SubResult),
    curry(SubResult, T, Result).

curry(F, A, Result) :-
    curry_unpack(A, UnpackedA),
    curry_call(F, UnpackedA, Result).

curry_unpack(OtherFunction # OtherArgs, OtherResult) :-
    !, OtherResult <# OtherFunction # OtherArgs.

curry_unpack(A, A).
*/