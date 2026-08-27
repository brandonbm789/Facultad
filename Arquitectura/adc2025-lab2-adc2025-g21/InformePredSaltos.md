### Ejercicio 2

El código en assembler que utilizamos para realizar los analisis es el siguiente:

```
	ldr x7, N
begin:
	mov x5, #0		// i = 0
	mov x1, #0		// X = False

loop:
	cmp x5, #5		// para i > 5
	b.le end_if1
	mov x1, #1		// X = True
end_if1:
	cmp x1, #1		// para X == True
	b.ne end_if2
	mov x5, #10		// i = 10
end_if2:
	add x5, x5, #1	// i++
	cmp x5, #10		// para i < 10
	b.lt loop

	sub x7, x7, 1	// para el loop grande
	cmp x7, #0
	b.gt begin
```

Equivalente en C:

```
for(j = 0; j < 1024; j++) {
    for(i = 0; i < 10; i++) {
        if(i > 5) {				//b_if1
		    x = True;
        }
        if(x) {					//b_if2
            i = 10;
        }
    }							//b_loop
}
```

Cicla 6 veces, y la 7ma termina.
Es mejor el predictor global porque son 3 predicciones por ciclo.
b_loop: [T,T,T,T,T,T,T,NT] los dos predictores deducen T
b_if1:  [NT,NT,NT,NT,NT,NT,T] los dos predictores deducen NT
b_if2:  [NT,NT,NT,NT,NT,NT,T] local predice NT, pero global
predice T de estar en caliente. Porque depende de b_if1.
Con este ejemplo el predictor de torneo eligiria siempre 
al global sobre el local, por la falla que tuvo de mas el local en b_if2. Por lo que rinde igual al global.
El ciclo de j < 1024 lo pense para que se caliente el predictor global.

--- 

Predictor Local:

MISS RATE = 3080 / (26632 + 3080) = 10.3%

Predictor por torneo:

MISS RATE = 14 / (22545 + 14) = 0.06%

Basados en el valor del miss rate de cada predictor se ve la inmensa superioridad del predictor por torneo por sobre el predictor local
lo que nos muestra la gran mejoria que se obtiene cuando se utiliza el predictor por torneo para elegir por conveniencia entre el predictor local
y el predictor global.

--- 

Con caches asociativas por conjuntos de 2, 4 y 8 vias la cantidad de ciclos que se realizan no cambia debido a nuestro codigo assembler.
Con nuestro codigo estamos testeando la prediccion de los saltos, por lo que no nos interesa particularmente que haya una cache mas optima o 
menos optima, por lo que no va a cambiar independientemente de si la cache es de mapeo directo o de multiples vias, incluso con una cache 
de mapeo directo se tarda la misma cantidad de ciclos.

--- 

Debido a que las caches de 2, 4 y 8 vias no cambian para nada el resultado de la simulacion, hicimos un procesador out_of_order con 
predictor por torneo para los 3 tipos de cache, lo que nos terminó presentando la misma situacion que en el inciso anterior, nuevamente 
debido a que no nos interesa la cantidad de vias de la cache sino la prediccion de los saltos. Comparando con los resultados que nos dió con un 
procesador in_order, la diferencia mas notoria e importante es que con el procesador out_of_order se realizan mucha menos cantidad de ciclos, hay otras
estadisticas que tambien se diferencian pero son poco relevantes.








