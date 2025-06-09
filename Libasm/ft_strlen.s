global ft_strlen 
section .text

ft_strlen:
    xor rax, rax ; rax compared to rax so different is 0

.loop:
    cmp byte [rdi + rax], 0 ; check if str[i] == '\0'
    je .done ;if zero (end of string), jump to done
    inc rax ; else, increase counter
    jmp .loop

.done:
    ret    ;return value is already in rax

;rdi	dest index	1st argument
;rsi	src index	2nd argument
;rdx	data register	3rd argument
;rcx	counter	4th argument
;r8	general purpose	5th argument
;r9	general purpose	6th argument
;rax	accumulator	return value
;rsp	stack pointer	memory stack
;rbp	base pointer	stack frame
;r10–r11	scratch	caller can use freely
;r12–r15	saved registers	callee must restore
;size_t	ft_strlen(const char *s)
;{
;	size_t	i;
;	i = 0;
;	while (s[i] != '\0')
;		i++;
;	return (i);
;}
;XOR = "Exclusive OR"
;XOR means: result is 1 **only** if the bits are different.
;very bit compared to itself → always the same → so result = 0


;Instruction	What it means	Example	C Equivalent
;mov	Copy data from one place to another	mov rax, rdi	rax = rdi
;xor	Bitwise XOR (used to zero a register)	xor rax, rax	rax = 0
;add	Add numbers	add rax, rbx	rax += rbx
;sub	Subtract numbers	sub rax, 1	rax -= 1
;inc	Increase by 1	inc rax	rax++
;dec	Decrease by 1	dec rax	rax--
;cmp	Compare values	cmp rax, rbx	if (rax == rbx)
;je	Jump if equal	je .done	if (equal) goto done;
;jne	Jump if not equal	jne .loop	if (!equal) goto loop;
;jmp	Unconditional jump	jmp .loop	goto loop;
;call	Call a function	call ft_strlen	ft_strlen()
;ret	Return from function	ret	return;
;lea	Load address into register	lea rsi, [rdi + rax]	pointer math