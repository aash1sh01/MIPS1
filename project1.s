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