.data
pedir_dato: .asciiz "Ingrese un numero: "
cuantos_numeros: .asciiz "Cuantos numeros desea comparar: " 
mensaje_invalido: .asciiz "Solo se puede comparar de 3 a 5 numeros \n"
minimo_mensaje: .asciiz "El numero menor es: "
num:.word 5 #Maximo de entradas permitido


.bss
numeros: .space 20
minimo: .space 4
 
.text
.globl main

main:
#Preguntar al usuario numeros a comparar
li $v0, 4
la $a0, cuantos_numeros
syscall

li $v0, 5
syscall
move $t0, $v0 #guardar el numero leido en $t0

#validar que el numero este en el rango 3 y 5
li $t1, 3
li $t2, 5
blt $t0, $t1, entrada_invalido
bgt $t0, $t2, entrada_invalido

#Si el numero es valido, continuar con lectrura de numeros
jal get_valido

#mostrar el numero maximo digitado por usuario
li $v0, 4
la $a0, minimo_mensaje
syscall

li $v0, 1
lw $a0, minimo
syscall 

#Salir del programa
li $v0, 10
syscall

entrada_invalido:
#Mostrar mensaje error
li $v0, 4
la $a0, mensaje_invalido
syscall 

#Salir del programa
li $v0, 10
syscall

get_valido:
#leer numeros del usuario
li $t3, 0#Inicializar indice de array 
li $t4, 0#Inicialiazar el maximo


cargar_loop:
#Mostrar dato ingresado
li $v0, 4
la $a0, pedir_dato
syscall

#Leer numero del usuario
li $v0, 5
syscall
move $t5, $v0 #Guardar el numero leido en $t5

#Almacenar el numero leido en el array numeros
mul $t7, $t3, 4 #Calcula la direccion de almacenamiento
sw $t5, numeros($t7)

#Comparar y almacenar el numero maximo
bnez $t3, comparacion
move $t4, $t5 #Primer numero es el indice minimo
move $t4, $t5# Actualizar el maximo si es necesario
j incremento

comparacion:
bge $t5, $t4, saltar_cmp
move $t4, $t5 #Actualizar el minimo si es necesario

saltar_cmp:
#Incrementar el indice y el contador
addi $t3, $t3, 1
blt $t3, $t0, cargar_loop

#Almacenar el numero minimo 
sw $t4, minimo
jr $ra

incremento:
#incrementar el indice y contador
addi $t3, $t3, 1
blt $t3, $t0, cargar_loop

#almacenar el numero minimo
sw $t4, minimo
jr $ra





