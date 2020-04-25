	.data
u_word: .asciiz
	      "Alpha ","Bravo ","China ","Delta ","Echo ","Foxtrot ",
        "Golf ","Hotel ","India ","Juliet ","Kilo ","Lima ",
        "Mary ","November ","Oscar ","Paper ","Quebec ","Research ",
        "Sierra ","Tango ","Uniform ","Victor ","Whisky ","X-ray ",
        "Yankee ","Zulu "
l_word: .asciiz
	      "alpha ","bravo ","china ","delta ","echo ","foxtrot ",
        "golf ","hotel ","india ","juliet ","kilo ","lima ",
        "mary ","november ","oscar ","paper ","quebec ","research ",
        "sierra ","tango ","uniform ","victor ","whisky ","x-ray ",
        "yankee ","zulu "
w_offset: .word
          0,7,14,21,28,34,
          43,49,56,63,71,77,
          83,89,99,106,113,121,
          131,139,146,155,163,171,
          178,186
number: .asciiz
	      "zero ", "First ", "Second ", "Third ", "Fourth ",
        "Fifth ", "Sixth ", "Seventh ","Eighth ","Ninth "
n_offset: .word
         0,6,13,21,28,36,43,50,59,67
        
	.text
	.globl main
main: 	li $v0,12     #read character
        syscall	
        beq $v0,63,exit		# v0 == '?' exit
        blt $v0,48,others 	# v0 < '0'
        bgt $v0,122,others 	# v0 > 'z'
	
	
        ble $v0,57,getNum	# v0 >= '0'&& v0 <= '9'	
        blt $v0,65,others	# v0 > '9'&& v0 < 'A' && v0 != '?'
        ble $v0,90,getUword	# v0 >= 'A'&& v0 <= 'Z' 
        blt $v0,97,others	# v0 > 'Z'&& v0 < 'a'
        ble $v0,122,getLword	# v0 >= 'a'&& v0 <= 'z'

others:	and $a0,$0,$0
        add $a0,$a0,42 # '*'
        li $v0, 11 # print character
        syscall
        j main
	
getNum:	sub $t2,$v0,48
        sll $t2,$t2,2
        la  $s0,n_offset
        add $s0,$s0,$t2
        lw  $s1,($s0)
        la  $a0, number
        add $a0,$a0,$s1
        li  $v0,4
        syscall
        j main
getUword:sub $t3,$v0,65
         sll $t3,$t3,2
         la  $s0,w_offset
         add $s0,$s0,$t3
         lw  $s1,($s0)
         la  $a0, u_word
         add $a0,$a0,$s1
         li  $v0,4
         syscall
         j main
getLword:sub $t3,$v0,97
         sll $t3,$t3,2
         la  $s0,w_offset
         add $s0,$s0,$t3
         lw  $s1,($s0)
         la  $a0, l_word
         add $a0,$a0,$s1
         li  $v0,4
         syscall
         j main


exit: 	li $v0, 10 # exit
        syscall
