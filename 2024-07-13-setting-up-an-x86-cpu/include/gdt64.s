;; include/gdt64.s

    align 16
gdt64_start:
    ;; 8-byte null descriptor (index 0).
    dd 0x0
    dd 0x0

gdt64_code_segment:
    dw 0xffff
    dw 0x0000
    db 0x00
    db 10011010b
    ;;   5: 64-bit code segment flag indicates that this segment contains 64-bit code
    ;;   6: must be zero if L bit (bit 5) is set
    db 10101111b
    db 0x00

gdt64_data_segment:
    dw 0xffff
    dw 0x0000
    db 0x00
    ;; 0-3: segment type that specifies a read/write data segment
    db 10010010b
    db 10101111b
    db 0x00

gdt64_end:

gdt64_pseudo_descriptor:
    dw gdt64_end - gdt64_start - 1
    dd gdt64_start


CODE_SEG64 equ gdt64_code_segment - gdt64_start
DATA_SEG64 equ gdt64_data_segment - gdt64_start
