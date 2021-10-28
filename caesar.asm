
section .text
    global caesar

caesar:
    push    ebp
    mov     ebp, esp
    pusha

    mov     edx, [ebp + 8]      ; ciphertext
    mov     esi, [ebp + 12]     ; plaintext
    mov     edi, [ebp + 16]     ; key
    mov     ecx, [ebp + 20]     ; length

letter:
    xor eax, eax
    mov al, byte [esi + ecx - 1] ;litera curenta

litera_mare:
    mov ebx, 65 ;litera A
    cmp eax, ebx
    jl non_alpha

    mov ebx, 90 ;litera Z
    cmp eax, ebx
    jg litera_mica
    
    ;este litera mare si o criptez
    add eax, edi

    cmp edi, 0
    jl NEG_KEY

POZ_KEY:
    mov ebx, 90;in ebx am litera maxima
    cmp eax, ebx
    jle non_alpha

OVER:
    sub eax, ebx ;daca am dat peste Z scad din ce am ajuns pe Z
    add eax, 64 ;adaug peste A
    cmp eax, ebx ;verific daca de data asta sunt in range, eax-current value, ebx -Z
    jg OVER
    jmp non_alpha

NEG_KEY:
    mov ebx, 65;in ebx am litera minima
    cmp eax, ebx
    jge non_alpha

UNDER:
    sub ebx, eax ;daca am dat sub A scad din A valoarea la care am ajuns in eax
    ; am restul in ebx
    mov eax, 91 ;pun pe Z+1 in eax
    sub eax, ebx ;din Z+1 scad restul
    mov ebx, 65
    cmp eax, ebx
    jl UNDER
    jmp non_alpha

litera_mica:
    mov ebx, 97 ;litera a
    cmp eax, ebx
    jl non_alpha

    mov ebx, 122 ;litera z
    cmp eax, ebx
    jg non_alpha

    ;este litera mica si o criptez
    add eax, edi

    cmp edi, 0
    jl neg_key

poz_key:
    mov ebx, 122;in ebx am litera maxima
    cmp eax, ebx
    jle non_alpha

over:
    sub eax, ebx ;daca am dat peste z scad din ce am ajuns pe z
    add eax, 96 ;adaug peste a
    cmp eax, ebx
    jg over
    jmp non_alpha

neg_key:
    mov ebx, 97;in ebx am litera minima
    cmp eax, ebx
    jge non_alpha

under:
    sub ebx, eax ;daca am dat sub a scad din a valoarea la care am ajuns in eax
    ; am restul in ebx
    mov eax, 123 ;pun pe z+1 in eax
    sub eax, ebx ;din z+1 scad restul
    mov ebx, 97
    cmp eax, ebx
    jl under
    jmp non_alpha

non_alpha:
    mov [edx + ecx - 1], byte al
    dec ecx
    jnz letter

    popa
    leave
    ret