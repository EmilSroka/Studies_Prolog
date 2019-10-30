ksiazka(16, 'Flatlandia', autor('Edwin Abbott Abbott', 1838-1926), wydanie('Seel & Co', 1884)). 
ksiazka(28, 'R.U.R.', autor('Karel Čapek', 1890-1938), wydanie('Players Press', 2002)).
ksiazka(29, 'Daszeńka, czyli żywot szczeniaka', autor('Karel Čapek', 1890-1938), wydanie('Nasza Księgarnia', 1989)).
ksiazka(34, 'Kobieta z wydm', autor('Kobo Abe', 1924-1993), wydanie('Wydawnictwo Znak', 2007)).
ksiazka(56, 'Zamek', autor('Franz Kafka', 1883-1924), wydanie('Zielona Sowa', 2001)).
ksiazka(87, 'Gargantua i Pantagruel', autor('Francois Rabelais', 1494-1553), wydanie('Siedmioróg', 2004)).

:- dynamic byli/2.
znajdz_autora(Lista, Autor) :- Lista = [Tytul|_], ksiazka(_, Tytul, autor(Autor, _), _).
nachodza(S1-E1, S2-E2) :- S1 <= E2 , E1 >= S2.
redukuj([Autor,S-E], [_,PoprzedniMax], [NowyAutor,NowyMax]) :- 
    Ile is E - S, Ile > PoprzedniMax,  
    NowyAutor = Autor, NowyMax = Ile.
redukuj([_,_], [Autor,Poprzedni], [Autor,Poprzedni]).

/*
setof(Autor, (A,B,C)^ksiazka(A, B, Autor, C), Wynik).

findall(Tytul, (
        ksiazka(_, Tytul, autor(_, _-RokSmierci), wydanie(_,RokWydania)),  
        RokWydania > RokSmierci)
    , Dane).

findall(Format,( 
    bagof(Tytul, (A,B)^ksiazka(A, Tytul, _, B), Ksiazki), 
        znajdz_autora(Ksiazki, Imie), 
        Format = Imie - Ksiazki)
, Wynik).

findall([Autor1, Autor2], (
        ksiazka(_, _, autor(Autor1, S1-E1), _), 
        ksiazka(_, _, autor(Autor2, S2-E2), _),
        nachodza(S1-E1, S2-E2),
        Autor1 \= Autor2,
        \+ ( byli(Autor1, Autor2) ; byli(Autor2, Autor1) ),
        assert(byli(Autor1, Autor2)))
    , Wynik).

setof([Imie, Okres], (A,B,C)^ksiazka(A, B, autor(Imie, Okres), C), Wynik), 
foldl(redukuj, Wynik, ['', 0], DaneMax), DaneMax = [OstatecznyWynik,_].
*/