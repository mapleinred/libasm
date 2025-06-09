global ft_strcpy
section .text

ft_strcpy:
    xor rcx, rcx ; i = 0

.loop:
    mov al, byte [rsi + rcx] ;al = src[i]
    mov byte [rdi + rcx], al ; dest[i] = al
    inc rcx 
    test al, al ;check al == '\0' which check src[i] == '\0' 
    jne .loop ;if not repaeat loop ;if not repeat loop
    mov rax,  rdi  ;copy rdi into rax rdi is dest
    ret ;return rax which is rdi








;char *ft_strcpy(char *dest, const char *src)
;{
;    int i = 0;
;   while (src[i] != '\0') {
;        dest[i] = src[i];
;        i++;
;    }
;    dest[i] = '\0';
;    return dest;
;}
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

;al is the lowest 8 bits of the rax register.
;Think of the 64-bit register rax like this:
;Name	Size	Description
;rax	64-bit	Full register
;eax	32-bit	Lower half
;ax	16-bit	Lower quarter
;al	8-bit	Lowest byte
;ah	8-bit	Next lowest byte (bits 8–15)

