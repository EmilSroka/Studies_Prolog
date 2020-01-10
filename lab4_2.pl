%%% ZADANIE 1 %%%
% Proszę napisać predykat is_empty_diff/1, który sprawdzi czy dana lista różnicowa jest pusta.
is_empty_diff(List-T) :- List == T. 

%%% ZADANIE 2 %%%
% Proszę napisać predykat length_diff/2, który policzy długość listy różnicowej.
length_diff(List, 0) :- is_empty_diff(List).
length_diff([Head|SubList]-T, Result) :- 
    \+ is_empty_diff([Head|SubList]-T), 
    length_diff(SubList-T, SubResult), 
    Result is SubResult + 1.  

%%% ZADANIE 3 %%%
% Proszę napisać predykat member_diff/2, który sprawdzi czy zadany element należy do listy różnicowej.
member_diff(Element, [Element|_]-_). 
member_diff(Element, [Head|SubList]-T) :- 
    Element \= Head, 
    \+ is_empty_diff(SubList-T), 
    member_diff(Element, SubList-T).