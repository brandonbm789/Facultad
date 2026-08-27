# Descargen QEMU
Si estan en arch, descargen el paquete ```pacman -S qemu-emulators-full```, si estan en fetora creo que se llama qemu-user.
Y tambien tengan gcc.

# Configurar el assembler
En el codigo esta la llamada a la funcion para recompilar los datos que usa GEM5, ```bl	m5_dump_stats```.
Tienen que eliminarlo sino QEMU no va a tener ni idea de que hacer.

# Compilar y ejecutar
    * Compilar ```aarch64-linux-gnu-gcc ej_daxpy.s -static```, les va a crear el binario a.out.
    * Ejecutar ```qemu-aarch64 ./a.out```, si no dice nada tipo ningun seg fault entonces probablemente anduvo bien...
    * Check ```echo $?```, masomenos les puede decir que fallo. Ej 139 devuelve si tuvo un seg fault al ejecutarlo.
