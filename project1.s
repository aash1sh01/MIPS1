.data
												
reply:	
.space 10							        #Allowing 10 characters to input string
main:	
	li $s0, 0							#register to store sum of ASCII of valid values of the characters in our base system
	li $v0, 8						
	la $a0, reply							#Read input string
	li $a1, 11
	syscall
	la $s1, reply							#Loading reply's address as a base address to add and change characters, like first and second.
	addi $s4, $s1, 10 						#Using 10 to $s4 to signify end of loop.
Assign:	lb $a0, 0($s1)							
	j Checker							#Load each character, with load byte and incerementing $s1 by 1 so that we jump to next character next, finally jmping to filter to check if the input is valid.
Last:	beq $s4, $s1, End 						#Checking if 10 characters are done or not, if done, go to end of loop.
	addi $s1, 1							#increment address of reply by 1 until we've reached the end of the string
	j Assign					
Checker:li $t1, 48							#checks if the values are valid and in range for our base.
	li $t2, 57							#in our base characters 0 to 9 are valid, so the upper limit for the numeric characters is 57 which is 9, and the lower limit is 48 which means 0.
	li $t3, 64							#My Howard Id is 02986124, 02986124 mod 11= 9, and 26+9= 35, so base is 35 and the last valid ucase character is 'Y', hence $t4=89 , last valid lcase = 'y', hence $t6=121  
	li $t4, 89
	li $t5, 97
	li $t6, 121							#loading different values to registers to compare ASCII characters and filter if they are valid and also if the character is a number, lowercase or uppercase
	blt $a0, $t1, Invalid											
	bgt $a0, $t6, Invalid 						#checking whether the values are beyond the range or not, if yes we will jump to invalid, if no we will jump to isValid
	blt $a0, $t6, isvalid						
