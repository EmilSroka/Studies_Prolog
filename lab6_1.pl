%%% ZADANIE 1 %%%
% Napisz metapredykat func_call/3, który:
% - jako pierwszy argument przyjmie nazwę funkcji, np. length/2/2
% - jako drugi argument przyjmie listę argumentów wejściowych
% - jako trzeci argument przyjmie zmienną, która przechowa wynik funkcji.
func_call(Name/_/Index, Args, Result) :- !,
    nth1(1, FuncAndArgs, Name, Args),
    nth0(Index, FullArray, Result, FuncAndArgs),
    Function =.. FullArray,
    call(Function).

%%% ZADANIE 2 %%%
% Dopisz do bazy dodatkową wersję func_call/3, która zakłada, że zawsze ostatni argument jest wyjściowy:
func_call(Name/Index, Args, Result) :- func_call(Name/Index/Index, Args, Result).

func_call(Name, Args, Result) :- 
    current_predicate(Name/Index),
    func_call(Name/Index/Index, Args, Result).

%%% ZADANIE 3.1 %%%
% Naszemu funkcyjnemu językowi brakuje składni, pisanie ręcznie func_call nie wydaje się warte zachodu. 
% Proszę w bazie pod func_call/3 zdefiniować dwa operatory:
% - operator przypisania wyniku funkcji do zmiennej <# 
%   - można zasugerować się definicją wbudowanego operatora is, z którą można zapoznać się w dokumentacji op/2
% - operator aplikacji argumentów do funkcji #
%   - ten operator musi wiązać mocniej od <#
% Następnie należy zdefiniować predykat <#/2, który zwyczajnie wykonuje func_call na swoich argumentach.
:- op(700, xfy, <#).
:- op(600, xfy, #).

% Result <# Function # Args :- func_call(Function, Args, Result).

%%% ZADANIE 3.2 %%%
% Pójdźmy jeszcze krok dalej i pozbądźmy się tych nadmiarowych kwadratowych nawiasów. 
% Należy zdefiniować operator # w taki sposób, żeby pozwolił na łańcuchowanie w prawą stronę. 
% Następnie trzeba poprawić definicję predykatu <# tak, żeby zebrał wszystkie argumenty # w listę:
Result <# Function # ArgsChain :- parse_args_chain(ArgsChain, ArgsList),
    func_call(Function, ArgsList, Result).

parse_args_chain(Arg1 # Arg2, [Arg1|SubResult]) :- !, parse_args_chain(Arg2, SubResult).
parse_args_chain(Arg, [Arg]).

%%% WSTĘP %%%
% Currying to nic innego jak dekompozycja funkcji wieloargumentowej na wiele funkcji jednoargumentowych. 
% Jeżeli funkcja przyjmuje 2 argumenty (jak nasz append), to wywołanie z pierwszym argumentem powinno zwrócić nową funkcję append, 
% której pierwszy argument już jest ustawiony i która tylko czeka na drugi argument.

%%% ZADANIE 4 %%%
% Zdefiniuj predykat curry_call/3 o argumentach:
% 1. funkcja, np. function(append/3/3, []), gdzie drugi argument to lista zapamiętanych argumentów wejściowych funkcji - na początku pusta lista
% 2. jeden argument wejściowy
% 3. wynik 
curry_call(function(Function/NoOfArgs/ResultIndex, Args), Arg, Result) :-
    append(Args, [Arg], NewArgs),
    length(NewArgs, Length),
    handle_curry(Function/NoOfArgs/ResultIndex, NewArgs, Length, Result), !.

curry_call(function(Function/NoOfArgs, Args), Arg, Result) :- 
    curry_call(function(Function/NoOfArgs/NoOfArgs, Args), Arg, Result).

curry_call(function(Function, Args), Arg, Result) :- 
    current_predicate(Function/Index),
    curry_call(function(Function/Index, Args), Arg, Result).

handle_curry(Function/NoOfArgs/ResultIndex, Args, Length, Result) :- 
    NoOfArgs is Length + 1, 
    func_call(Function/NoOfArgs/ResultIndex, Args, Result). 

handle_curry(Function/NoOfArgs/ResultIndex, Args, Length, Result) :- 
    \+ NoOfArgs is Length + 1, 
    Result = function(Function/NoOfArgs/ResultIndex, Args). 

%%% ZADANIE 5 %%%
% Cel jest prosty, chcemu zamiast powyższego potwora móc pisać:
% X <# append/3 # [1,2] # [3,4].
:- op(700, xfy, <#-).
:- op(600, xfy, #-).

Result <#- Function #- ArgsChain :-
    initial_function(Function, IF), 
    curry(IF, ArgsChain, Result).

initial_function(function(F,A), function(F,A)) :- !.
initial_function(F, function(F, [])).
                    
%curry(F, A #- T, Result) :-
%    !, curry_call(F, A, SubResult),
%    curry(SubResult, T, Result).

%curry(F, A, Result) :-
%    curry_call(F, A, Result).

%%% ZADANIE 5 %%%
% Proszę zdefiniować jednoargumentowy prefiksowy operator #, który będzie służył do zagnieżdżania wywołań.
:- op(600, fx, #).

curry(F, A #- T , Result) :-
    !, curry_unpack(A, UnpackedA),
    curry_call(F, UnpackedA, SubResult),
    curry(SubResult, T, Result).

curry(F, A, Result) :-
    curry_unpack(A, UnpackedA),
    curry_call(F, UnpackedA, Result).

curry_unpack(#(OtherFunction #- OtherArgs), OtherResult) :-
    !, OtherResult <#- OtherFunction #- OtherArgs.

curry_unpack(A, A).