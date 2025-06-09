global ft_write
section .text
extern __errno_location

ft_write:
    mov rax, 1  ;scycall for write
    syscall     ;call kernel
    test rax, rax
    js .error
.done:    
    ret         ;return in the rax
    
.error:    
    neg rax
    mov rdi, rax
    call    __errno_location wrt ..plt
    mov [rax], rdi ;store error code (from rax in *errno)
    mov rax, -1
    jmp .done


;ssize_t write(int fd, const void *buf, size_t count);
;extern __errno_location provided by glibc(c stanard libray on linux) that reurn a pointer to the variable of errno
;why can noy extern errno as in linux errno is not normal global variable #include <errno.h>
;errno   →   actually expands to   (*__errno_location()) errno is a macro not a variable
;rbx	64	Full 64-bit register
;ebx	32	Lower 32 bits of rbx
;bx	16	Lower 16 bits of rbx
;bl	8	Lowest 8 bits (bits 0–7)
;bh	8	Next 8 bits up (bits 8–15)
; so outside of this need to do bitwise operation to extract them
;mov rax, 0x1122334455667788
; You want to access byte 2 (bits 16–23) of rax
;shr rax, 16       ; shift right 16 bits → byte 2 is now in bits 0–7
;and rax, 0xFF     ; mask to get only that 8-bit value
;ummary of Use Cases Where You’d Access "Unnamed Bytes"
;Use Case	Why access inner bytes?
;Custom file formats	Pack multiple fields into 64-bit
;Networking protocols	Extract fields in protocol headers
;Embedded systems	Talk to hardware registers (1 byte at a time)
;Compression/encoding	Store packed bitstreams
;Cryptography	Byte-level manipulation of blocks
;Register Part | Bit Range | Byte #    | Notes                                |
;------------- | --------- | --------- | ------------------------------------ |
;bl            |  0–7      | byte 0    | lowest byte (8 bits)                 |
;bh            |  8–15     | byte 1    | second-lowest byte                   |
;???           | 16–23     | byte 2    |                                      |
;???           | 24–31     | byte 3    |                                      |
;ebx           |  0–31     | bytes 0–3 | full 32-bit lower half of rbx        |
;rbx           |  0–63     | bytes 0–7 | full 64-bit register                 |

