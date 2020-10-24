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
isvalid:bgt $a0, $t5, Lcase						#checking if characters are valid in our base system and categorizing them into individual branches by comparing stored ascii values.
	bgt $a0, $t2, Invalid
	bgt $a0, $t3, Ucase
	bgt $a0, $t4, Invalid
	bgt $a0, $t1, integer
integer:li $s2, -48							#Case 1: when character is integer
	add $s3, $a0, $s2						#if character is a numeric character
	add $s0, $s0, $s3						#storing the sum in $s0 after each character so that we can have the total value
	j Last								#We jump to last to check whether we reached the end of loop or not.
Lcase:	li $s2, -87							#Case 2: when the character is lowercase
	add $s3, $a0, $s2						
	add $s0, $s0, $s3						#substracting in the cases so that the refrence value is set for valid cases as the base is 10, 97-10=87
	j Last
Ucase:	li $s2, -55							#Case 3: when the character is uppercase						
	add $s3, $a0, $s2						
	add $s0, $s0, $s3
	j Last
Invalid:add $s0, $s0, $zero
	j Last								#if invalid, we add zero to the total value then go to next character
End:	li $v0, 1
	add $a0, $s0, $zero						#print the sum value stored in $s0 across all three cases
	syscall	
	li $v0, 10							#end once the output is printed
	syscall
					
