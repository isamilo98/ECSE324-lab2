	.text
	.global _start

_start: LDR R0, =ARRAY // R0 points to ARRAY
		LDR R1, N // R1 contains the number of elements
		PUSH {R0, R1, LR} // push parameters(adress of the first element of the array and the number of element) and LR
		BL SUBROUTINE // call subroutine and stores the value of PC in LR
		LDR R0, [SP, #4] // load in the max value contained in the stack into R0
		STR R0, MAX // store in memory
		LDR LR, [SP, #8] // restore LR
		ADD SP, SP, #12 // remove params from stack
stop: B stop
	
SUBROUTINE: PUSH {R0-R3} // callee-save the registers SUBROUTINE will use
			 LDR R1, [SP, #20] // load param N from stack
			 LDR R2, [SP, #16] // load param ARRAY(adress of the first element) from stack
		 	MOV R0, #0 // set R0 to 0. will hold the futur max

findMax: SUBS R1, R1, #1 // decrement loop counter
	 	 BLT DONE	// if R1 less than 0 go to "DONE" label
	 	 LDR R3, [R2], #4 // load the value pointed by R2 in R3 and increment R2 by 4.
	  	 CMP R0, R3 // compare R0 and R3
	  	 BGE findMax // if R0 is greater or equal than R3 go back to "findMax" label
	 	 MOV R0, R3	// move R3 to R0 if R3 is greater than R0
	 	 B findMax	// unconditional branch to go back to findMax
	  
DONE:
	  STR R0, [SP, #20] // store the max value(contained in R0) on stack, replacing N
	  POP {R0-R3} // restore registers
	  BX LR	// branch to the adress contained in the link register

ARRAY: .word 6,5,4,3,2,1,24,13,12,11,100,9,8,7
N: .word 14
MAX: .space 4
.end 
