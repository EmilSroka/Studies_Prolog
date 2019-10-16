% Dynamiczny predykat służący
% przechowywaniu imion znajomych
:- dynamic jest_znajomym/1.

% Główna pętla programu:
% - wczytuje komendę
% - przetwarza komendę
% - zapętla się ;)
main :- 
    read_command(Command),
    process_command(Command),
    main.

% Predykat pobierający komendą ze standardowego wejścia
% Dostępne komendy:
% - "add" - dodaj znajomego
% - "del" - usuń znajomego
% - "list" - wypisz znajomych
% - "help" - wyświetl listę komend
% - "exit" - wyjdź z programu
read_command(Command) :- read(Command).

% Predykat realizujący komendę 'help'
% Potrzeba jeszcze czterech innych komend,
% W przypadku nierozpoznoznanej komendy, program powinien
% wypisać informacje, że nie zna podanej komendy i kontynuować 
process_command(help) :- 
    writeln("Lista komend:"),
    writeln("- 'add' - dodaj znajomego"),
    writeln("- 'del' - usun znajomego"),
    writeln("- 'list' - wypisz wszystkich znajomych"),
    writeln("- 'help' - wyswietl liste komend"),
    writeln("- 'exit' - zakoncz program").    

% Misja: napisz kod realizujący brakujące komendy!

process_command(add) :- read(New), assert(jest_znajomym(New)).

process_command(del) :- read(Del), retract(jest_znajomym(Del)).

process_command(list) :- writeln("Lista znajomych: "), jest_znajomym(Friend),  writeln(Friend), fail.
process_command(list).

process_command(exit) :- fail.

process_command(X) :- X \= exit,  writeln("Nieznana komenda").