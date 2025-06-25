# LVG-32

# INSTR
8 bit addr | 8 bit instr -> 16 bit

### [0] NOP
### [1] LOAD_L #addr
load 16 * 32 bits into L register file
### [2] LOAD_R #addr
load 16 * 32 bits into R register file
### [3] STORE #addr
store 16 * 32 bits
### [4] MUL
multiply(L.R)
### [5] MUL_ADD #addr
multilpy(L.R) and add the matrix present @ #addr
### [6] MUL_ACT
multiply(L.R) and pass it through the activation function
### [7] MUL_ADD_ACT
multiply(L.R), add, and pass it through the activation function
