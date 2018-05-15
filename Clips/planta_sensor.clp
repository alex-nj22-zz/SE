(defglobal ?*N* = 0
           ?*Nsensor* = 0)

(deftemplate plantaIndustrial
(slot sensor (type INTEGER) (range 1 10))
(slot estado (type SYMBOL)  (allowed-symbols correcto incorrecto) (default correcto)))

(deffacts Sensores
  (plantaIndustrial (sensor 1))
  (plantaIndustrial (sensor 2))
  (plantaIndustrial (sensor 3))
  (plantaIndustrial (sensor 4))
  (plantaIndustrial (sensor 5))
  (plantaIndustrial (sensor 6))
  (plantaIndustrial (sensor 7))
  (plantaIndustrial (sensor 8))
  (plantaIndustrial (sensor 9))
  (plantaIndustrial (sensor 10)))

    (defrule Sensores-incorrectos
      (plantaIndustrial (estado incorrecto))
      =>
      (bind ?*N* (+ ?*N* 1))
      (if (>= ?*N* 3)
      then
      (printout t "*************************************************" crlf)
      (printout t "Alerta! " ?*N* " Sensores con valores incorrectos" crlf)
      (printout t "*************************************************" crlf)))

(defrule leer-datos (iniciar)
	=>
(printout t "###########################################################" crlf)
(printout t "Bienvenido al sistema de reporte de errores de los sensores" crlf)
(printout t "###########################################################" crlf)
(printout t "Ingrese el numero de caso del error que se presenta: " crlf)
(printout t "Caso 1= Sensores 1 y 2" crlf)
(printout t "Caso 2= Sensores 2 , 8 y 9" crlf)
(printout t "Caso 3= Sensores 1 , 3 , 5, 10" crlf)
(printout t "Caso 4= Sensores 3 , 5, 6 , 7 , 9 y 10" crlf)
(bind ?*Nsensor* (read))
(if (or(= ?*Nsensor* 1) (= ?*Nsensor* 2) (= ?*Nsensor* 3) (= ?*Nsensor* 4))
then
(if (= ?*Nsensor* 1)
then
(modify 1 (estado incorrecto))
(modify 2 (estado incorrecto)))
(if (= ?*Nsensor* 2)
then
(modify 2 (estado incorrecto))
(modify 8 (estado incorrecto))
(modify 9 (estado incorrecto)))
(if (= ?*Nsensor* 3)
then
(modify 1 (estado incorrecto))
(modify 3 (estado incorrecto))
(modify 5 (estado incorrecto))
(modify 10 (estado incorrecto)))
(if (= ?*Nsensor* 4)
then
(modify 3 (estado incorrecto))
(modify 5 (estado incorrecto))
(modify 6 (estado incorrecto))
(modify 7 (estado incorrecto))
(modify 8 (estado incorrecto))
(modify 10 (estado incorrecto)))
else
(printout t "Sin Acciones" crlf)
)
)

(assert (iniciar))


