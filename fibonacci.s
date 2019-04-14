		.text
		.global _start


_start: 	LDR R0, =N  // R0 point to the N location
			LDR  R1, [R0]  // R1 holds the number
			LDR R2 , [R0,#4]// R2 holds the result
			PUSH {R1,R2,LR} //push parameters and LR. (save initial parameters)
			BL FIB //call subroutine fibonacci
			STR R2, result //store the result in the memory
			POP {R1,R2,LR} //restore the initial parameters and clear the stack
			B END //branch to end



FIB: 
	PUSH {R1,R2,LR} //callee- save the reigisters and Lr that will be used
	CMP R1 , #2 //check if the number is less than 2
	BLT LESSTHANTWO //go to lessthanwto branch if its equal to 0 or 1.
	
	sub R1, R1, #1 //n-1 case
	BL FIB //recall the subroutine
	
	LDR R1, [sp]//load the present value 
	sub R1, R1, #2//n-2 case
	
	BL FIB//recall the subroutine
	POP {R1,R2,LR} //update SP to the next value
	LDR R1, [sp]//load the root value to continue the recursion.(back in the tree)
	STR R2, [SP,#4]//store the summation for the previous root
	BX LR//return to the LR address

LESSTHANTWO: 
			 	POP {R1,R2,LR} //remove values that we used and update SP to the next value
				ADD R2, R2,#1 //compute the summation
				STR R2, [SP,#4] //store it in the stack (update the sumation)
				STR R2, [SP,#16] //store the summation in the stack for the second previous root			 
			 	BX LR // return to the Lr address


END:   	B END  //infinte loop

N: .word 10
result: .word 0
