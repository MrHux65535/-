	.data
msg_t: 	.asciiz "\r\nSuccess! Location :"
msg_f: 	.asciiz "\r\nFail!\r\n"
s_end:	.asciiz "\r\n"
buf: 	.space 100
	
	.text
	.globl main
main:	  la $a0, buf #address of the string
        la $a1, 100 #Maximum number of the string
        li $v0, 8   #read string
        syscall

inChar: li $v0, 12
        syscall
        beq $v0, 63, exit #if(char == '?') exit
        add $t0, $0, $0
        la $s1,buf
		
findL:	lb $s0, 0($s1)
	
        beq $v0,$s0,success
        addi $t0, $t0, 1
        slt $t3, $t0, $a1
        beqz $t3, fail
        addi $s1,$s1,1
        j findL

success: la $a0, msg_t
         li $v0, 4  #print string
         syscall
         addi $a0, $t0, 1
         li $v0, 1 #print int
         syscall
         la $a0,s_end
         li $v0, 4
         syscall
         j inChar
	 
fail:	  la $a0, msg_f
        li $v0, 4
        syscall
        j inChar

exit:   li $v0, 10
        syscall	 

	
		
	  
	
