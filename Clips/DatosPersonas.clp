(defglobal
  ?*P* = 0
  ?*Prom* = 0
  ?*con* = 0
  ?*val* = 0)

(deftemplate persona
  (slot nombre)
  (slot apellido)
  (slot edad)
  (slot genero (allowed-symbols masculino femenino))
  (slot estado_civil (allowed-symbols soltero casado divorciado viudo))
  (slot ingresos_economicos)
  (slot nombre_conyugue (default ""))
  (slot nacionalidad)
  (slot profesion)
)

(deffacts personas
(persona (nombre carlos)
(apellido martinez)
(edad 25)
(genero masculino)
(estado_civil soltero)
(ingresos_economicos 600)
(nacionalidad salvadoreño)
(profesion abogado))

(persona (nombre Erick)
(apellido Hernandez)
(edad 30)
(genero masculino)
(estado_civil viudo)
(ingresos_economicos 200)
(nacionalidad mexicano)
(profesion medico))

(persona (nombre Alex)
(apellido nuñez)
(edad 22)
(genero masculino)
(estado_civil soltero)
(ingresos_economicos 800)
(nacionalidad salvadoreño)
(profesion sistemas))

(persona (nombre Felipe)
(apellido martinez)
(edad 70)
(genero masculino)
(estado_civil divorciado)
(ingresos_economicos 1000)
(nacionalidad nicaraguense)
(profesion arquitecto))

(persona (nombre eduardo)
(apellido nuñez)
(edad 28)
(genero masculino)
(estado_civil soltero)
(ingresos_economicos 800)
(nacionalidad salvadoreño)
(profesion medico))

(persona (nombre miguel)
(apellido alberto)
(edad 63)
(genero masculino)
(estado_civil casado)
(ingresos_economicos 300)
(nombre_conyugue ana)
(nacionalidad hondureño)
(profesion carpintero))

(persona (nombre antonio)
(apellido cruz)
(edad 33)
(genero masculino)
(estado_civil soltero)
(ingresos_economicos 300)
(nacionalidad salvadoreño)
(profesion agricultor))

(persona (nombre henry)
(apellido aleman)
(edad 66)
(genero masculino)
(estado_civil viudo)
(ingresos_economicos 800)
(nacionalidad nicaraguense)
(profesion sistemas))

(persona (nombre alfredo)
(apellido landaverde)
(edad 38)
(genero masculino)
(estado_civil divorciado)
(ingresos_economicos 200)
(nacionalidad salvadoreño)
(profesion agricultor))

(persona (nombre carolina)
(apellido menjivar)
(edad 33)
(genero femenino)
(estado_civil divorciado)
(ingresos_economicos 500)
(nacionalidad hondureño)
(profesion medico))

(persona (nombre maria)
(apellido nuñez)
(edad 70)
(genero femenino)
(estado_civil soltero)
(ingresos_economicos 700)
(nacionalidad salvadoreño)
(profesion nutricionista))

(persona (nombre carmen)
(apellido landaverde)
(edad 25)
(genero femenino)
(estado_civil soltero)
(ingresos_economicos 200)
(nacionalidad salvadoreño)
(profesion abogado))

(persona (nombre maricela)
(apellido alfaro)
(edad 22)
(genero femenino)
(estado_civil soltero)
(ingresos_economicos 200)
(nacionalidad salvadoreño)
(profesion estudiante))

(persona (nombre ana)
(apellido tejada)
(edad 60)
(genero femenino)
(estado_civil casado)
(ingresos_economicos 200)
(nombre_conyugue miguel)
(nacionalidad salvadoreño)
(profesion abogado))

(persona (nombre gloria)
(apellido joya)
(edad 40)
(genero femenino)
(estado_civil divorciado)
(ingresos_economicos 600)
(nacionalidad salvadoreño)
(profesion casa))

(persona (nombre marilu)
(apellido alfaro)
(edad 29)
(genero femenino)
(estado_civil soltero)
(ingresos_economicos 900)
(nacionalidad nicaraguense)
(profesion sistemas))

(persona (nombre adilene)
(apellido martinez)
(edad 25)
(genero femenino)
(estado_civil soltero)
(ingresos_economicos 100)
(nacionalidad salvadoreño)
(profesion estudiante))

(persona (nombre jasmin)
(apellido molina)
(edad 45)
(genero femenino)
(estado_civil viudo)
(ingresos_economicos 500)
(nacionalidad mexicano)
(profesion abogado))

(persona (nombre marta)
(apellido landaverde)
(edad 45)
(genero femenino)
(estado_civil soltero)
(ingresos_economicos 800)
(nacionalidad salvadoreño)
(profesion profesor))

(persona (nombre fatima)
(apellido menjivar)
(edad 25)
(genero femenino)
(estado_civil soltero)
(ingresos_economicos 500)
(nacionalidad salvadoreño)
(profesion chef))
)

**

(defrule maximo
(declare (salience 50))
(persona(ingresos_economicos ?x)(nombre ?n))
(forall (persona(ingresos_economicos ?y)) (test (>= ?x ?y)))
=>
(printout t ?n " es  la persona con mayor ingreso economico con: " ?x crlf)
)

(defrule minimo
(declare (salience 40))
(persona(ingresos_economicos ?x)(nombre ?n))
(forall (persona(ingresos_economicos ?y)) (test (<= ?x ?y)))
=>
(printout t ?n " es  la persona con menor ingreso economico con: " ?x crlf)
)

(defrule modificar "3"
(declare (salience 100))
?h1 <- (persona(nombre fatima)(ingresos_economicos 500))
?h2 <- (persona(nombre marta)(ingresos_economicos 800))
=>
(modify ?h1(ingresos_economicos 1500))
(modify ?h2(ingresos_economicos 50))
)

(defrule soltero (declare(salience 100)) "4"
  (persona (nombre ?nom) (apellido ?appe) (edad ?edad) (estado_civil soltero))(test (<= ?edad 40))
=>
(printout t "nombre: " ?nom  " apellido: "  ?appe  " Estado civil: Soltero"  " edad: "  ?edad  crlf)
)

(defrule mujeres "5"
  (persona(nombre ?nom)(apellido ?appe)(edad ?edad)(estado_civil ?estado)(ingresos_economicos ?econo)(nombre_conyugue ?conyu)(nacionalidad ?nac)(profesion ?prof)(genero femenino))
=>
(printout t "nombre: " ?nom  " apellido: "  ?appe  " edad: "  ?edad " Genero: femenino " " estado_civil: " ?estado " ingresos_economicos: " ?econo " Nombre conyugue :" ?conyu " nacionalidad: " ?nac " profesion: " ?prof crlf)
  )


  (defrule  promedio (declare (salience 100))
  (persona(edad ?edad) )
  =>
  (bind ?*P* (+ ?*P* ?edad))
  (bind ?*con* (+ ?*con* 1))
  (if (= ?*val* 0) then
  (assert (mostrar))
  (bind ?*val* 0)
  )
  )

  (defrule mostrarmedia (declare (salience 10)) (mostrar)
  =>
  (bind ?*Prom* (/ ?*P* ?*con*))
  (printout t "promedio edad: " ?*Prom* crlf)
  )

  (defrule nacionalidad "7"
  ?h1 <- (persona(nacionalidad nicaraguense)(profesion ?prof)(nombre ?nom))
  =>
  (if (eq ?prof sistemas)
    then
    (printout t ?nom " Es nicaraguense pero es " ?prof " asi que no se elimina" crlf)
    else
    (retract ?h1)
  ))
