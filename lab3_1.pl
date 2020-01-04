%%% WSTĘP %%%
% Poniżej znajduje się kompletna realizacja zadania z poprzednich zajęć
%%% ZADANIE %%%
% Poprawić komendę list, by nie używała fail.

:- dynamic jest_znajomym/1.

main :- 
    read_command(Command),
    process_command(Command),
    main.

read_command(Command) :- read(Command).

process_command(help) :- 
    writeln("Lista komend:"),
    writeln("- 'add' - dodaj znajomego"),
    writeln("- 'del' - usuń znajomego"),
    writeln("- 'list' - wypisz wszystkich znajomych"),
    writeln("- 'help' - wyświetl listę komend"),
    writeln("- 'exit' - zakończ program").    

process_command(add) :-
    writeln('Podaj imię znajomego do zapamiętania:'),
    read(Imie),
    dodaj_znajomego(Imie).
process_command(del) :-
    writeln('Podaj imię znajomego do zapomnienia:'),
    read(Imie),
    usun_znajomego(Imie).
process_command(list) :-
    writeln('Znajomi:'),
    forall(jest_znajomym(Imie),(
        format('- ~w\n', [Imie])
    )).
process_command(exit) :- fail.
process_command(CMD) :-
    \+ known_command(CMD),
    format('Nie znam komendy: ~w\n', [CMD]).


dodaj_znajomego(Imie) :-
    jest_znajomym(Imie),
    format('Znam już kogoś o imieniu: ~w\n', [Imie]).
dodaj_znajomego(Imie) :-
    \+ jest_znajomym(Imie),
    assert(jest_znajomym(Imie)),
    writeln('Nowy znajomy zapamiętany!').

usun_znajomego(Imie) :-
    \+ jest_znajomym(Imie),
    format('Nie znam nikogo o imieniu: ~w\n', [Imie]).
usun_znajomego(Imie) :-
    jest_znajomym(Imie),
    retract(jest_znajomym(Imie)),
    writeln('Usunięto znajomego').

known_command(add). known_command(del). known_command(exit).
known_command(list). known_command(help).