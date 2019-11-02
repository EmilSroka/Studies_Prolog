:- dynamic byli/2.

ksiazka(16, 'Flatlandia', autor('Edwin Abbott Abbott', 1838-1926), wydanie('Seel & Co', 1884)). 
ksiazka(28, 'R.U.R.', autor('Karel Čapek', 1890-1938), wydanie('Players Press', 2002)).
ksiazka(29, 'Daszeńka, czyli żywot szczeniaka', autor('Karel Čapek', 1890-1938), wydanie('Nasza Księgarnia', 1989)).
ksiazka(34, 'Kobieta z wydm', autor('Kobo Abe', 1924-1993), wydanie('Wydawnictwo Znak', 2007)).
ksiazka(56, 'Zamek', autor('Franz Kafka', 1883-1924), wydanie('Zielona Sowa', 2001)).
ksiazka(87, 'Gargantua i Pantagruel', autor('Francois Rabelais', 1494-1553), wydanie('Siedmioróg', 2004)).

% pomocnicze

znajdz_autora(Lista, Autor) :- Lista = [Tytul|_], ksiazka(_, Tytul, autor(Autor, _), _).
nachodza(S1-E1, S2-E2) :- S1 =< E2, E1 >= S2.
wiekszy([Autor,S-E], [_,Poprzedni], [Autor,Zyl]) :- 
    Zyl is E-S, Zyl > Poprzedni.
wiekszy([_,S-E], [Autor,Poprzedni], [Autor,Poprzedni]) :- 
    Zyl is E-S, Zyl =< Poprzedni.

% zapytania

autorzy_bez_duplikatow(Wynik) :- 
    setof(Autor, (A,B,C)^ksiazka(A, B, Autor, C), Wynik).

ksiazki_wydane_po_smierci_autora(Wynik) :- 
    findall(Tytul, (
        ksiazka(_, Tytul, autor(_, _-RokSmierci), wydanie(_,RokWydania)),  
        RokWydania > RokSmierci
    ), Wynik).

ksiazki_autorow(Wynik) :- 
    findall(Format, ( 
        bagof(Tytul, (A,B)^ksiazka(A, Tytul, _, B), Ksiazki), 
        znajdz_autora(Ksiazki, Imie), 
        Format = Imie - Ksiazki
    ), Wynik).

mogli_sie_spotkac(Wynik) :-
    findall([Autor1, Autor2], (
        ksiazka(_, _, autor(Autor1, P1-K1), _), 
        ksiazka(_, _, autor(Autor2, P2-K2), _),
        nachodza(P1-K1, P2-K2),
        Autor1 \= Autor2,
        \+ ( byli(Autor1, Autor2) ; byli(Autor2, Autor1) ),
        assert(byli(Autor1, Autor2))
    ), Wynik).

najdluzej_zyjacy_autor(Wynik) :- 
    setof([Imie, Okres], (A,B,C)^ksiazka(A, B, autor(Imie, Okres), C), Lista),
    foldl(wiekszy, Lista, ['', 0], Max), Max = [Wynik,_].