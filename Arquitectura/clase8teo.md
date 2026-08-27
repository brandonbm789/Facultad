SRAM: la memoria mas rapida, la estatica, para almacenar una celda se necesitan 6 transistores, responde a tiempos de procesador.
DRAM: memoria mas lenta pero que usa un transistor en lugar de 6, pero guarda bits en capacitores que duran poco por lo que hay que recargar el bit de forma constante
tambien hay que sincronizar la lectura par que no lea mal.

### Principio de localidad de referencia
respecto a mi referencia actual(el procesador accede ahora mismo a esta direccion) dice que la probabilidad de acceso decrece a medida que me alejo de la referencia actual (si 
estoy en la 100, las mas probables de acceso son 99 y 101) este principio viene por el orden secuencial de ejecucion de instrucciones (PC + 4) y de los loops en instrucciones
Por el Principio, se accede a una porcion pequena de la memoria
"Cuando la cantidad de memoria aumenta excesivamente, eso no tiene efecto alguno en el pedazo de bloque de "prediccion" que uso para el acceso a memoria segun el principio
tiende a 0 la probabilidad de acceso a esa memoria"

GHZ = cuantos ciclos se hicieron en un segundo, la inversa de eso me da cuanto dura un periodo de clock  
Giga es * 10^9 nano es elevado a la -9 

el acceso a la memoria consume 15 ciclos(?) el procesador hace inicialmente un acceso a la cache (1 ciclo)
por cada bloque de memoria (en el caso de 4 bloques de memoria) cada uno hace un acceso a la cache (que consume un ciclo), supuestamente estos accesos a cada blooque es de 15
pero la busqueda se realiza en paralelo por lo que solo se suma 15 una vez, pero hay un "cuello de botella" donde cada bloque debe acceder a cache una vez (o dijo que 
se tiene que llevar cada bloque aunque solo acceda uno?)(4 * 1)
Si bien el one-word-wide es mas rapido, solo lleva una word en vez de 4, el 4-word wide es mas rapido pero necesita una cache mas amplia.

En el primer son 4B de una palabra, el segundo son 16B de 4 palabras (como el ancho es de 4 words y cada word son 4 bytes)y el ultimo es de 16B de 4 palabras 
                                    
### Flash storage 

#### Disk 
- EL tiempo de acceso a un disco duro es todo un calculo que esta en las filminas (leer)
* Cache: El modulo de memoria mas cercano al procesador 
- Como se si algo esta en la cache y en donde? memoria cache directamente mapeada
* memoria cache directamente mapeada: Cada direccion son 5 bits (hasta 32 direcciones) para mapear la memoria en cache buscamos los 3 bits menos significativos de la direccion de memoria
todas las direcciones que coincidan en los ultimos 3 bits iran al mismo lugar en la cache
"en el ejemplo como hay 2 bits de diferencia entre memoria y cache, es 4 veces mas chica la cache"
En la Cache tengo 1 bit de validez que dice si hay datos en esa posicion o no, un tag que son los bits que me faltan para completar la direccion de memoria y finalmente los datos

#### Ejercicios
1)
a. Verdadero
b. Falso, es al reves
c. Falso
d. Verdadero
e. Verdadero

2) tomando como 0.5 el acceso de SRAM, leer un dato en cache es de un clock, 0.5 < 0.59. De acceso a memoria principal tomando el acceso como 50ns, tarda 85 ciclos del clock 

----
La Cache es autonoma, el procesador nunca se entera de la existencia de la cache y la memoria principal tampoco 

#### Memoria Cache

Se pone en el medio entre la CPU y la memoria principal

Cuando la CPU quiere hacer la memoria, a tiempos despreciables casi instantaneos tiene que determinar si el dato que se pide la Cache lo tiene o no, la RAM no hace eso, se pide la 
posicion 20 y se la da (Acceso aleatorio), por lo que la Cache es una memoria rara que usa acceso asociativo, determinar si esta o no es Hit o Miss. Si hay un Hit se devuelve la memoria 
en medio nanosegundo sin que la memoria principal se entere. Pero si hay un fallo hay una ligera tardanza y se accede a la memoria principal que tardara lo que debe en tiempo de RAM
dando el dato a la CPU que tambien absorbe la Cache. La cache si falla es como si no estuviera, no empeora la perfomance, a lo sumo la mejora. 

una palabra como ocupa 32 bits en las filminas, accederla ocupa 4 posiciones de memoria, por eso es PC + 4. palabra de acceso es 1 byte, de 0 a 2^n  -1 con n cantidad de bits de direccion

Si la cache tira Miss, al tener que acceder a memoria principal, aprovecho para traer mas que un byte, el movimiento se hace por bloques, al tener que acceder a una palabra, es muy
probable segun el principio temporal que se acceda a la misma palabra, pero el principio de localidad espacial dice que es muy probable que se accedan las direcciones cercanas
por lo que si traigo la direccion 10, aprovecho para traer la 11, 12 y 13. Pero no es que traigo esas direcciones en especifico, traigo el bloque completo donde se encuentra la 10
por lo que tambien hay que determinar la ubicacion de la direccion 10.

un bloque con k palabras, en memoria principal tengo 2^n / k bloques

Una memoria asociativa esta organizada por lineas y no por palabras, junto al area de datos de cada linea hay minimamente un campo de tag. Para el acceso se realiza una consulta a partir del tag
Pero la busqueda no es secuencial, porque asi no se responderia tan rapido, se realiza la consulta de forma secuencial.
Por definicion una linea debe tener el tamanio justo para almacenar un bloque de la memoria principal.

que hay mas? bloques de MP o lineas en Cache? Bloques obviamente 

dentro de una linea se distinguen las direcciones del blooque.

#### Cache de mapeo directo

hay un bit de validacion, y un campo de index.

En el ejemplo cada bloque es de 1 palabra de 32 bits por eso se mueven de a 4 por cada direccion.
Luego sacando los 2 bits menos significativos, los 3 bits menos significativos que me quedan (en caso de que la cache tenga 8 lineas (2^3))me indican el numero de bloque.
Luego para saber que bloque se esta guardado en este momento te lo dice los bits mas significativos, dice que "vez" estoy viendo ahora.
Es decir, el index me dice en que linea esta guardado en la cache y el tag que guarda los bits mas significativos me dice que bloque especifico se esta guardando por la vez
la memoria principal se puede gaurdar tantas veces como 8 bloques entren en la cache (porque la cache es de 8)
Con este acceso yo no necesito verificar en cada linea de la cache, ya que cada bloque se puede guardar exactanente en una sola linea.
"Un bloque contiene una palabra, no quiero acceder a partes de la palabra, por eso no necesito indexar dentro de la misma liena, quiero todo (CREO, buscar)"

En la realidad puede haber bloques de varias palabras 
Esto haria que una linea se divida en por ejemplo    | palabra 1 | palabra 2 | palabra 3 | palabra 4 |
para diferenciar entre esas palabras usaria 2 bits para el offset byte y usaria 2 bits de direccion para diferenciar entre esas 4 palabras 
seria Tag|Index|wordIndex(2)|byteOffset(2)





#### Criterios de correspondencia
Directo, el Cacheo de mapeo directo, la gran ventaja es no tener que comparar las lineas para buscar un bloque
Asociativo
De conjunto?

---

En el libro los ejercicios estan resueltos
Ejercicios 3)
que diga que son palabras de 32 y la memoria se organiza de a bytes dice que el offset es de 2 





