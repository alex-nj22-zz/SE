(deftemplate Juego  (slot jugador1) (slot jugador2))

(defglobal ?*win1* = 0
	?*win2* = 0
	?*empate* = 0
	?*continuar* = 0
	?*error* = 0
	?*Seleccion1* = ""
	?*Seleccion2* = ""
)

(defrule WIN0
(juego(jugador1 piedra) (jugador2 piedra))
=>
(printout t "Empate." crlf)
(bind ?*empate* (+ ?*empate* 1))
(retract *)
(assert (iniciar))

(defrule WIN1
	(juego (jugador1 piedra) (jugador2 papel))
	=>
	(printout t "Gana Jugador 2." crlf))
	(bind ?*win2* (+ ?*win2* 1))
	(retract *)
	(assert (iniciar))

	(defrule WIN2
		(juego (jugador1 piedra) (jugador2 tijeras))
		=>
		(printout t "Gana Jugador 1." crlf)
		(bind ?*win1* (+ ?*win1* 1))
		(retract *)
		(assert (iniciar)))

(defrule WIN3
	(juego (jugador1 papel) (jugador2 papel))
	=>
	(printout t "Empate." crlf)
	(bind ?*empate* (+ ?*empate* 1))
	(retract *)
	(assert (iniciar)))

(defrule WIN4
	(juego (jugador1 papel) (jugador2 piedra))
	=>
	(printout t "Gana Jugador 1." crlf)
	(bind ?*win1* (+ ?*win1* 1))
	(retract *)
	(assert (iniciar)))

(defrule WIN5
	(juego (jugador1 papel) (jugador2 tijera))
	=>
	(printout t "gana jugador 2." crlf)
	(bind ?*win2* (+ ?*win2* 1))
	(retract *)
	(assert (iniciar)))

(defrule WIN6
	(juego (jugador1 tijera) (jugador2 tijera))
	=>
	(printout t "Empate" crlf)
	(bind ?*empate* (+ ?*empate* 1))
	(retract *)
	(assert (iniciar)))

(defrule WIN7
	(juego (jugador1 tijera) (jugador2 papel))
	=>
	(printout t "Gana Jugador 1." crlf)
	(bind ?*win1* (+ ?*win1* 1))
	(retract *)
	(assert (iniciar)))

(defrule WIN8
	(juego (jugador1 tijera) (jugador2 piedra))
	=>
	(printout t "Gana Jugador 2." crlf)
	(bind ?*win2* (+ ?*win2* 1))
	(retract *)
	(assert (iniciar)))

(defrule leer-datos (iniciar)
	=>
(printout t "Elija una opción: Piedra, papel o tijera" crlf)

(printout t " Turno Jugador 1 " crlf)
(bind ?*Seleccion1* (read))

(printout t "Turno Jugador 2 " crlf)
(bind ?*Seleccion2* (read))
(assert (juego
(jugador1 ?*Seleccion1*)
(jugador2 ?*Seleccion2*)
)))

(assert(iniciar))
