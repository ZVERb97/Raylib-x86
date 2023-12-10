bits 64

extern MessageBeep
extern MessageBoxA
extern ExitProcess

extern InitWindow
extern BeginDrawing
extern ClearBackground
extern WindowShouldClose
extern DrawText
extern SetTargetFPS
extern DrawRectangle
extern EndDrawing
extern IsKeyDown

start:
  sub rsp,8

  sub rsp, 32
  mov rcx, 30
  call [MessageBeep]
  add rsp, 32
  
  sub rsp, 32
  mov rcx, 1024
  mov rdx, 768
  mov r8, gameTitle  
  call [InitWindow]


  mov rcx, 60
  call [SetTargetFPS]
  add rsp, 32

gameloop:
  sub rsp, 32

  call [WindowShouldClose]
  cmp rax, 0
  jnz end

  call [BeginDrawing]

  mov rcx, 0x00FF0000
  call [ClearBackground]
  
 ;Move Right:
  mov rcx, 262
  sub rsp, 32
  call [IsKeyDown]
  add rsp, 32
  cmp rax, 0
  je skip_move_right
  inc dword [squarex]
  skip_move_right:

;Move Left:
  mov rcx,263 
  sub rsp,32
  call [IsKeyDown]
  add rsp,32
  cmp rax, 0
  je skip_move_left
  dec dword[squarex]
  skip_move_left:
;Move Up:
  mov rcx,265 
  sub rsp,32
  call [IsKeyDown]
  add rsp,32
  cmp rax, 0
  je skip_move_up
  dec dword[squarey]
  skip_move_up:
;Move down:
  mov rcx,264 
  sub rsp,32
  call [IsKeyDown]
  add rsp,32
  cmp rax, 0
  je skip_move_down
  inc dword[squarey]
  skip_move_down:
;DrawRectangle:
  mov rcx, [squarex]
  mov rdx, [squarey]
  mov r8, 20
  mov r9, 20
  mov rax, 0xFFFFFFFF
  sub rsp, 8
  push rax

  sub rsp, 32
  call [DrawRectangle]
  add rsp, 32
  add rsp, 8
  pop rax


  
  call [EndDrawing]
  add rsp, 32 

  jmp gameloop


  end:
  sub rsp, 32
  call [ExitProcess]
  add rsp, 32

  ret

section .data
boxMessage:
  db "Hello World", 0
boxTitle:
  db "Ciao Bello", 0

gameTitle:
  db "Game"
squarex:
  dq 40
squarey:
  dq 40