	.file	"test_opt.vhdl"
	.text
	.p2align 4,,15
.globl work__test_opt__ELAB
	.type	work__test_opt__ELAB, @function
work__test_opt__ELAB:
	pushl	%ebp
	movl	%esp, %ebp
	popl	%ebp
	ret
	.size	work__test_opt__ELAB, .-work__test_opt__ELAB
	.p2align 4,,15
.globl work__test_opt__ARCH__test__ELAB
	.type	work__test_opt__ARCH__test__ELAB, @function
work__test_opt__ARCH__test__ELAB:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%ebx
	subl	$20, %esp
	movl	8(%ebp), %ebx
	movl	$work__test_opt__ARCH__test__RTI, (%ebx)
	leal	8(%ebx), %eax
	movl	%ebx, (%esp)
	movl	%eax, 12(%esp)
	movl	$work__test_opt__ARCH__test__P0__RTI, 8(%esp)
	movl	$work__test_opt__ARCH__test__P0__PROC, 4(%esp)
	call	__ghdl_process_register
	movl	$1, 8(%ebx)
	movl	$1, 12(%ebx)
	movl	$1, 16(%ebx)
	movl	$1, 20(%ebx)
	movl	$1, 24(%ebx)
	movl	$1, 28(%ebx)
	addl	$20, %esp
	popl	%ebx
	popl	%ebp
	ret
	.size	work__test_opt__ARCH__test__ELAB, .-work__test_opt__ARCH__test__ELAB
	.p2align 4,,15
	.type	work__test_opt__ARCH__test__P0__PROC, @function
work__test_opt__ARCH__test__P0__PROC:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$40, %esp
	movl	8(%ebp), %edx
	movl	$_UI00000002.1049, -8(%ebp)
	movl	$work__test_opt__ARCH__test__P0__U1__STB.1050, -4(%ebp)
	movl	12(%edx), %eax
	movl	28(%edx), %ecx
	sall	$6, %eax
	movl	%eax, 8(%edx)
	movl	20(%edx), %eax
	andl	$1, %eax
	movl	%eax, 16(%edx)
	movl	%ecx, %eax
	sarl	$31, %eax
	shrl	$25, %eax
	addl	%ecx, %eax
	sarl	$7, %eax
	movl	%eax, 24(%edx)
	leal	-8(%ebp), %eax
	movl	%eax, (%esp)
	movl	$0, 12(%esp)
	movl	$_UI00000001.1047, 8(%esp)
	movb	$0, 4(%esp)
	call	__ghdl_report
	call	__ghdl_process_wait_exit
	leave
	ret
	.size	work__test_opt__ARCH__test__P0__PROC, .-work__test_opt__ARCH__test__P0__PROC
	.p2align 4,,15
.globl work__test_opt__ARCH__test__P0__lsb
	.type	work__test_opt__ARCH__test__P0__lsb, @function
work__test_opt__ARCH__test__P0__lsb:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%ebx
	subl	$20, %esp
	movl	16(%ebp), %eax
	movl	$2, (%esp)
	movl	%eax, 4(%esp)
	call	__ghdl_integer_exp
	movl	12(%ebp), %edx
	movl	%eax, %ebx
	movl	%edx, %eax
	sarl	$31, %edx
	idivl	%ebx
	testl	%edx, %edx
	je	.L8
	movl	12(%ebp), %eax
	xorl	%ebx, %eax
	js	.L11
.L8:
	addl	$20, %esp
	movl	%edx, %eax
	popl	%ebx
	popl	%ebp
	ret
	.p2align 4,,7
	.p2align 3
.L11:
	addl	%ebx, %edx
	addl	$20, %esp
	movl	%edx, %eax
	popl	%ebx
	popl	%ebp
	ret
	.size	work__test_opt__ARCH__test__P0__lsb, .-work__test_opt__ARCH__test__P0__lsb
	.p2align 4,,15
.globl work__test_opt__ARCH__test__P0__decalage_gauche
	.type	work__test_opt__ARCH__test__P0__decalage_gauche, @function
work__test_opt__ARCH__test__P0__decalage_gauche:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%ebx
	subl	$20, %esp
	movl	16(%ebp), %eax
	movl	12(%ebp), %ebx
	movl	$2, (%esp)
	movl	%eax, 4(%esp)
	call	__ghdl_integer_exp
	addl	$20, %esp
	imull	%eax, %ebx
	movl	%ebx, %eax
	popl	%ebx
	popl	%ebp
	ret
	.size	work__test_opt__ARCH__test__P0__decalage_gauche, .-work__test_opt__ARCH__test__P0__decalage_gauche
	.p2align 4,,15
.globl work__test_opt__ARCH__test__P0__decalage_droit
	.type	work__test_opt__ARCH__test__P0__decalage_droit, @function
