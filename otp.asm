
section .text
    global otp

otp:
    push    ebp
    mov     ebp, esp
    pusha

    mov     edx, [ebp + 8]      ; ciphertext
    mov     esi, [ebp + 12]     ; plaintext
    mov     edi, [ebp + 16]     ; key
    mov     ecx, [ebp + 20]     ; length

    push ecx
letter:
    xor eax, eax
    xor ebx, ebx
    
    mov al, byte [esi + ecx -1]
    mov bl, byte [edi + ecx -1]

    xor eax, ebx
    xor ebx, ebx 
    pop ebx
    push ebx
    mov byte [edx + ecx - 1], al

    loop letter
    pop ecx

    popa
    leave
    ret