;Author: Hoanh Vo
;Author email: hvo123@csu.fullerton.edu
;Program name: Assignment 5

;Purpose: This program is control module
;language: x86-64 assembly

extern printf
extern scanf

global find_hypotenuse


segment .data
	welcome_message db "Welcome to Right Triangle Analyzer",10,0
	input_prompt_message db "Enter the lengths of the two legs of a right triangle separated by ws and press enter:",0
	confirm_message db "The length of the sides of the triangle are %10.10lf and %10.10lf.",10,0
	area_result_message db "The area of the triangle is %10.10lf units squared.",10,0
	hypotenuse_result_message db"The hypotenuse has length %10.10lf units.",10,0
	farwell_message db"This module will now return the hypotenuse to the caller.",10,0
	
	
	float_format db "%lf %lf",0
	string_format db "%s",0
segment .bss

segment .text 


find_hypotenuse:

;===== Backup all the GPRs ========================================================================================================
push rbp                                                    ;Backup the base pointer
mov  rbp,rsp                                                ;Advance the base pointer to start of the current 
push rdi                                                    ;Backup rdi
push rsi                                                    ;Backup rsi
push rdx                                                    ;Backup rdx
push rcx                                                    ;Backup rcx
push r8                                                     ;Backup r8
push r9                                                     ;Backup r9
push r10                                                    ;Backup r10
push r11                                                    ;Backup r11: printf often changes r11
push r12                                                    ;Backup r12
push r13                                                    ;Backup r13
push r14                                                    ;Backup r14
push r15                                                    ;Backup r15
push rbx                                                    ;Backup rbx
pushf                                                       ;Backup rflags
;Registers rax, rip, and rsp are usually not backed up.
;========================================================================================================

	mov rax,0
	mov rdi, welcome_message
	call printf
	
	mov rax, 0
	mov rdi, input_prompt_message
	call printf

;===============================get 2 float input numbers from user ============================================================================	


	push qword 0
	push qword 0
	
	mov rax, 0
	mov rdi, float_format
	mov rsi, rsp
	mov rdx, rsp
	add rdx, 8
	call scanf
	movsd xmm15, [rsp]	; xmm15 hold the 1st float number
	movsd xmm14, [rsp+8]	; xmm14 hold the 2nd float number
	
	pop rax
	pop rax

;===============================show the 2 float inputted numbers  =============================================================================	
;no need to use rax	mov rax, 2
	
	mov rdi, confirm_message
	movsd xmm0, xmm15
	movsd xmm1, xmm14
	call printf
;========================save a copy of float number from xmm14 to xmm13=======================
	movsd xmm13,xmm14		
	
;===============================multiply 2 float numbers =====================================
	mulsd xmm14,xmm15

;===============================show the area result=====================================
;no need to use rax	mov rax, 1	
	
	movsd xmm0,xmm14
	mov rdi, area_result_message
	call printf


;===============================calculating the hypotenuse===================
	mulsd xmm13,xmm13	;a^2
	mulsd xmm15,xmm15	;b^2
	addsd xmm13,xmm15	;  a^2+b^2
	sqrtsd xmm12, xmm13	;take square root , xmm12 =/ (a^2+b^2)

;===============================show the hypotenuse result=====================================	
	movsd xmm0,xmm12
	mov rdi, hypotenuse_result_message
 	call printf


;==========================farwell_message======================================================
	mov rax,0
	mov rdi, farwell_message
	call printf

;==========================send the hypotenuse (float) back to the main=================================
	movsd xmm0, xmm12
	



;===== Restore original values to integer registers ===============================================================================
popf                                                        ;Restore rflags
pop rbx                                                     ;Restore rbx
pop r15                                                     ;Restore r15
pop r14                                                     ;Restore r14
pop r13                                                     ;Restore r13
pop r12                                                     ;Restore r12
pop r11                                                     ;Restore r11
pop r10                                                     ;Restore r10
pop r9                                                      ;Restore r9
pop r8                                                      ;Restore r8
pop rcx                                                     ;Restore rcx
pop rdx                                                     ;Restore rdx
pop rsi                                                     ;Restore rsi
pop rdi                                                     ;Restore rdi
pop rbp                                                     ;Restore rbp

ret

