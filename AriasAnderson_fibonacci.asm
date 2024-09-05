.data
ingresar_cantidad: .asciiz "Ingrese la cantidad de numeros de la serie Fibonacci: "
nueva_linea: .asciiz "\n"
mostrar_serie: .asciiz "Serie Fibonacci: "
suma_serie: .ascii"Suma total para la serie: "


.text 
.globl main

main:
#mostrar la cantidad al usuario 
li $v0, 4
la $a0, ingresar_cantidad
syscall 

#leer el numero ingresado por el usuario
li $v0, 5
syscall 
move $t0, $v0 #Guardar el numero en $t0 iterando

#inicializar los primeros valores de la serie fibonacci
li $t1, 0 #fib1 = 0
li $t2, 1 #fib2 =1
li $t3, 0 #sum = 0 
li $t4, 1 #contador = 1


#Mostrar serie fibonacci
li $v0, 4
la $a0, mostrar_serie
syscall 

#Loop para generar y mostrar serie fibonacci
fibonacci_loop:
bge $t4, $t0, fin_fibonacci_loop #Si el contador es mayor o igual a n, sale del loop

#Mostrar el valor de fibo1
li $v0, 1
move $a0, $t1
syscall 

#Mostrar un espacio
li $v0, 4
la $a0, nueva_linea
syscall 

#sumar el valor de fib1 a la suma total
add $t3, $t3, $t1

#calcular el siguiente numero en la serie fibonacci
add $t5, $t1, $t2 #fibo_siguiente= fibo1 + fibo2
move $t1, $t2 # fibo1 = fibo2
move $t2, $t5 # fibo2 = fibo_siguiente

#incrementar el contador
addi $t4, $t4, 1
j fibonacci_loop

fin_fibonacci_loop:

#Sumar el ultimo numero de la serie antes de que cierre el bucle
add $t3, $t3, $t1

#mostrar el ultimo numero de la serie
li $v0, 1
move $a0, $t1
syscall 

#Mostrar un salto de linea
li $v0, 4
la $a0, nueva_linea
syscall

#mostrar suma de la serie
li $v0, 4
la $a0, suma_serie
syscall

#Mostrar la suma total
li $v0, 1
move $a0, $t3
syscall

#salir del programa
li $v0, 10
syscall
