BITS 64                             ; 64 bits mode
SECTION .text                       ; Code section 
GLOBAL strlen                       ; export strlen

strlen:
    PUSH    RCX                     ; push the counter in the stack
    XOR     RCX, RCX                ; clear the counter RCX
    XOR     RAX, RAX                ; set RAX to null (return value)

_strlen_loop:
    CMP     BYTE [RDI + RCX], 0     ; compare RDI char 1 by 1
    JZ      _strlen_null            ; if one of the char is null -> leave
    INC     RCX                     ; increment the counter
    JMP     _strlen_loop            ; looping

_strlen_null:
    MOV     RAX, RCX                ; RCX keep the string lenght, we move it in RAX
    POP     RCX                     ; restoring the old counter value
    RET                             ; leaving

; char *strlen(const char *s)
; RDI = const char *s