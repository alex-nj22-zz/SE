masculino(michael).
masculino(charles_gordon).
masculino(jim).
masculino(elmo).
masculino(greg).
masculino(peter).
femenino(cathy).
femenino(sharon).
femenino(julie).
femenino(melody).
femenino(crystal).
femenino(stephanie).
femenino(danielle).
femenino(hazel).
femenino(eleanor).
femenino(maria).
padre(michael, cathy).
padre(michael, sharon).
padre(charles_gordon, michael).
padre(charles_gordon, julie).
padre(charles, charles_gordon).
padre(jim, melody).
padre(jim, crystal).
padre(elmo, jim).
padre(greg, stephanie).
padre(greg, peter).
padre(greg, maria).
padre(greg, danielle).
madre(melody, cathy).
madre(melody, sharon).
madre(hazel, michael).
madre(hazel, julie).
madre(eleanor, melody).
madre(eleanor, crystal).
madre(crystal, stephanie).
madre(crystal, peter).
madre(crystal, maria).
madre(crystal, danielle).
padres(X, Y) :- padre(X, Y).
padres(X, Y) :- madre(X, Y).

%muestra los nietos de una persona solicitada, a la vez se puede preguntar quien es el abuelo de alguien%
%(abuelo(Abuelo,Y) donde Y es el nombre de la persona de quien se quiere saber el abuelo)%
abuelo(A,N) :-    padre(A,Hijo) , padre(Hijo,N).
abuelo(A,N) :-    padre(A,Hija) , madre(Hija,N).
abuela(A,N) :-    madre(A,Hijo) , padre(Hijo,N).
abuela(A,N) :-    madre(A,Hija) , madre(Hija,N).


%Hermana / hermano ya no se repite el mismo%
hermana(X,Y) :- padre(P,Y) , padre(P,X) , femenino(Y) , not(X==Y).
hermano(X,Y) :- padre(P,Y) , padre(P,X) , masculino(Y) , not(X==Y).
%Muestrta todos los hermanos / hermanas que tiene el solicitado%
herman(X,Y) :- padre(P,Y) , padre(P,X) , not(X==Y).

%Muestra si es hijo unico la persona solicitada%
hijounico(X) :- not(hermano(X,_)) , not(hermana(X,_)).
%Muestra el listado de hijos unicos%
hunico(X) :- (padre(_,X) ; madre(_,X)) , not(hermana(X,_)) , not(hermano(X,_)).
