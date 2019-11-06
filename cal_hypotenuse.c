//Author: Hoanh Vo
//Author email: hvo123@csu.fullerton.edu

//Program name: Assignment 5

//Purpose: This program is the Driver of the program
//language: C

#include "stdio.h"

extern double find_hypotenuse();

int main()
{
	double x;
	printf("Welcome to CPSC 240 brought to you by Hoanh Vo\n");
	
	x = find_hypotenuse();
	
	printf("This main program has received this number %10.10lf. Have a nice day.\n",x);
	printf("Main will return 0 to the operating system.\n");
	return 0;

}