work__test_opt__ARCH__test__P0__decalage_droit:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$8, %esp
	movl	16(%ebp), %eax
	movl	$2, (%esp)
	movl	%eax, 4(%esp)
	call	__ghdl_integer_exp
	movl	12(%ebp), %edx
	leave
	movl	%eax, %ecx
	movl	%edx, %eax
	sarl	$31, %edx
	idivl	%ecx
	ret
	.size	work__test_opt__ARCH__test__P0__decalage_droit, .-work__test_opt__ARCH__test__P0__decalage_droit
.globl work__test_opt__RTI
	.section	.rodata
	.align 4
	.type	work__test_opt__RTI, @object
	.size	work__test_opt__RTI, 28
work__test_opt__RTI:
	.byte	4
	.byte	1
	.byte	0
	.byte	0
	.long	work__test_opt__RTISTR
	.long	0
	.long	work__RTI
	.long	8
	.long	0
	.long	work__test_opt__RTIARRAY
.globl work__test_opt__ARCH__test__INSTSIZE
	.align 4
	.type	work__test_opt__ARCH__test__INSTSIZE, @object
	.size	work__test_opt__ARCH__test__INSTSIZE, 4
work__test_opt__ARCH__test__INSTSIZE:
	.long	32
.globl work__test_opt__ARCH__test__P0__a__RTI
	.align 4
	.type	work__test_opt__ARCH__test__P0__a__RTI, @object
	.size	work__test_opt__ARCH__test__P0__a__RTI, 16
work__test_opt__ARCH__test__P0__a__RTI:
	.byte	13
	.byte	2
	.byte	0
	.byte	0
	.long	work__test_opt__ARCH__test__P0__a__RTISTR
	.long	0
	.long	std__standard__integer__RTI
.globl work__test_opt__ARCH__test__P0__b__RTI
	.align 4
	.type	work__test_opt__ARCH__test__P0__b__RTI, @object
	.size	work__test_opt__ARCH__test__P0__b__RTI, 16
work__test_opt__ARCH__test__P0__b__RTI:
	.byte	13
	.byte	2
	.byte	0
	.byte	0
	.long	work__test_opt__ARCH__test__P0__b__RTISTR
	.long	4
	.long	std__standard__integer__RTI
.globl work__test_opt__ARCH__test__P0__c__RTI
	.align 4
	.type	work__test_opt__ARCH__test__P0__c__RTI, @object
	.size	work__test_opt__ARCH__test__P0__c__RTI, 16
work__test_opt__ARCH__test__P0__c__RTI:
	.byte	13
	.byte	2
	.byte	0
	.byte	0
	.long	work__test_opt__ARCH__test__P0__c__RTISTR
	.long	8
	.long	std__standard__integer__RTI
.globl work__test_opt__ARCH__test__P0__d__RTI
	.align 4
	.type	work__test_opt__ARCH__test__P0__d__RTI, @object
	.size	work__test_opt__ARCH__test__P0__d__RTI, 16
work__test_opt__ARCH__test__P0__d__RTI:
	.byte	13
	.byte	2
	.byte	0
	.byte	0
	.long	work__test_opt__ARCH__test__P0__d__RTISTR
	.long	12
	.long	std__standard__integer__RTI
.globl work__test_opt__ARCH__test__P0__e__RTI
	.align 4
	.type	work__test_opt__ARCH__test__P0__e__RTI, @object
	.size	work__test_opt__ARCH__test__P0__e__RTI, 16
work__test_opt__ARCH__test__P0__e__RTI:
	.byte	13
	.byte	2
	.byte	0
	.byte	0
	.long	work__test_opt__ARCH__test__P0__e__RTISTR
	.long	16
	.long	std__standard__integer__RTI
.globl work__test_opt__ARCH__test__P0__f__RTI
	.align 4
	.type	work__test_opt__ARCH__test__P0__f__RTI, @object
	.size	work__test_opt__ARCH__test__P0__f__RTI, 16
work__test_opt__ARCH__test__P0__f__RTI:
	.byte	13
	.byte	2
	.byte	0
	.byte	0
	.long	work__test_opt__ARCH__test__P0__f__RTISTR
	.long	20
	.long	std__standard__integer__RTI
.globl work__test_opt__ARCH__test__P0__RTI
	.align 4
	.type	work__test_opt__ARCH__test__P0__RTI, @object
	.size	work__test_opt__ARCH__test__P0__RTI, 28
work__test_opt__ARCH__test__P0__RTI:
	.byte	6
	.byte	2
	.byte	0
	.byte	0
	.long	work__test_opt__ARCH__test__P0__RTISTR
	.long	8
	.long	work__test_opt__ARCH__test__RTI
	.long	24
	.long	6
	.long	work__test_opt__ARCH__test__P0__RTIARRAY
.globl work__test_opt__ARCH__test__RTI
	.align 4
	.type	work__test_opt__ARCH__test__RTI, @object
	.size	work__test_opt__ARCH__test__RTI, 28
