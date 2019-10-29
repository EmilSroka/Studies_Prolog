% Proszę odpowiednio poprawić definicję predykatu trzeci_element/2
trzeci_element([_,_,Trzeci|_], Trzeci).

% Proszę spróbować zdefiniować rekurencyjny predykat nty_element(Lista, N, Element), który pobiera n-ty element z listy.
nty_element([Element|_], 1, Element).
nty_element(Lista, N, Element) :- [_|MniejszaLista] = Lista, MniejszeN is N-1, nty_element(MniejszaLista, MniejszeN, Element).