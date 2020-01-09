%%% ZADANIE 1 %%%
% Proszę napisać predykat is_empty_diff/1, który sprawdzi czy dana lista różnicowa jest pusta.
is_empty_diff(List-T) :- List == T. 




% TO DO 2, 3

% Proszę napisać predykat length_diff/2, który policzy długość listy różnicowej:
/*
length_diff(List-T, 0) :- is_empty_diff(List-T).
length_diff([_|List]-T, Result) :- 
    length_diff(List-T, SubResult), 
    Result is SubResult + 1.
*/

length_diff(List-E, 0) :- is_empty_diff(List-E).
length_diff(List-E, Result) :- 
    \+ is_empty_diff(List-E),
    List = [_|SubList],
    length_diff(SubList-E,SubResult), 
    Result is SubResult + 1.

% Proszę napisać predykat member_diff/2, który sprawdzi czy zadany element należy do listy różnicowej.
/*
member_diff(Element, List-T) :- \+ is_empty_diff(List-T), [H|_] = List, H = Element.
member_diff(Element, List-T) :- \+ is_empty_diff(List-T), [_|SubList] = List, member_diff(Element, SubList-T).
*/
member_diff(Element, [Element|_]-_).
member_diff(Element, [H|List]-T) :-
    H \= Element,
    \+ is_empty_diff(List-T),  
    member_diff(Element, List-T).
