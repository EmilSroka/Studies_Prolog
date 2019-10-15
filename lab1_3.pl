% Świat klocków z trzema miejscami 
% na stole nazwanymi kolejno: s1, s2, s3
% oraz siedmioma klockami 
% nazwanymi kolejno: k1, k2, k3, k4, k5, k6, k7
% graficznie:
%
%          k3
%          k4
%    k1    k5
%    k2    k6    k7
% -- s1 -- s2 -- s3 -- stół
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ZADANIE
%
% Proszę uzupełnić niezdefiniowane predykaty!
% Zastąpić "fail" przez pradziwe ciała reguł.
% Ostrzeżenie: prawie wszystkie są rekurencyjne
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%
% Opisuje dziedzinę stałych. Użyteczne, jeżeli 
% jakiś predykat ma działać inaczej dla klocków, 
% inaczej dla kawałków stołu.
klocek(k1). 
klocek(k2). 
klocek(k3). 
klocek(k4).
klocek(k5). 
klocek(k6).  
klocek(k7).

stol(s1). 
stol(s2). 
stol(s3).

%%%%%%%%%%%%%%%%%%
% Opisuje, który klocek leży bezpośrednio na czym
%
na(k1,k2).  
na(k3,k4).   
na(k4,k5).   
na(k5,k6).
na(k2,s1).
na(k6,s2).
na(k7,s3).

%%%%%%%%%%%%%%%%%%%%%
% pod/2
% powinien odpowiadać na pytanie, 
% czy dany klocek/kawałek stołu 
% jest bezpośrednio pod innym klockiem
pod(K1, K2) :- na(K2, K1).
%pod(K1, K2) :- pod(K2, P1), na(P1, K1).
                   
%%%%%%%%%%%%%%%%%%%%%
% nad/2
% powinien odpowiadać na pytanie, 
% czy dany klocek/kawałek stołu jest 
% pośrednio lub bezpośrednio nad innym 
% klockiem/kawałkiem stołu
nad(K1, K2) :- na(K1, K2).
nad(K1, K2) :- na(P1, K2), nad(K1, P1).

%%%%%%%%%%%%%%%%%%%%%
% poniżej/2
% powinien odpowiadać na pytanie, 
% czy dany klocek/kawałek stołu jest 
% pośrednio lub bezpośrednio pod innym klockiem
ponizej(K1, K2) :- pod(K1, K2).
ponizej(K1, K2) :- pod(K1, P1), ponizej(P1, K2).

%%%%%%%%%%%%%%%%%%
% na_lewo/2
% Ten predykat powininen odpowiadać, 
% czy dany klocek/kawałek stołu jest na lewo 
% od innego klocka/kawałka stołu
% poniższe fakty opisują relację między kawałkami stołu 
% - proszę dopisać bazującą na nich regułę, 
% która działałaby dla dowolnych elementów świata
na_lewo(s1,s2).   
na_lewo(s2,s3).
na_lewo(s1,s3).

% Podpowiedź: należy znaleźć miejsca na stole,
% na których leżą k1 i k2.
na_lewo(K1, K2) :- stol(P1), stol(P2),
                   nad(K1, P1), nad(K2, P2), 
                   na_lewo(P1, P2).

%%%%%%%%%%%%%%%%%%%%%
% na_prawo/2
% powinien odpowiadać na pytanie, 
% czy dany klocek/kawałek stołu jest na prawo 
% od innego klocka/kawałka stołu
na_prawo(K1, K2) :- na_lewo(K2, K1).