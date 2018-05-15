start :- consult('capital.pl'),
         nl,
         write('Escribe los nombres completamente en minúsculas,'), nl,
         write('seguidos de un punto.'), nl,
         nl,
         process_a_query.

process_a_query :- write('Pais? '),
                   read(Pais),
                   answer(Pais).

% Si el usuario ingresa "stop.", entonces grabar la nueva
% base de conocimientos y salir.
answer(stop) :- write('Grabando la base de conocimientos...'), nl,
                tell('capital.pl'),
                listing(capital_de),
                told,
                write('Listo.'), nl.


                answer(delete) :- write('Que pais quieres eliminar'), nl,
                                read(Pais), nl,
                                retract(capital_de(Pais,_)),
                                write('Listo.'), nl,
                                  process_a_query.






% Si el país ya está en la base de conocimientos, entonces retornar
% el nombre de su capital.
answer(Pais) :- capital_de(Pais, Ciudad),
                write('La capital de '),
                write(Pais),
                write(' es '),
                write(Ciudad), nl,
                nl,
                process_a_query.

% Si el país no está en la base de conocimientos, entonces pedir
% el nombre de la capital e ingresar este fact a la base.
answer(Pais) :-  not(capital_de(Pais, Ciudad)),
                write('No conozco la capital de ese pais.'), nl,
                write('Por favor, dime cual es.'), nl,
                write('Capital? '),
                read(Ciudad),
                write('Gracias.'), nl, nl,
                assert(capital_de(Pais, Ciudad)),
                process_a_query.
