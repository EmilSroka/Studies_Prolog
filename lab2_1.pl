%%% ZADANIE %%%
% Napraw predykat jest_krewnym/2 tak, żeby każda para krewnych pojawiała się w wynikach tylko raz. 
% Użyj w tym celu niedawno poznanych predykatów assert i retractall.

:- dynamic juz_byli/2.

jest_przodkiem(X,Y) :- jest_rodzicem(X,Y).
jest_przodkiem(X,Y) :- jest_rodzicem(Z,Y),
                       jest_przodkiem(X,Z).

% jest_rodzicem(imię rodzica, imię dziecka)
jest_rodzicem(kasia,robert).
jest_rodzicem(kasia,michal).
jest_rodzicem(tomek,robert).
jest_rodzicem(tomek,eliza).
jest_rodzicem(robert,miriam).

% jest_krewnym(X,Y) :- jest_przodkiem(Z,X),
%                      jest_przodkiem(Z,Y),
%     				 X \= Y.

jest_krewnym(X,Y) :- jest_przodkiem(Z,X),
                     jest_przodkiem(Z,Y),
                     X \= Y,
                     nie_byli(X,Y),
                     assert(juz_byli(X,Y)).
                    
jest_krewnym(_,_) :- retractall( juz_byli(_,_) ).

nie_byli(X,Y) :-  \+ juz_byli(X,Y), 
                  \+ juz_byli(Y,X).