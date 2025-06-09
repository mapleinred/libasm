global ft_strcmp
section .text

ft_strcmp:
    xor rcx, rcx ;i =0

.loop:
    mov al, byte [rdi]  ;al = *s1
    mov bl, byte [rsi]  ;bl = *s2
    cmp al, bl
    jne .diff   ;if not equal, return differnce
    test al, al ;check if al == '\0'
    je .equal   ;if s1[i]== '\0' string are equel
    inc rdi     ;s1++
    inc rsi     ;s2++
    jmp .loop   ;repeat

.diff:
    movzx eax, al ;zero-extend al into eax
    movzx ebx, bl ;zero-extend bl into ebx
    sub eax, ebx
    ret

.equal:
    xor eax, eax    ; return 0
    ret



;movzx eax, al    ; move 1-byte al into 4-byte eax, zero the rest
;movzx ebx, bl    ; move 1-byte bl into 4-byte ebx
;sub eax, ebx    ; eax = eax - ebx
;int ft_strcmp(const char *s1, const char *s2)
;{
;    int i = 0;
;    while (s1[i] && s1[i] == s2[i])
;        i++;
;    return ((unsigned char)s1[i] - (unsigned char)s2[i]);
;}
