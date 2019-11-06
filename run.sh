#!/bin/bash

#Author: Hoanh Vo
#Author email: hvo123@csu.fullerton.edu
#Assignment 5 
#Purpose: This program compiles files, links objects and create executable file.

rm *.out
rm *.o

echo "Compile the driver module............................"
gcc -c -m64 -g -Wall -o cMain.o cal_hypotenuse.c -fno-pie -no-pie

echo "Assemble the asm file................................"
nasm -f elf64 -g -l asm_Manage.lis -o asmManage.o triangle_analyzer.asm

echo "Link object files ..................................."
gcc -Wall -m64 -g -o Final.out cMain.o asmManage.o -fno-pie -no-pie

echo "Run the executable-final File........................"
./Final.out
