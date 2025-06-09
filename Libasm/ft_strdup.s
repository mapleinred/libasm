global ft_strdup
section  .text
extern  ft_strlen
extern  ft_strcpy
extern  malloc

ft_strdup:
    mov rsi, rdi   ;rsi = rdi = s move rdi in to rsi
    push rsi ;preserve source
    call ft_strlen wrt ..plt  ;rax = len
    add rax, 1     ;add 1 for null terminator
    mov rdi,rax    ;move rax in rdi  so that 1st av will the len wen call malloc
    call malloc wrt ..plt   ;rax = malloc
    test rax, rax ;check for malloc failed
    je    .fail   ;if NULL return NULL


    mov  rdi, rax    ; rax is the new string put in the 1st av rsi have the original string
    pop rsi          ; restore orginal string to rsi
    ;mov  rdx, rsi   ; restore orginal string to rdx
    ;mov  rsi, rdx   ;move it in correct register for ft_strcpy
    call ft_strcpy wrt ..plt 
    ret

.fail:
    xor    rax,rax  ;0
    ret



;char *strdup(const char *s)
;{
;    char *copy = malloc(strlen(s) + 1);
;    if (!copy) return NULL;
;    strcpy(copy, s);
;    return copy;
;}