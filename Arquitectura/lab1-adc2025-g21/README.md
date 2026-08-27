[![Review Assignment Due Date](https://classroom.github.com/assets/deadline-readme-button-22041afd0340ce965d47ae6ef1cefeee28c7c493a6346c4f15d667ab976d596c.svg)](https://classroom.github.com/a/ItraukZ2)

# Arquitectura de Computadoras - FAMAF - UNC

## Lab 1: Implementación del procesador LEGv8 con pipeline de 5 etapas
*Integrantes:* 
- Ponchiardi Santino
- Michel Blas Brandon
- Gonzalez Valdez Emiliano

*Grupo:* Wolovers(grupo-21)

### Acondicionamiento Del Procesador

En este laboratorio se nos otorga un procesador con pipeline implementado, el cual para funcionar requiere hacer unos pequeños ajustes. Principalmente este procesador no lograba escribir en los registros, debido a que faltaba la señal llamada "wa3_D". Para implementar dicha señal, debimos traerla desde el flopr.sv llamado "MEM_WB", el cual nos devolvia el registro que debia ser escrito en caso de ser necesario. A continuación mostramos como se conectan las salidas de dicho flopr al módulo de Decode

<img width="1507" height="545" alt="imagen" src="https://github.com/user-attachments/assets/f43f758f-fe78-4dfb-ad00-97cbd1402d02" />

Luego de lograr conectar dicha señal, debiamos modificar el bloque regfile para permitir que las instrucciones logren modificar el valor de los registros

Para testear que el procesador funcionaba como especulabamos, comparamos las escrituras en la memoria, usando el memdump, con las escrituras en memoria del procesador utilizado en los ejercicios anteriores que no contaban con pipeline. Para ello utilizamos el siguiente codigo que tambien fue utilizado en los trabajos practicos, pero acondicionado para el micro con pipeline. Para ello, debimos agregar instrucciones de tipo nop ya que no contamos con una Hazard Detection Unit, ni con forwarding.

````
	.text
	.org 0x0000
	
	STUR X1, [X0, #0]		// MEM 0
	STUR X2, [X0, #8]		// MEM 1
	STUR X3, [X16, #0]		// MEM 2
	ADD X3, X4, X5
	ADD XZR, XZR, XZR
	ADD XZR, XZR, XZR

	STUR X3, [X0, #24]		// MEM 3
	SUB X3, X4, X5
	ADD XZR, XZR, XZR
	ADD XZR, XZR, XZR

	STUR X3, [X0, #32]		// MEM 4
	SUB X4, XZR, X10
	ADD XZR, XZR, XZR
	ADD XZR, XZR, XZR

	STUR X4, [X0, #40]		// MEM 5
	ADD X4, X3, X4
	ADD XZR, XZR, XZR
	ADD XZR, XZR, XZR

	STUR X4, [X0, #48]		// MEM 6
	SUB X5, X1, X3
	ADD XZR, XZR, XZR
	ADD XZR, XZR, XZR

	STUR X5, [X0, #56]		// MEM 7
	AND X5, X10, XZR
	ADD XZR, XZR, XZR
	ADD XZR, XZR, XZR

	STUR X5, [X0, #64]		// MEM 8
	AND X5, X10, X3
	ADD XZR, XZR, XZR
	ADD XZR, XZR, XZR

	STUR X5, [X0, #72]		// MEM 9
	AND X20, X20, X20
	ADD XZR, XZR, XZR
	ADD XZR, XZR, XZR

	STUR X20, [X0, #80]		// MEM 10
	ORR X6, X11, XZR
	ADD XZR, XZR, XZR
	ADD XZR, XZR, XZR

	STUR X6, [X0, #88]		// MEM 11
	ORR X6, X11, X3
	ADD XZR, XZR, XZR
	ADD XZR, XZR, XZR

	STUR X6, [X0, #96]		// MEM 12
	ADD XZR, XZR, XZR
	ADD XZR, XZR, XZR

	LDUR X12, [X0, #0]
	ADD XZR, XZR, XZR
	ADD XZR, XZR, XZR

	ADD X7, X12, XZR
	ADD XZR, XZR, XZR
	ADD XZR, XZR, XZR

	STUR X7, [X0, #104]		// MEM 13
	STUR X12, [X0, #112]	// MEM 14
	ADD XZR, X13, X14
	STUR XZR, [X0, #120]	// MEM 15
	CBZ X0, L1
	ADD XZR, XZR, XZR
	ADD XZR, XZR, XZR
	ADD XZR, XZR, XZR

	STUR X21, [X0, #128]	// MEM 16
L1: STUR X21, [X0, #136]	// MEM 17
	ADD X2, XZR, X1
	ADD XZR, XZR, XZR
	ADD XZR, XZR, XZR

L2: SUB X2, X2, X1
	ADD X24, XZR, X1
	ADD XZR, XZR, XZR
	ADD XZR, XZR, XZR

	STUR X24, [X0, #144]	// MEM 18 y MEM 19
	ADD X0, X0, X8

	CBZ X2, L2
	ADD XZR, XZR, XZR
	ADD XZR, XZR, XZR
	ADD XZR, XZR, XZR

	STUR X30, [X0, #144]	// MEM 20
	ADD X30, X30, X30
	ADD XZR, XZR, XZR
	ADD XZR, XZR, XZR

	SUB X21, XZR, X21
	ADD X30, X30, X20
	ADD XZR, XZR, XZR
	ADD XZR, XZR, XZR

	LDUR X25, [X30, #-8]
	ADD X30, X30, X30
	ADD XZR, XZR, XZR
	ADD XZR, XZR, XZR

	ADD X30, X30, X16
	ADD XZR, XZR, XZR
	ADD XZR, XZR, XZR

	STUR X25, [X30, #-8]	// MEM 21
finloop: CBZ XZR, finloop
````

Donde el resultado esperado del mem¥dump era el siguiente:

Memoria RAM de Arm:
Address Data

0: 0000000000000000000000000000000000000000000000000000000000000001

1: 0000000000000000000000000000000000000000000000000000000000000010

2: 0000000000000000000000000000000000000000000000000000000000000011

3: 0000000000000000000000000000000000000000000000000000000000001001

4: 1111111111111111111111111111111111111111111111111111111111111111

5: 1111111111111111111111111111111111111111111111111111111111110110

6: 1111111111111111111111111111111111111111111111111111111111110101

7: 0000000000000000000000000000000000000000000000000000000000000010

8: 0000000000000000000000000000000000000000000000000000000000000000

9: 0000000000000000000000000000000000000000000000000000000000001010

10: 0000000000000000000000000000000000000000000000000000000000010100

11: 0000000000000000000000000000000000000000000000000000000000001011

12: 1111111111111111111111111111111111111111111111111111111111111111

13: 0000000000000000000000000000000000000000000000000000000000000001

14: 0000000000000000000000000000000000000000000000000000000000000001

15: 0000000000000000000000000000000000000000000000000000000000000000

16: 0000000000000000000000000000000000000000000000000000000000000000

17: 0000000000000000000000000000000000000000000000000000000000010101

18: 0000000000000000000000000000000000000000000000000000000000000001

19: 0000000000000000000000000000000000000000000000000000000000000001

20: 0000000000000000000000000000000000000000000000000000000000011110

21: 0000000000000000000000000000000000000000000000000000000000001010




### Ejercicio 1

El objetivo de este ejercicio era integrar a nuestro procesador las instrucciones de LSL y LSR, las cuales sirven para shiftear bits hacia la izquierda y derecha respectivamente. Para ello fue necesaria la ampliación de varios archivos para que el procesador logre detectar las nuevas instrucciones.

- Maindec: Primero modificamos el archivo maindec.sv con el objetivo de asignar las señales de control activadas al decodificarlas, las cuales serviran para definir como debe comportarse el procesador
- Aludec: Luego de eso tuvimos que agregar un caso en base a la combinación de opcode y aluop, con el objetivo de avisarle a la ALU que operación debe ejecutar al llegar un LSL o LSR mediante la señal AluControl
- DataPath: Dentro del datapath se realizaron varios cambios. Primero que nada se agrego una conexion llamada **shamt**, la cual saca los bits [15:10] de la instrucción que entra al módulo de decode para llevarlos directamente al flopr.sv llamado ID_EX. Aqui se agregan en los bits mas significativos(bits [276:271]) para posteriormente ser pasado al módulo de Execute.
- Execute: Dentro del módulo de execute para lograr implementar las instrucciones de LSL y LSR se debio agregar una entrada mas a la Alu, la cual, estara conectada al shamt obtenido desde el ID_EX para ser utilizado dentro de esta para saber cuantos bits se deben shiftear. En la Alu tambien entra el AluControl enviado desde la Aludec, la cual nos determina que operación debera ejecutar esta, sirviendo para distingir entre las instrucciones que tiene implementadas nuestro procesador

A continuación se mostraran imagenes del esquema del procesador para mostrar los cambios al agregar la nueva señal de shamnt y su viaje por el datapath:

En la siguiente imagen podemos ver como la señál de shamt sale directamente desde el módulo de decode e ingresa al ID_EX flopr. Luego esta esta conectada al módulo execute, donde posteriormente mueve hasta la ALU. Una vez en esta podemos ver como verifica con los comparadores, que caso debe efectuarse 


<img width="1611" height="655" alt="ShamtDesdeDataPath" src="https://github.com/user-attachments/assets/015d5426-2646-43a9-97c2-7723a0060f3f" />


<img width="1617" height="782" alt="ShamtDesdeExecute" src="https://github.com/user-attachments/assets/22710033-541e-4f1c-b396-d5b1a0501a16" />


<img width="1600" height="837" alt="ShamtEnLaALU" src="https://github.com/user-attachments/assets/1efb9132-1391-4bb1-b2fb-2625555f3328" />






Para testear estos cambios se modifico el programa que nos devolvia escribia en memoria, que se utilizo para el testing una vez acabo el acondicionamiento pre-ejercicios para lograr que el pipeline funcione correctamente, de esta forma, solo tuvimos que verificar que las memorias daban los resultados esperados al incorporar el LSL y LSR en el programa.




```
	.text
	.org 0x0000
	
	STUR X1, [X0, #0]		// MEM 0
	STUR X2, [X0, #8]		// MEM 1
	STUR X3, [X16, #0]		// MEM 2
	ADD X3, X4, X5
	ADD XZR, XZR, XZR
	ADD XZR, XZR, XZR

	STUR X3, [X0, #24]		// MEM 3
	SUB X3, X4, X5
	ADD XZR, XZR, XZR
	ADD XZR, XZR, XZR

	STUR X3, [X0, #32]		// MEM 4
	SUB X4, XZR, X10
	ADD XZR, XZR, XZR
	ADD XZR, XZR, XZR

	STUR X4, [X0, #40]		// MEM 5
	ADD X4, X3, X4
	ADD XZR, XZR, XZR
	ADD XZR, XZR, XZR

	STUR X4, [X0, #48]		// MEM 6
	SUB X5, X1, X3
	ADD XZR, XZR, XZR
	ADD XZR, XZR, XZR

	STUR X5, [X0, #56]		// MEM 7
	AND X5, X10, XZR
	ADD XZR, XZR, XZR
	ADD XZR, XZR, XZR

	STUR X5, [X0, #64]		// MEM 8
	AND X5, X10, X3
	ADD XZR, XZR, XZR
	ADD XZR, XZR, XZR

	STUR X5, [X0, #72]		// MEM 9
	AND X20, X20, X20
	ADD XZR, XZR, XZR
	ADD XZR, XZR, XZR

	STUR X20, [X0, #80]		// MEM 10
	ORR X6, X11, XZR
	ADD XZR, XZR, XZR
	ADD XZR, XZR, XZR

	STUR X6, [X0, #88]		// MEM 11
	ORR X6, X11, X3
	ADD XZR, XZR, XZR
	ADD XZR, XZR, XZR

	STUR X6, [X0, #96]		// MEM 12
	ADD XZR, XZR, XZR
	ADD XZR, XZR, XZR

	LDUR X12, [X0, #0]
	ADD XZR, XZR, XZR
	ADD XZR, XZR, XZR

	ADD X7, X12, XZR
	ADD XZR, XZR, XZR
	ADD XZR, XZR, XZR

	STUR X7, [X0, #104]		// MEM 13
	STUR X12, [X0, #112]	// MEM 14
	ADD XZR, X13, X14
	STUR XZR, [X0, #120]	// MEM 15
	CBZ X0, L1
	ADD XZR, XZR, XZR
	ADD XZR, XZR, XZR
	ADD XZR, XZR, XZR

	STUR X21, [X0, #128]	// MEM 16
L1: STUR X21, [X0, #136]	// MEM 17
	ADD X2, XZR, X1
	ADD XZR, XZR, XZR
	ADD XZR, XZR, XZR

L2: SUB X2, X2, X1
	ADD X24, XZR, X1
	ADD XZR, XZR, XZR
	ADD XZR, XZR, XZR

	STUR X24, [X0, #144]	// MEM 18 y MEM 19
	ADD X0, X0, X8

	CBZ X2, L2
	ADD XZR, XZR, XZR
	ADD XZR, XZR, XZR
	ADD XZR, XZR, XZR

	STUR X30, [X0, #144]	// MEM 20
	ADD X30, X30, X30
	ADD XZR, XZR, XZR
	ADD XZR, XZR, XZR

	SUB X21, XZR, X21
	ADD X30, X30, X20
	ADD XZR, XZR, XZR
	ADD XZR, XZR, XZR

	LDUR X25, [X30, #-8]
	ADD X30, X30, X30
	ADD XZR, XZR, XZR
	ADD XZR, XZR, XZR

	ADD X30, X30, X16
	ADD XZR, XZR, XZR
	ADD XZR, XZR, XZR

	STUR X25, [X30, #-8]	// MEM 21
	STUR X15, [X0, #160]	// MEM 22
	// LSL X10, X15, #61
	ADD XZR, XZR, XZR
	ADD XZR, XZR, XZR
	
	STUR X10, [X0, #168]	// MEM 23
	// LSR X10, X15, #3
	ADD XZR, XZR, XZR
	ADD XZR, XZR, XZR

	STUR X10, [X0, #176]	// MEM 24

finloop: CBZ XZR, finloop

```


Para la utilización de los leds, se utilizo un programa que tiene 2 funciones distintas a realizar dependiendo de que switch este activo. Por simplicidad (ya que nos interesaba ver como elegir entre switchs, y nos parecio repetitivo hacerlo con todos) solamente admite el switch 1 y el switch 2. Cuando el estado del switch 1 esta en "1", los leds se van prendiendo secuencialmente de 4 en 4 apagando los 4 anteriores de derecha a izquierda, y luego alrevez. Si el estado del switch 2 esta en "1", todos los leds deben encenderse. Ambas secuencias de Leds(ambos casos) deberan permanecer haciendo su funcionalidad hasta que dicho switch sea apagado, por ejemplo, si yo prendo el switch 1, y luego prendo el switch 2, los leds seguiran realizando el patron del switch 1 hasta que este sea apagado  Para ello se utilizo el siguiente codigo:

```
		.text
	.org 0x0000
	//X29: direccion de LEDS 
	//X28: direccion de SW 

	//X30: bits de LED 
	//X10: para separar cada bit de los SWs (selector de casos)
    //X27: Indice para movernos entre los estados de los Switches

	LSL X29,X1,15		    //1000_0000_0000_0000? = 0x8000 Los leds
	ADD XZR,XZR,XZR
	ADD XZR,XZR,XZR

	ADD X28,X29,X8			//1000_0000_0000_1000? = 0x8008 Los SW
    ADD XZR,XZR,XZR
    ADD XZR,XZR,XZR
mainloop:
    ADD X27,X1,XZR          // Guardamos un 1 en x27 para iterar
innerloop:
	LDUR X30, [X28, #0]		//Leemos el estado de los SW 
    ADD XZR,XZR,XZR 
    ADD XZR,XZR,XZR 
	AND X10,X30,X27			//Seleccionamos el bit que queremos analizar  
	LSL X27,X27,1
    ADD XZR,XZR,XZR 
    ADD XZR,XZR,XZR 
	
	SUB X5, X10, X1
    ADD XZR,XZR,XZR 
    ADD XZR,XZR,XZR 
    ADD XZR,XZR,XZR
	CBZ X5, caso1
    ADD XZR,XZR,XZR
    ADD XZR,XZR,XZR
    ADD XZR,XZR,XZR
        
    SUB X5, X10, X2
    ADD XZR,XZR,XZR 
    ADD XZR,XZR,XZR 
    ADD XZR,XZR,XZR 
    CBZ X5, caso2
	ADD XZR,XZR,XZR 
	ADD XZR,XZR,XZR
	ADD XZR,XZR,XZR 
    

    SUB X5,X27,X16 
    ADD XZR,XZR,XZR 
    ADD XZR,XZR,XZR 
    ADD XZR,XZR,XZR 
    CBZ X5, mainloop
    ADD XZR,XZR,XZR 
    ADD XZR,XZR,XZR 
    ADD XZR,XZR,XZR 

return:
    STUR XZR,[X29,#0]
    ADD XZR,XZR,XZR 
    ADD XZR,XZR,XZR 
    ADD XZR,XZR,XZR 
	CBZ XZR, innerloop
	ADD XZR,XZR,XZR
	ADD XZR,XZR,XZR
	ADD XZR,XZR,XZR

caso1:
    ADD X26,X15,XZR         //X26 = 0000...0000 0000 0000 1111 
    ADD XZR,XZR,XZR 
    ADD XZR,XZR,XZR
    STUR X26,[X29,#0]       //Guardamos los primeros 4 bits 
    ADD XZR,XZR,XZR 
    ADD XZR,XZR,XZR 
    ADD XZR,XZR,XZR
    LSL X26,X26,4           //Movemos 4 bits 
    ADD XZR,XZR,XZR 
    ADD XZR,XZR,XZR 
    STUR X26,[X29,#0]       //Guardamos los SEGUNDOS 4 bits 
    ADD XZR,XZR,XZR 
    ADD XZR,XZR,XZR 
    ADD XZR,XZR,XZR
    LSL X26,X26,4           //Movemos 4 bits 
    ADD XZR,XZR,XZR 
    ADD XZR,XZR,XZR 
    STUR X26,[X29,#0]       //Guardamos los terceros 4 bits 
    ADD XZR,XZR,XZR 
    ADD XZR,XZR,XZR 
    ADD XZR,XZR,XZR
    LSL X26,X26,4           //Movemos 4 bits 
    ADD XZR,XZR,XZR 
    ADD XZR,XZR,XZR 
    STUR X26,[X29,#0]       //Guardamos los cuartos 4 bits 
    ADD XZR,XZR,XZR 
    ADD XZR,XZR,XZR 
    ADD XZR,XZR,XZR
    LSR X26,X26,4           //Movemos 4 bits 
    ADD XZR,XZR,XZR 
    ADD XZR,XZR,XZR 
    STUR X26,[X29,#0]       //Guardamos los SEGUNDOS 4 bits 
    ADD XZR,XZR,XZR 
    ADD XZR,XZR,XZR 
    ADD XZR,XZR,XZR
    LSR X26,X26,4           //Movemos 4 bits 
    ADD XZR,XZR,XZR 
    ADD XZR,XZR,XZR 
    STUR X26,[X29,#0]       //Guardamos los terceros 4 bits 
    ADD XZR,XZR,XZR 
    ADD XZR,XZR,XZR 
    ADD XZR,XZR,XZR
    LSR X26,X26,4           //Movemos 4 bits 
    ADD XZR,XZR,XZR 
    ADD XZR,XZR,XZR 
    STUR X26,[X29,#0]       //Guardamos los cuartos 4 bits

	LDUR X30, [X28, #0]		//Leemos el estado de los SW
    LSR X25,X27,#1          //Volvemos un cambio antes del X27 
    ADD XZR,XZR,XZR 
    ADD XZR,XZR,XZR 
	AND X10,X30,X25			 
    SUB X5, X10, X1       //Comparamos si el Switch 2 sigue prendido
    ADD XZR,XZR,XZR 
    ADD XZR,XZR,XZR 
    ADD XZR,XZR,XZR 
    CBZ X5, caso1
    ADD XZR,XZR,XZR 
    ADD XZR,XZR,XZR 
    ADD XZR,XZR,XZR
	CBZ XZR, return
    ADD XZR,XZR,XZR
    ADD XZR,XZR,XZR
    ADD XZR,XZR,XZR

caso2:
    ADD X14,XZR,XZR        //X14 = 0000...0000 0000 0000 0000
    ADD XZR,XZR,XZR 
    ADD XZR,XZR,XZR 
    LSL X14,X1,#16         //X14 = 0000..1 0000 0000 0000 0000 
    ADD XZR,XZR,XZR 
    ADD XZR,XZR,XZR 
    SUB X14,X14,X1         //X14 = 0000...1111 11111 1111 1111 
    ADD XZR,XZR,XZR 
    ADD XZR,XZR,XZR 
    STUR X14,[X29,#0]      // Prendo todos los leds 
    ADD XZR,XZR,XZR 
    ADD XZR,XZR,XZR 
    ADD XZR,XZR,XZR
innercaso2:
	LDUR X30, [X28, #0]		//Leemos el estado de los SW
    LSR X25,X27,#1          //Volvemos un cambio antes del X27 
    ADD XZR,XZR,XZR 
    ADD XZR,XZR,XZR 
	AND X10,X30,X25			 
    SUB X5, X10, X2       //Comparamos si el Switch 2 sigue prendido
    ADD XZR,XZR,XZR 
    ADD XZR,XZR,XZR 
    ADD XZR,XZR,XZR 
    CBZ X5, innercaso2
	ADD XZR,XZR,XZR 
	ADD XZR,XZR,XZR
	ADD XZR,XZR,XZR 
	CBZ XZR, return
    ADD XZR,XZR,XZR
    ADD XZR,XZR,XZR
    ADD XZR,XZR,XZR
     

endloop: 
	CBZ XZR, endloop

```

En la siguiente imagen podemos ver las señales de i_switch(la de color celeste), o_led(la de color violeta) y las señales de clk,reset y dump(las de color gris). En ella se ve reflejado los cambios en las señales anteriormente nombradas durante distintos estados de los switches, aunque lo que queremos mostrar principalmente es el primer caso, es decir, cuando el switch 1 esta encendido. Cuando el programa detecta que el switch 1 esta encendido prodece a prender los primeros 4 leds secuencialmente hasta hacer una ola de ida y otra de vuelta. Vemos que al final la señal de los leds tiene valor "000f" y esta dura un poco mas que las otras debido al procesamiento de control para decidir si repetir el bucle. Esto es debido a que el código solo hace vueltas completas hasta que se desactive el switch 1. Anteriormente a la inicializacioón del switch 1 podemos ver como al detectar que se cambio el switch activo, el programa resetea los leds y procede a prender todos juntos en un instante hasta que el switch 2 sea desactivado. 

<img width="1602" height="200" alt="imagen" src="https://github.com/user-attachments/assets/1b0466e8-9f50-43fa-8c9c-bc7c1350158e" />


Ahora mostraremos una imagen con el orden de activación de los switch invertidos. Primero encenderemos l switch 1 y luego el 2. En este caso podemos ver que el comportamiento es similar al mostrado en la imagen anterior pero invertido. La mayor diferencia es que ahora el "show de luces" del caso del switch 1 come mas tiempo del caso del switch 2, esto es debido a que una vez el programa detecta que se sigue en el switch 1, este no frenara hasta que se complete la ola de ida y vuelta de las luces, una vez termina y procesa que ahora esta el switch 2 encendido, procede a prender todos los leds, hasta que se apague el switch 2, por mas que luego vuelva a activar el switch 1


<img width="1295" height="223" alt="imagen" src="https://github.com/user-attachments/assets/91a6cef0-c519-4d36-bdb0-a9edba9a2303" />



### Ejercicio 2 
A continuación muestro imagenes de como quedo el procesador con Forwarding y Stall implementado


<img width="1618" height="716" alt="imagen" src="https://github.com/user-attachments/assets/a6cc9d61-903e-4fc8-8836-16c470d3b50d" />



En esta imagen mostramos como cambiamos que flopr de IF_ID_TOP por un FloprE, lo cual significa que tiene enbale, el cual viene directamente del datapath. Esa conexion vale 0 cuando hay que hacer stall y 1 cuando no es necesario

<img width="934" height="282" alt="imagen" src="https://github.com/user-attachments/assets/50db537a-b9aa-494f-bfa5-17a8c60de3d6" />


En la siguiente imagen vemos como modificamos el IF_ID conviertiendolo en un floprE, con un enable que viene del HDU(hazard detection unit), saliendoe ste del decode. Ademas se implemento el omodulo STALL, el cual es un multiplexor y se encarga de manejar los "stalls" poniendo en 0 todas las señales de control de ser necesario, si no es asi, el micro funciona con normalidad. Cabe aclarar, que estas señales de control ahora se dispersan por el resto del micro, permitiendo asi bloquear la ejecucion de la instruccion a stallear del micro de ser necesaria por 1 clock, lo cual es lo necesario para ahcer forwarding en la mayoria de casos. Deld ecode salen 3 señales, el  "stall control" el cual sirve como bit de seleccion del stall, el if_id_write que es el enable del IF_ID y el pc_write, el cual es el enable del floprE del PC(el cual ahora tambien es un flopre). Además el qID_EX, este valor se trae luego del flopr ID_EX y sirve para comparar si el registro que se escribe en el LDUR es el mismo o coincide con el usado en una tipo R del decode

<img width="1582" height="813" alt="imagen" src="https://github.com/user-attachments/assets/de175fba-b9b7-44e6-9733-e20ee635df5a" />


El forwarding unit trae el valor calculado de la ALU en la etapa memory y el valor de write back de la etapa write back, comparandolo con los registros que están en la etapa de decode. De coincidir alguno, se envian las señales de ForwardA y ForwardB las cuales son las señales de control apra los multiplexores que eligen que valores de registro pasarle a la ALU


Dentro del decode podemos encontrar el hazarddu, el cual se encarga de comparar todos los valores nuevos entrantes en el módulo de decode, para lograr verificar si existe un hazard de datos en las 2 instrucciones recientes

<img width="1475" height="795" alt="imagen" src="https://github.com/user-attachments/assets/7af423bb-675f-43af-ab7b-28367b9122a2" />



Dentro del execute podemos ver los 2 nuevos multiplexores los cuales eligen cual de las 3 anteriores opciones entra en la ALU, dependiendo de los read_data1 y read_data2. EL multiplexor B se conecta al anterior multiplexor original de la ALU antes de que sea implementada la forwarding unit


<img width="1589" height="750" alt="imagen" src="https://github.com/user-attachments/assets/e201eb89-6054-49ea-bc13-a942e103b23b" />








<img width="1594" height="761" alt="imagen" src="https://github.com/user-attachments/assets/253497b9-44ae-44b4-b1de-933eb02d78bf" />




















