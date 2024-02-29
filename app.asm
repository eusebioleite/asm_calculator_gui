section .data
    helloMsg db 'Hello, ', 0
    name db 0, 0x20  ; Buffer to hold the name (null-terminated)

section .text
    global _start

_start:
    ; Get the command-line argument (the name)
    pop ebx            ; Pop the address of argc (not needed)
    pop ebx            ; Pop the address of argv[0] (not needed)
    pop ebx            ; Pop the address of argv[1] (the name)
    mov esi, ebx       ; Copy the address of the name to esi

    ; Print "Hello, "
    mov eax, 4            ; syscall number for sys_write
    mov ebx, 1            ; file descriptor 1 (stdout)
    mov ecx, helloMsg     ; pointer to the message
    mov edx, 7            ; length of the message
    int 0x80              ; call kernel

    ; Print the name
    mov eax, 4            ; syscall number for sys_write
    mov ebx, 1            ; file descriptor 1 (stdout)
    mov ecx, esi          ; pointer to the name
    add edx, 0x20         ; length of the name (including null terminator)
    int 0x80              ; call kernel

    ; Print a newline
    mov eax, 4            ; syscall number for sys_write
    mov ebx, 1            ; file descriptor 1 (stdout)
    mov ecx, newline      ; pointer to the newline character
    mov edx, 1            ; length of the newline character
    int 0x80              ; call kernel

    ; Exit the program
    mov eax, 1            ; syscall number for sys_exit
    xor ebx, ebx          ; exit code 0
    int 0x80              ; call kernel

section .bss
    newline resb 1        ; Buffer to hold the newline character
