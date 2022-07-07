BITS 64                             ; 64 bits mode
SECTION .text                       ; Code section 
GLOBAL strchr                       ; export strchr

strchr:
    PUSH    RCX                     ; push the counter in the stack
    XOR     RCX, RCX                ; clear the counter RCX
    XOR     RAX, RAX                ; set RAX to null (return value)

_strchr_loop:
    CMP     BYTE [RDI + RCX], SIL   ; compare RDI char 1 by 1 with the 2nd parameter SIL(1 byte)
    JE      _strchr_found           ; if cmp is ok -> jump to _strchr_found
    CMP     BYTE [RDI + RCX], 0     ; compare RDI char 1 by 1
    JZ      _strchr_null            ; if cmp is ok (equal null) -> jump to strchr_null
    INC     RCX                     ; increment the counter
    JMP    _strchr_loop             ; loop

_strchr_found:
    MOV     RAX, RDI                ; put the string into RAX (return value)
    ADD     RAX, RCX                ; add the counter to delete the string before the letter, into RAX
    POP     RCX                     ; restore the counter
    RET                             ; leaving

_strchr_null:
    XOR     RAX, RAX                ; restore RAX if nothing _strchr_found
    POP     RCX                     ; resrore the counter
    RET                             ; leave

; char *strchr(const char *s, int c)
; RDI = const char *s
; RSI = int c