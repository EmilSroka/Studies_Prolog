%%% WSTĘP %%%
% Definicja negacji neg/1 brzmi następująco:
% - jeżeli udało się znaleźć chociaż jeden wynik zapytania, negacja ponosi porażkę
% - w innym wypadku negacja się powiodła

%%% ZADANIE 1 %%%
% Zaimplementuj negację.
neg(Predicate) :- call(Predicate), !, false.
neg(_).


%%% ZADANIE 2 %%%
% Celem kolejne zadania jest zaimplementowanie predykatu ifelse/3, którego kolejne argumenty to:
% - zapytanie stanowiące warunek
% - zapytanie, które zostanie wykonane, jeżeli zapytanie warunkowe się powiedzie
% - zapytanie, które zostanie wykonane, jezeli zapytanie warunkowe się nie powiedzie
ifelse(Condition, WhenTrue, _) :- call(Condition), !, call(WhenTrue).
ifelse(_,_,WhenFalse) :- call(WhenFalse).