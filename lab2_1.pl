:- assert(juz_byli(_,_) :- fail).

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
                     \+ ( juz_byli(X,Y) ; juz_byli(Y,X) ),
                     assert(juz_byli(X,Y)).
jest_krewnym(_,_) :- retractall( juz_byli(_,_) ).