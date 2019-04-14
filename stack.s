
			.text
			.global _start


_start:		LDR R4, =N		//R4 points to the N location
			LDR R2, [R4]	//R2 holds the number of elements in the list
			ADD R3,	R4, #4 	//R3 points to the first number 

PLOOP:		SUBS R2, R2, #1 // 	decrement the loop counter 
			BLT DONE		// branching to Done if R2 is lower than 0
			LDR R0, [R3] 	//R0 holds the number that is pointed by R3
			ADD R3, R3, #4	//R3 points to the next number in the list
			SUBS SP, SP, #4	//update the new top
			STR R0, [SP]	//set the new top element 
			B PLOOP          //branch back to the Ploop
						

DONE:		LDR R0, [SP]		//pop the top element into R0
			ADD SP, SP, #4		//update the new top by increasing SP
 			LDR R1, [SP]		//pop the top element into R1
			ADD SP, SP, #4		//update the new top by increasing SP
			LDR R2, [SP]		//pop the top element into R2
			ADD SP, SP, #4		//update the new top by increasing SP(return to its initial state)

END:		B END 				//infinite loop!


N:		 	.word	3
NUMBERS:	.word	5,6,10	//the list data
