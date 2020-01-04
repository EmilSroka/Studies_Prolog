%%% ZADANIE %%%
% Proszę odpowiednio poprawić definicję predykatu trzeci_element/2
trzeci_element([_,_,Third|_], Third).

%%% ZADANIE %%%
% Proszę spróbować zdefiniować rekurencyjny predykat nty_element(Lista, N, Element), który pobiera n-ty element z listy.
nty_element([Element|_], 1, Element).
nty_element([_|SubArray], N, Element) :- NPredecessor is N-1,
                                         nty_element(SubArray, NPredecessor, Element).