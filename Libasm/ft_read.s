
global ft_read
section .text
extern  __errno_location

ft_read:
    mov rax, 0  ;scycall number for read
    syscall
    test rax, rax
    js .error
.done:
    ret

.error:    
    neg rax
    mov rdi, rax
    call    __errno_location wrt ..plt
    mov [rax], rdi ;store error code (from rax in *errno)
    mov rax, -1
    jmp .done

;ssize_t read(int fd, void *buf, size_t count);
;why wrt ..plt ensures calls external function use PLT 
;enaling postion-indepenent code
 