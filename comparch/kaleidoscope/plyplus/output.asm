.data
exit_msg: .asciiz "Program finished:\n"
newline: .asciiz "\n"
.text
.globl main
factorial:
add s0, zero, sp
sw ra, 0(sp)
addi sp, sp, -4
lw a0, 4(s0)
sw a0, 0(sp)
addi sp, sp, -4
addi a0, zero, 0
lw t1, 4(sp)
addi sp, sp, 4
beq t1, a0, true_0
false_0:
lw a0, 4(s0)
sw a0, 0(sp)
addi sp, sp, -4
sw s0, 0(sp)
addi sp, sp, -4
lw a0, 4(s0)
sw a0, 0(sp)
addi sp, sp, -4
addi a0, zero, 1
lw t1, 4(sp)
addi sp, sp, 4
sub a0, t1, a0
sw a0, 0(sp)
addi sp, sp, -4
jal ra, factorial
lw t1, 4(sp)
addi sp, sp, 4
blt t1, a0, true_2
false_2:
add t2, zero, a0
add a0, zero, t1
jal ra, mult_1
true_2:
add t2, zero, t1
addi t3, zero, 0
mult_1:
beq t2, zero, exit_2
add t3, t3, a0
addi t2, t2, -1
jal ra, mult_1
exit_2:
add a0, zero, t3
add t3, zero, zero
jal zero, exit_0
true_0:
addi a0, zero, 1
exit_0:
lw ra, 4(sp)
addi sp, sp, 12
lw s0, 0(sp)
jalr ra, ra, 0
main:
sw s0, 0(sp)
addi sp, sp, -4
addi a0, zero, 7
sw a0, 0(sp)
addi sp, sp, -4
jal ra, factorial


exit:
sw a0, 0(sp)
addi sp, sp, -4
	# Print message
	li  $v0, 4
	la  $a0, exit_msg
	syscall
	# Restore the result of the program which is on the stack
lw a0, 4(sp)
addi sp, sp, 4
	li  $v0, 1
	syscall
	# Print one last new line
	li $v0, 4
	la $a0, newline
	syscall
	# Exit the program
	li $v0, 10
	syscall
