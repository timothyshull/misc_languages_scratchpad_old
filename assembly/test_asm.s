	.section	__TEXT,__text,regular,pure_instructions
	.macosx_version_min 10, 11
	.intel_syntax noprefix
	.globl	_displayHeader
	.align	4, 0x90
_displayHeader:                         ## @displayHeader
	.cfi_startproc
## BB#0:
	push	rbp
Ltmp0:
	.cfi_def_cfa_offset 16
Ltmp1:
	.cfi_offset rbp, -16
	mov	rbp, rsp
Ltmp2:
	.cfi_def_cfa_register rbp
	sub	rsp, 48
	mov	eax, 8
	mov	edi, eax
	lea	rcx, [rip + L_.str]
	mov	rdx, qword ptr [rip + ___stack_chk_guard@GOTPCREL]
	mov	rdx, qword ptr [rdx]
	mov	qword ptr [rbp - 8], rdx
	mov	qword ptr [rbp - 24], rcx
	mov	rcx, qword ptr [rip + L_displayHeader.localArrayHeader]
	mov	qword ptr [rbp - 16], rcx
	call	_malloc
	lea	rsi, [rip + L_.str]
	mov	rdx, -1
	mov	qword ptr [rbp - 32], rax
	mov	rdi, qword ptr [rbp - 32]
	call	___strcpy_chk
	mov	rcx, qword ptr [rip + ___stack_chk_guard@GOTPCREL]
	mov	rcx, qword ptr [rcx]
	cmp	rcx, qword ptr [rbp - 8]
	mov	qword ptr [rbp - 40], rax ## 8-byte Spill
	jne	LBB0_2
## BB#1:                                ## %SP_return
	add	rsp, 48
	pop	rbp
	ret
LBB0_2:                                 ## %CallStackCheckFailBlk
	call	___stack_chk_fail
	.cfi_endproc

	.globl	_main
	.align	4, 0x90
_main:                                  ## @main
	.cfi_startproc
## BB#0:
	push	rbp
Ltmp3:
	.cfi_def_cfa_offset 16
Ltmp4:
	.cfi_offset rbp, -16
	mov	rbp, rsp
Ltmp5:
	.cfi_def_cfa_register rbp
	sub	rsp, 16
	mov	dword ptr [rbp - 4], 0
	call	_displayHeader
	xor	eax, eax
	add	rsp, 16
	pop	rbp
	ret
	.cfi_endproc

	.section	__TEXT,__cstring,cstring_literals
L_.str:                                 ## @.str
	.asciz	"Chapter"

	.section	__DATA,__data
	.globl	_globalHeader           ## @globalHeader
	.align	3
_globalHeader:
	.quad	L_.str

	.globl	_globalArrayHeader      ## @globalArrayHeader
_globalArrayHeader:
	.asciz	"Chapter"

	.align	3                       ## @displayHeader.staticHeader
_displayHeader.staticHeader:
	.quad	L_.str

_displayHeader.staticArrayHeader:       ## @displayHeader.staticArrayHeader
	.asciz	"Chapter"

	.section	__TEXT,__cstring,cstring_literals
L_displayHeader.localArrayHeader:       ## @displayHeader.localArrayHeader
	.asciz	"Chapter"


.subsections_via_symbols
