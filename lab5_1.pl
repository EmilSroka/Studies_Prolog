%%% Negacja
% Do implementacji negacji potrzebne będą nam dwa elementy: call/1 i operator odcięcia !.
% Definicja negacji neg/1 brzmi następująco:
% - jeżeli udało się znaleźć chociaż jeden wynik zapytania, negacja ponosi porażkę
% - w innym wypadku negacja się powiodła Poniżej znajduje się miejsce na implementację negacji oraz dwa zapytania testowe:

neg(Predicate) :- call(Predicate), !, false.
neg(_).

% neg(5>4).
% neg(4>5).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% If Else
% Celem kolejne zadania jest zaimplementowanie predykatu ifelse/3, którego kolejne argumenty to:
% - zapytanie stanowiące warunek
% - zapytanie, które zostanie wykonane, jeżeli zapytanie warunkowe się powiedzie
% - zapytanie, które zostanie wykonane, jezeli zapytanie warunkowe się nie powiedzie
% Sama konstrukcja nie różni się szczególnie od negacji, ponownie należy się posłużyć operatorem odcięcia i call/1. Opcjonalnie można użyć operatora alternatywy.

ifelse(Condition, True, _) :- call(Condition), !, True.
ifelse(_,_,False) :- call(False).

% ifelse(5 > 4, writeln(prawda), writeln(fałsz))
% ifelse(4 > 5, writeln(prawda), writeln(fałsz))