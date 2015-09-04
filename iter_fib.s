# Anish Dalal
# adalal1@jhu.edu

print_int = 1
print_string = 4
read_int = 5

	.text
#
#
main:
	addi	$sp, $sp, -8
	sw	$ra, 4($sp)

	li	$v0, read_int
	syscall

	move	$a0, $v0
	jal	fibon

	move	$a0, $v0
	li	$v0, print_int
	syscall

	la	$a0, lf
	li	$v0, print_string
	syscall

	lw	$ra, 4($sp)
	addi	$sp, $sp, 8

	jr	$ra

fibon:
	li $t0, 0
	beq $a0, $t0, return_input
	li $t1, 1
	beq $a0, $t1, return_input
	blez $a0, return_negative
	
start:
	li $t0, 0 # F(n-2)
	li $t1, 1 # F(n-1)
	li $t2, 1 # counter. starts at 1
	# because if you were trying
	# to find the 2nd Fibo number
	# (starting from 0), then you
	# count 0, 1, 1. 1 is the second
	# Fibo number, but the loop must
	# run once to know that
loop:
	move $t3, $t1
	add $t1, $t0, $t1 #$t1 now holds the sum
	move $t0, $t3 # set F(n-2) as the previous number
	# so you can compute the sum plus the previous number
	addi $t2, $t2, 1

	bne $t2, $a0, loop # if the loop counter does not
	# equal the desired iteraton, then continue looping

done:
	move $v0, $t1
	jr $ra

	
return_input:
	move $v0, $a0
	jr $ra

return_negative:
	la $a0, error
	li $v0, print_string
	syscall
	la $a0, lf
	li $v0, print_string
	syscall

	li $v0, 10
	syscall
	.data
error:
	.asciiz "Can't enter negative numbers. Quitting now...\n"
lf:
	.asciiz	"\n"
	.end
 

