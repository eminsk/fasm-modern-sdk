; ==============================================================================
; FASM Modern SDK - Minimal Fluent Dark Application (x86-64)
; Example: examples/MinimalFluentApp/main.asm
; ==============================================================================

format PE64 GUI 5.0
entry start

include 'win64a.inc'
include '../../include/ui_fluent.inc'

section '.data' data readable writeable
    szClassName     db 'FasmFluentApp', 0
    szAppTitle      db 'Minimal Fluent Dark Window (FASM x64)', 0
    szBtnText       db 'Click Me', 0
    szFontName      db 'Segoe UI', 0

    hInstance       dq 0
    hMainWnd        dq 0
    hBtn            dq 0
    hBrushWin       dq 0
    hFont           dq 0
    wc              WNDCLASSEX

section '.text' code readable executable

start:
        sub     rsp, 8

        invoke  GetModuleHandle, 0
        mov     [hInstance], rax
        mov     [wc.hInstance], rax

        invoke  CreateSolidBrush, COLOR_DEEP_DARK_BG
        mov     [hBrushWin], rax

        invoke  CreateFont, -14, 0, 0, 0, FW_NORMAL, 0, 0, 0,\
                DEFAULT_CHARSET, OUT_DEFAULT_PRECIS, CLIP_DEFAULT_PRECIS,\
                5, DEFAULT_PITCH, szFontName
        mov     [hFont], rax

        ; Register Class
        invoke  LoadCursor, 0, IDC_ARROW
        mov     [wc.hCursor], rax
        mov     [wc.cbSize], sizeof.WNDCLASSEX
        mov     [wc.style], CS_HREDRAW or CS_VREDRAW
        mov     [wc.lpfnWndProc], WindowProc
        mov     rax, [hBrushWin]
        mov     [wc.hbrBackground], rax
        mov     [wc.lpszClassName], szClassName
        invoke  RegisterClassEx, wc

        ; Create Window
        invoke  CreateWindowEx, 0, szClassName, szAppTitle,\
                WS_VISIBLE or WS_OVERLAPPEDWINDOW,\
                150, 150, 720, 480,\
                0, 0, [hInstance], 0
        mov     [hMainWnd], rax

        ; Apply Immersive Dark Mode
        EnableImmersiveDarkMode [hMainWnd]

        ; Create Modern Button
        invoke  CreateWindowEx, 0, 'BUTTON', szBtnText,\
                WS_VISIBLE or WS_CHILD or BS_PUSHBUTTON,\
                40, 40, 140, 38,\
                [hMainWnd], 101, [hInstance], 0
        mov     [hBtn], rax
        invoke  SendMessage, [hBtn], WM_SETFONT, [hFont], 1

        ; Message Loop
        sub     rsp, 32
    .msg_loop:
        lea     rcx, [rsp]
        invoke  GetMessage, rcx, 0, 0, 0
        test    eax, eax
        jle     .exit
        lea     rcx, [rsp]
        invoke  TranslateMessage, rcx
        lea     rcx, [rsp]
        invoke  DispatchMessage, rcx
        jmp     .msg_loop

    .exit:
        invoke  ExitProcess, 0

proc WindowProc uses rbx rsi rdi, hwnd, wmsg, wparam, lparam
        cmp     edx, WM_DESTROY
        je      .destroy
        cmp     edx, WM_COMMAND
        je      .command
        invoke  DefWindowProc, rcx, rdx, r8, r9
        ret

    .command:
        cmp     r8w, 101
        jne     .done
        invoke  MessageBoxA, [hwnd], 'Hello from Native FASM Fluent App!', 'Modern FASM SDK', MB_OK or MB_ICONINFORMATION
    .done:
        xor     eax, eax
        ret

    .destroy:
        invoke  PostQuitMessage, 0
        xor     eax, eax
        ret
endp

section '.idata' import data readable writeable
    library kernel32, 'KERNEL32.DLL', \
            user32, 'USER32.DLL', \
            gdi32, 'GDI32.DLL', \
            dwmapi, 'DWMAPI.DLL'

    import kernel32, \
           GetModuleHandle, 'GetModuleHandleA', \
           ExitProcess, 'ExitProcess'

    import user32, \
           RegisterClassEx, 'RegisterClassExA', \
           CreateWindowEx, 'CreateWindowExA', \
           DefWindowProc, 'DefWindowProcA', \
           GetMessage, 'GetMessageA', \
           TranslateMessage, 'TranslateMessage', \
           DispatchMessage, 'DispatchMessageA', \
           PostQuitMessage, 'PostQuitMessage', \
           SendMessage, 'SendMessageA', \
           MessageBoxA, 'MessageBoxA', \
           LoadCursor, 'LoadCursorA'

    import gdi32, \
           CreateSolidBrush, 'CreateSolidBrush', \
           CreateFont, 'CreateFontA'

    import dwmapi, \
           DwmSetWindowAttribute, 'DwmSetWindowAttribute'
