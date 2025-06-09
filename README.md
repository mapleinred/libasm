# Libasm: Assembly Programming Project

## Introduction to Assembly Language

Assembly language is a low-level programming language that provides a direct correspondence between its instructions and a computer's machine code. Unlike high-level languages (like C or Python), assembly is specific to a particular computer architecture - in this project, we use x86-64 architecture (64-bit processors).

### Key Characteristics:

* **Direct hardware control**: Assembly provides direct access to CPU registers and memory
* **One-to-one correspondence**: Each assembly instruction typically translates to one machine code instruction
* **Performance critical**: Used in operating systems, embedded systems, and performance-critical applications
* **Architecture-specific**: x86-64 assembly (used here) differs significantly from ARM or other architectures

## Intel vs AT\&T Syntax

This project uses Intel syntax, which differs from AT\&T syntax in several key ways:

| Feature          | Intel Syntax      | AT\&T Syntax        |
| ---------------- | ----------------- | ------------------- |
| Operand Order    | `mov dest, src`   | `mov src, dest`     |
| Register Prefix  | No prefix (`rax`) | `%` prefix (`%rax`) |
| Immediate Prefix | No prefix (`42`)  | `$` prefix (`$42`)  |
| Memory Reference | `[rax]`           | `(%rax)`            |

**Reasons for using Intel syntax:**

* More readable for most developers
* Dominant syntax in Windows/Linux documentation
* NASM (our assembler) defaults to Intel syntax

## Project Overview

Libasm is an educational project that implements standard C library functions in x86-64 assembly. The goals are:

* Understand low-level programming concepts
* Learn CPU register management
* Master system call invocation
* Implement memory management techniques
* Create a functional static library

## Implemented Functions

### Mandatory Functions

| Function   | Description                    | C Equivalent |
| ---------- | ------------------------------ | ------------ |
| ft\_strlen | Calculate string length        | `strlen()`   |
| ft\_strcpy | Copy string                    | `strcpy()`   |
| ft\_strcmp | Compare strings                | `strcmp()`   |
| ft\_write  | Write to file descriptor       | `write()`    |
| ft\_read   | Read from file descriptor      | `read()`     |
| ft\_strdup | Duplicate string (with malloc) | `strdup()`   |

### Bonus Functions

| Function              | Description                         |
| --------------------- | ----------------------------------- |
| ft\_atoi\_base        | Convert string to integer with base |
| ft\_list\_push\_front | Add element to list front           |
| ft\_list\_size        | Count elements in list              |
| ft\_list\_sort        | Sort linked list                    |
| ft\_list\_remove\_if  | Conditionally remove list elements  |

## Key Assembly Concepts Used

### 1. Register Usage

x86-64 has 16 general-purpose registers. Key registers used:

| Register | Purpose                       | Preservation Rule |
| -------- | ----------------------------- | ----------------- |
| rax      | Return value, syscall number  | Caller-saved      |
| rdi      | First argument                | Caller-saved      |
| rsi      | Second argument               | Caller-saved      |
| rdx      | Third argument                | Caller-saved      |
| rcx      | Fourth argument, loop counter | Caller-saved      |
| rsp      | Stack pointer                 | Callee-saved      |
| rbp      | Base pointer                  | Callee-saved      |

### 2. System Calls

Using Linux syscalls via the `syscall` instruction:

```nasm
; write syscall example
mov rax, 1      ; syscall number for write
mov rdi, 1      ; fd (stdout)
mov rsi, msg    ; buffer
mov rdx, len    ; length
syscall
```

### 3. Error Handling

Proper error handling by:

* Checking return values (negative indicates error)
* Using `__errno_location` to set `errno`
* Returning -1 on error as per C convention

```nasm
.error:
    neg rax                    ; Get positive error code
    mov rdi, rax               ; Store error code
    call __errno_location wrt ..plt  ; Get errno location
    mov [rax], rdi             ; Set errno value
    mov rax, -1                ; Return -1
    ret
```

### 4. Position-Independent Code

Using `wrt ..plt` for external function calls to enable position-independent executables:

```nasm
call malloc wrt ..plt  ; Position-independent call to malloc
```

## Makefile Explained

The Makefile automates building and managing our project:

```makefile
NAME = libasm.a
SRC = ft_strlen.s ft_strcpy.s ...
OBJ = $(SRC:.s=.o)

all: $(NAME)

$(NAME): $(OBJ)
	ar rcs $(NAME) $(OBJ)

%.o: %.s
	nasm -f elf64 $< -o $@

clean:
	rm -f $(OBJ)

fclean: clean
	rm -f $(NAME)

re: fclean all

bonus: $(OBJ_BONUS)
	ar rcs $(NAME) $(OBJ_BONUS)
```

### Makefile Rules:

* `make` or `make all`: Builds the library
* `make clean`: Removes object files
* `make fclean`: Removes object files and the library
* `make re`: Rebuilds the entire project
* `make bonus`: Builds bonus functions (requires perfect mandatory)

## Building and Testing

### Requirements

* NASM (Netwide Assembler)
* GCC (GNU Compiler Collection)
* GNU Make
* Linux environment (WSL works for Windows users)

### Build Steps

```bash
# Build the library
make

# Build with bonus functions (if mandatory is perfect)
make bonus

# Compile test program
gcc main.c -L. -lasm -o test_program

# Run tests
./test_program
```

### Test Output Example

```
===== Testing ft_strlen ===
Test 1: empty string: 0 (expected 0)
Test 2: string: 6 (expected 6)
Test 3: long string: 15 (expected 15)

=== Testing ft_write ===
Hello World
Test 1: write to stdout: ret=12 (expected 12)
Test 2: write to file: ret=12 (expected 12)
Test 3: write to invalid fd: ret=-1 (expected -1), errno=9 (expected EBADF)
```

## Learning Outcomes

By completing this project, you'll understand:

* How high-level functions map to assembly instructions
* CPU register management and calling conventions
* System call invocation and error handling
* Memory management techniques
* Static library creation and linking
* Makefile automation for assembly projects

## Conclusion

This project provides a practical introduction to x86-64 assembly programming. By implementing standard library functions, you gain deep insight into how computers execute code at the lowest level. The skills learned form a foundation for reverse engineering, operating system development, and performance optimization.

### To explore further:

* Intel x86-64 Architecture Manual
* NASM Documentation
* Linux System Call Table
