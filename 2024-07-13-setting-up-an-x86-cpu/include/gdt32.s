;; src/gdt32.s

    ;; Base address of GDT should be aligned on an eight-byte boundary
    align 8

gdt32_start:
    ;; 8-byte null descriptor (index 0).
    ;; Used to catch translations with a null selector.
    dd 0x0
    dd 0x0

gdt32_code_segment:
    ;; 8-byte code segment descriptor (index 1).
    ;; First 16 bits of segment limit
    dw 0xffff
    ;; First 24 bits of segment base address
    dw 0x0000
    db 0x00
    ;; 0-3: segment type that specifies an execute/read code segment
    ;;   4: descriptor type flag indicating that this is a code/data segment
    ;; 5-6: Descriptor privilege level 0 (most privileged)
    ;;   7: Segment present flag set indicating that the segment is present
    db 10011010b
    ;; 0-3: last 4 bits of segment limit
    ;;   4: unused (available for use by system software)
    ;;   5: 64-bit code segment flag indicates that the segment doesn't contain 64-bit code
    ;;   6: default operation size of 32 bits
    ;;   7: granularity of 4 kilobyte units
    db 11001111b
    ;; Last 8 bits of segment base address
    db 0x00

gdt32_data_segment:
    ;; Only differences are explained ...
    dw 0xffff
    dw 0x0000
    db 0x00
    ;; 0-3: segment type that specifies a read/write data segment
    db 10010010b
    db 11001111b
    db 0x00

gdt32_end:

;; Value for GDTR register that describes the above GDT
gdt32_pseudo_descriptor:
    ;; A limit value of 0 results in one valid byte. So, the limit value of our
    ;; GDT is its length in bytes minus 1.
    dw gdt32_end - gdt32_start - 1
    ;; Start address of the GDT
    dd gdt32_start

CODE_SEG32 equ gdt32_code_segment - gdt32_start
DATA_SEG32 equ gdt32_data_segment - gdt32_start