work__test_opt__ARCH__test__RTI:
	.byte	5
	.byte	1
	.byte	0
	.byte	0
	.long	work__test_opt__ARCH__test__RTISTR
	.long	0
	.long	work__test_opt__RTI
	.long	32
	.long	1
	.long	work__test_opt__ARCH__test__RTIARRAY
	.type	_UI00000002.1049, @object
	.size	_UI00000002.1049, 4
_UI00000002.1049:
	.byte	111
	.byte	107
	.byte	32
	.byte	33
	.align 4
	.type	work__test_opt__ARCH__test__P0__U1__STB.1050, @object
	.size	work__test_opt__ARCH__test__P0__U1__STB.1050, 16
work__test_opt__ARCH__test__P0__U1__STB.1050:
	.long	1
	.long	4
	.byte	0
	.zero	3
	.long	4
	.align 4
	.type	_UI00000001.1047, @object
	.size	_UI00000001.1047, 12
_UI00000001.1047:
	.long	_UI00000000
	.long	27
	.long	5
	.type	work__test_opt__RTISTR, @object
	.size	work__test_opt__RTISTR, 9
work__test_opt__RTISTR:
	.byte	116
	.byte	101
	.byte	115
	.byte	116
	.byte	95
	.byte	111
	.byte	112
	.byte	116
	.byte	0
	.align 4
	.type	work__test_opt__RTIARRAY, @object
	.size	work__test_opt__RTIARRAY, 4
work__test_opt__RTIARRAY:
	.zero	4
	.type	work__test_opt__ARCH__test__P0__a__RTISTR, @object
	.size	work__test_opt__ARCH__test__P0__a__RTISTR, 2
work__test_opt__ARCH__test__P0__a__RTISTR:
	.byte	97
	.byte	0
	.type	work__test_opt__ARCH__test__P0__b__RTISTR, @object
	.size	work__test_opt__ARCH__test__P0__b__RTISTR, 2
work__test_opt__ARCH__test__P0__b__RTISTR:
	.byte	98
	.byte	0
	.type	work__test_opt__ARCH__test__P0__c__RTISTR, @object
	.size	work__test_opt__ARCH__test__P0__c__RTISTR, 2
work__test_opt__ARCH__test__P0__c__RTISTR:
	.byte	99
	.byte	0
	.type	work__test_opt__ARCH__test__P0__d__RTISTR, @object
	.size	work__test_opt__ARCH__test__P0__d__RTISTR, 2
work__test_opt__ARCH__test__P0__d__RTISTR:
	.byte	100
	.byte	0
	.type	work__test_opt__ARCH__test__P0__e__RTISTR, @object
	.size	work__test_opt__ARCH__test__P0__e__RTISTR, 2
work__test_opt__ARCH__test__P0__e__RTISTR:
	.byte	101
	.byte	0
	.type	work__test_opt__ARCH__test__P0__f__RTISTR, @object
	.size	work__test_opt__ARCH__test__P0__f__RTISTR, 2
work__test_opt__ARCH__test__P0__f__RTISTR:
	.byte	102
	.byte	0
	.type	work__test_opt__ARCH__test__P0__RTISTR, @object
	.size	work__test_opt__ARCH__test__P0__RTISTR, 3
work__test_opt__ARCH__test__P0__RTISTR:
	.byte	80
	.byte	48
	.byte	0
	.align 4
	.type	work__test_opt__ARCH__test__P0__RTIARRAY, @object
	.size	work__test_opt__ARCH__test__P0__RTIARRAY, 28
work__test_opt__ARCH__test__P0__RTIARRAY:
	.long	work__test_opt__ARCH__test__P0__a__RTI
	.long	work__test_opt__ARCH__test__P0__b__RTI
	.long	work__test_opt__ARCH__test__P0__c__RTI
	.long	work__test_opt__ARCH__test__P0__d__RTI
	.long	work__test_opt__ARCH__test__P0__e__RTI
	.long	work__test_opt__ARCH__test__P0__f__RTI
	.long	0
	.type	work__test_opt__ARCH__test__RTISTR, @object
	.size	work__test_opt__ARCH__test__RTISTR, 5
work__test_opt__ARCH__test__RTISTR:
	.byte	116
	.byte	101
	.byte	115
	.byte	116
	.byte	0
	.align 4
	.type	work__test_opt__ARCH__test__RTIARRAY, @object
	.size	work__test_opt__ARCH__test__RTIARRAY, 8
work__test_opt__ARCH__test__RTIARRAY:
	.long	work__test_opt__ARCH__test__P0__RTI
	.long	0
	.type	_UI00000000, @object
	.size	_UI00000000, 14
_UI00000000:
	.byte	116
	.byte	101
	.byte	115
	.byte	116
	.byte	95
	.byte	111
	.byte	112
	.byte	116
	.byte	46
	.byte	118
	.byte	104
	.byte	100
	.byte	108
	.byte	0
	.ident	"GCC: (GNU) 4.3.4"
	.section	.note.GNU-stack,"",@progbits