***********************************************************************
  (defglobal ?*N* = 0
    ?*F* = 0
    ?*P* = 0
    ?*C* = 0
    ?*ReglaN* = 0
    ?*ReglaA* = 0
    ?*seleccion* = 0
    ?*seguir* = 1
    ?*Crecimientobajo* = ""
    ?*ColorPlanta* = ""
    ?*ColorHojas* = ""
    ?*Raiz* = ""
    ?*Tallo* = ""
    ?*Madurez* = ""
    ?*BordeHoja* = ""
    ?*SemillaFruto* = ""
    ?*Crecimiento* = 0
    ?*ColorP* = 0
    ?*ColorH* = 0
    ?*RaizN* = 0
    ?*TalloN* = 0
    ?*MadurezN* = 0
    ?*BordeH* = 0
    ?*SemillaF* = 0
)

    (deftemplate Planta
      (slot Crecimiento)
      (slot ColorPlanta)
      (slot ColorHojas )
      (slot Raiz)
      (slot Tallo)
      (slot Madurez)
      (slot BordeHoja)
      (slot SemillaFruto))

      (defrule Deficiencia_Nitrogeno
      (or (Planta(Crecimiento bajo)) (Planta(ColorPlanta amarillo)) (Planta(ColorHojas rojizo)))
      =>
      (bind ?*N* (+ ?*N* 1))
      (if (= ?*N* 1)
      then
      (printout t "Su planta tiene deficiencia de Nitrogeno" crlf))
      )

      (defrule Deficiencia_Fosforo
      (or (Planta(Raiz poco)) (Planta(Tallo fusiformes)) (Planta(ColorPlanta purpura)) (Planta(Madurez retrasado)))
      =>
      (bind ?*F* (+ ?*F* 1))
      (if (= ?*F* 1)
      then
      (printout t "Su planta tiene deficiencia de Fosforo" crlf))
      )

      (defrule Deficiencia_Potasio
      (or (Planta(BordeHoja chamuscadas)) (Planta(Tallo debilitados)) (Planta(SemillaFruto marchitas)))
      =>
      (bind ?*P* (+ ?*P* 1))
      (if (= ?*P* 1)
      then
      (printout t "Su planta tiene deficiencia de Potasio" crlf))
      )

      (defrule Hoja_Seca
      (Planta(ColorHojas cafe))
      =>
      (bind ?*C* (+ ?*C* 1))
      (if (= ?*C* 1)
      then
      (printout t "Su planta tiene sus hojas secas, deberia regarla mas seguido." crlf))
      )

      (defrule Normal
        (or (Planta(Crecimiento normal)) (Planta(Raiz rapido)) (Planta(Tallo normal)) (Planta(Madurez normal))
        (Planta(BordeHoja normal)) (Planta(SemillaFruto normal)))
        =>
        (bind ?*ReglaN* (+ ?*ReglaN* 1))
        (if (= ?*ReglaN* 1)
        then
        (printout t "Su planta presenta valores normales en algunos de los datos ingresados." crlf))
        )

        (defrule Alto
          (or (Planta(Crecimiento alto)) (Planta(Raiz normal)) (Planta(Tallo normal)) (Planta(Madurez normal))
          (Planta(ColorHojas verde)) (Planta(ColorPlanta verde)))
          =>
          (bind ?*ReglaA* (+ ?*ReglaA* 1))
          (if (= ?*ReglaA* 1)
          then
          (printout t "Su planta presenta valores excelentes en algunos de los datos ingresados." crlf))
          )

      (defrule leer-datos
        =>
      (while (= ?*seguir* 1)
      (printout t "************************************************************" crlf)
      (printout t "Bienvenido al sistema de Diagnostico de Plantas" crlf)
      (printout t "************************************************************" crlf)
      (printout t "¿Que tipo de problema tiene su planta? " crlf)
      (printout t "" crlf)
      (printout t "** Crecimiento------(1) ** Color-----------(2) **" crlf)
      (printout t "** Color de hojas---(3) ** Raiz------------(4) **" crlf)
      (printout t "** Tallo------------(5) ** Madurez---------(6) **" crlf)
      (printout t "** Borde de hojas---(7) ** Semilla o Fruto-(8) **" crlf)
      (printout t "------------------------------------------------------------" crlf)
      (bind ?*seleccion* (read))
      (printout t "" crlf)
      (switch ?*seleccion*
        (case 1
        then
        (printout t "¿Como es el crecimiento de la planta?" crlf)
        (printout t "** Bajo----------(1)  ** Normal----------(2) ** Alto----------(3) **" crlf)
        (bind ?*Crecimiento* (read))
        (switch ?*Crecimiento*
          (case 1
            then
            (bind ?*Crecimientobajo*  bajo)
            (printout t "" crlf)
            (printout t "Su Crecimiento es = " ?*Crecimientobajo* crlf))
          (case 2
            then
            (bind ?*Crecimientobajo*  normal)
            (printout t "" crlf)
            (printout t "Su Crecimiento es = " ?*Crecimientobajo* crlf))
            (case 3
              then
              (bind ?*Crecimientobajo*  alto)
              (printout t "Su Crecimiento es = " ?*Crecimientobajo* crlf))
          (default
              (printout t "************************************************************" crlf)
              (printout t "Ingrese una opcion correcta" crlf))
        ))
        (case 2
        then
        (printout t "¿Cual es su color?" crlf)
        (printout t "** Amarillo Palido----------(1) ** Purpura----------(2) **" crlf)
        (printout t "** Verde--------------------(3) ** Otro-------------(4) **" crlf)
        (bind ?*ColorP* (read))
        (switch ?*ColorP*
          (case 1
            then
            (bind ?*ColorPlanta*  amarillo)
            (printout t "Su Color es = " ?*ColorPlanta* crlf))
          (case 2
            then
            (bind ?*ColorPlanta*  purpura)
            (printout t "Su Color es = " ?*ColorPlanta* crlf))
            (case 3
              then
              (bind ?*ColorPlanta*  verde)
              (printout t "Felicidades, tiene una planta muy sana y nutrida!" crlf))
            (case 4
              then
                (bind ?*ColorPlanta*  otro))
          (default
              (printout t "************************************************************" crlf)
              (printout t "Ingrese una opcion correcta" crlf))
        ))
        (case 3
        then
        (printout t "¿Cual es el color de las hojas?" crlf)
        (printout t "** Pardo Rojizo----------(1) ** Verde----------(2) **" crlf)
        (printout t "** Cafe--------------------(3) ** Otro-------------(4) **" crlf)
        (bind ?*ColorH* (read))
        (switch ?*ColorH*
          (case 1
            then
              (bind ?*ColorHojas* rojizo)
              (printout t "El Color de las hojas es = " ?*ColorHojas* crlf))
            (case 2
              then
              (bind ?*ColorHojas* verde)
              (printout t "El Color de las hojas es = " ?*ColorHojas* crlf))
            (case 3
              then
                (bind ?*ColorHojas* cafe)
                (printout t "El Color de las hojas es = " ?*ColorHojas* crlf))
            (case 4
              then
                (bind ?*ColorHojas* otro)
                (printout t "El Color de las hojas es = " ?*ColorHojas* crlf))
              (default
                    (printout t "************************************************************" crlf)
                    (printout t "Ingrese una opcion correcta" crlf))
        ))
        (case 4
        then
        (printout t "¿Cual es el crecimiento de la raiz?" crlf)
        (printout t "** Poco----------(1)  ** Normal----------(2) ** Rapido----------(3) **" crlf)
        (bind ?*RaizN* (read))
        (switch ?*RaizN*
          (case 1
            then
              (bind ?*Raiz* poco)
              (printout t "El Crecimiento de la Raiz es = " ?*Raiz* crlf))
            (case 2
              then
              (bind ?*Raiz* normal)
              (printout t "El Crecimiento de la Raiz es = " ?*Raiz* crlf))
            (case 3
              then
                (bind ?*Raiz* rapido)
                (printout t "El Crecimiento de la Raiz es = " ?*Raiz* crlf))
            (default
                (printout t "************************************************************" crlf)
                (printout t "Ingrese una opcion correcta" crlf))
        ))
        (case 5
        then
        (printout t "¿Cual es la condicion de los tallos?" crlf)
        (printout t "** Fusiformes----------(1)  ** Debilitados----------(2) ** Normal----------(3) **" crlf)
        (bind ?*TalloN* (read))
        (switch ?*TalloN*
          (case 1
            then
              (bind ?*Tallo* fusiformes)
              (printout t "La condicion de los tallos es = " ?*Tallo* crlf))
            (case 2
              then
              (bind ?*Tallo* debilitados)
              (printout t "El Crecimiento de la Raiz es = " ?*Tallo* crlf))
            (case 3
              then
                (bind ?*Tallo* normal)
                (printout t "El Crecimiento de la Raiz es = " ?*Tallo* crlf))
            (default
                (printout t "************************************************************" crlf)
                (printout t "Ingrese una opcion correcta" crlf))
        ))
        (case 6
        then
        (printout t "¿En que estado esta su Madurez?" crlf)
        (printout t "** Retrasado----------(1)  ** Normal----------(2) **" crlf)
        (bind ?*MadurezN* (read))
        (switch ?*MadurezN*
          (case 1
            then
              (bind ?*Madurez* retrasado)
              (printout t "Estado de su Madurez = " ?*Madurez* crlf))
            (case 2
              then
              (bind ?*Madurez* normal)
              (printout t "Estado de su Madurez = " ?*Madurez* crlf))
            (default
                (printout t "************************************************************" crlf)
                (printout t "Ingrese una opcion correcta" crlf))
        ))
        (case 7
        then
        (printout t "¿Cual es el estado de sus hojas? (chamuscadas , normal)" crlf)
        (printout t "** Chamuscadas----------(1)  ** Normal----------(2) **" crlf)
        (bind ?*BordeH* (read))
        (switch ?*BordeH*
          (case 1
            then
              (bind ?*BordeHoja* chamuscadas)
              (printout t "Sus hojas estan = " ?*BordeHoja* crlf))
            (case 2
              then
              (bind ?*BordeHoja* normal)
              (printout t "Sus hojas estan = " ?*BordeHoja* crlf))
            (default
                (printout t "Ingrese una opcion correcta" crlf))
        ))
        (case 8
        then
        (printout t "¿Como se encuentran las semillas o fruto?" crlf)
        (printout t "** Marchitas----------(1)  ** Normal----------(2) **" crlf)
        (bind ?*SemillaF* (read))
        (switch ?*SemillaF*
          (case 1
            then
              (bind ?*SemillaFruto* marchitas)
              (printout t "Sus semillas o frutos estan = " ?*SemillaFruto* crlf))
            (case 2
              then
              (bind ?*SemillaFruto* normal)
              (printout t "Sus semillas o frutos estan = " ?*SemillaFruto* crlf))
            (default
                (printout t "************************************************************" crlf)
                (printout t "Ingrese una opcion correcta" crlf))
        ))
        (default
          (printout t "************************************************************" crlf)
          (printout t "Ingrese una opcion correcta" crlf))
      )
      (printout t "" crlf)
      (printout t "Tiene otro problema su planta? (si (1) / no (2))" crlf)
      (bind ?*seguir* (read))
      )
      (if (or (= ?*Crecimiento* 1) (= ?*Crecimiento* 2) (= ?*Crecimiento* 3)
        (= ?*ColorP* 1) (= ?*ColorP* 2) (= ?*ColorP* 3) (= ?*ColorP* 4)
          (= ?*ColorH* 1) (= ?*ColorH* 2) (= ?*ColorH* 3) (= ?*ColorH* 4)
          (= ?*RaizN* 1) (= ?*RaizN* 2) (= ?*RaizN* 3)
          (= ?*TalloN* 1) (= ?*TalloN* 2) (= ?*TalloN* 3)
          (= ?*MadurezN* 1) (= ?*MadurezN* 2) (= ?*MadurezN* 3)
          (= ?*BordeH* 1) (= ?*BordeH* 2) (= ?*SemillaF* 1) (= ?*SemillaF* 2))
      then
      (assert (Planta (Crecimiento ?*Crecimientobajo*) (ColorPlanta ?*ColorPlanta*) (ColorHojas ?*ColorHojas*)
       (Raiz ?*Raiz*) (Tallo ?*Tallo*) (Madurez ?*Madurez*) ( BordeHoja ?*BordeHoja*)
       (SemillaFruto ?*SemillaFruto*))))
      )
