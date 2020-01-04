%%% WSTĘP %%%
% Proszę przyjrzeć się poniższej bazie danych o bliżej nieokreślonym księgozbiorze:

ksiazka(16, 'Flatlandia', autor('Edwin Abbott Abbott', 1838-1926), wydanie('Seel & Co', 1884)). 
ksiazka(28, 'R.U.R.', autor('Karel Čapek', 1890-1938), wydanie('Players Press', 2002)).
ksiazka(29, 'Daszeńka, czyli żywot szczeniaka', autor('Karel Čapek', 1890-1938), wydanie('Nasza Księgarnia', 1989)).
ksiazka(34, 'Kobieta z wydm', autor('Kobo Abe', 1924-1993), wydanie('Wydawnictwo Znak', 2007)).
ksiazka(56, 'Zamek', autor('Franz Kafka', 1883-1924), wydanie('Zielona Sowa', 2001)).
ksiazka(87, 'Gargantua i Pantagruel', autor('Francois Rabelais', 1494-1553), wydanie('Siedmioróg', 2004)).

%%% ZADANIE %%%
% Używając predykatów agregacyjnych, proszę napisać zapytania znajdujących poniższe wyniki:
% 1. listę autorów książek, bez duplikatów
authors(Result) :- 
    setof(Author, (A,B,C)^ksiazka(A, B, Author, C), Result).

% 2. listę tytułów książek, które zostały wydane po śmierci swojego autora
books_released_after_author_death(Result) :- 
    findall(Title, (
        ksiazka(_, Title, autor(_, _-DeathYear), wydanie(_,ReleaseDate)),  
        ReleaseDate > DeathYear
    ), Result).

% 3. listę par o postaci <imię autora> - <lista napisanych przez niego książek>.
authors_books(Result) :- % authors' books 
    findall(Name - Books, 
        bagof(Title, (A,B,C)^ksiazka(A, Title, autor(Name, B), C), Books)
    , Result).

% 4. listę par autorów, którzy mogli się spotkać za swojego życia
% podpowiedź: warto zdefiniować osobno predykat sprawdzający, czy dwa okresy czasu nachodzą na siebie
:- dynamic written/2.

overlaps(S1-E1, S2-E2) :- S1 =< E2, E1 >= S2.

could_met(Result) :-
    findall([Author1, Author2], (
        ksiazka(_, _, autor(Author1, S1-E1), _), 
        ksiazka(_, _, autor(Author2, S2-E2), _),
        overlaps(S1-E1, S2-E2),
        Author1 \= Author2,
        handle_repetitions(Author1, Author2)
    ), Result),
    retractall(written(_,_)).

handle_repetitions(Autor1, Autor2) :- \+ written(Autor1, Autor2),
                                      \+ written(Autor2, Autor1),
                                      assert(written(Autor1, Autor2)).

% 5. imię autora, który żył najdłużej
% podpowiedź: proszę zastosować predykat foldl/4 do znalezienia maksymalnego elementu w liście
longest_lived(Name - (Born - Died), _ - AccAge, Name - Age) :- Age is Died - Born,
                                                               Age > AccAge.
%longest_lived(X, Y, Y) :- writeln("!"), writeln(X), writeln(Y).
longest_lived(_ - (Born - Died), Name - AccAge, Name - AccAge) :- Age is Died - Born,
                                                                  Age < AccAge.
                                                                 
longest_lived_author(Result) :- setof(Name - Lived, (A,B,C)^ksiazka(A, B, autor(Name, Lived), C), Autors),
                                foldl(longest_lived, Autors, "No data" - 0, Result - _).