# LVG-32
A simple TPU written in verilog. Can solve xor, mnist, iris, etc...<br>

### SIMULATE
clone the repo and make sure you have `icarus`. Testbenches under `tb/` are standalone.<br>
To run iris classification, run `script/iris.py` to train and dump weights into a hex file. This file will be loaded
by `tb/lvg/iris.v`.<br>

Currently, the only activation function supported is ReLu.

### INSTR
each instruction is 16-bit.<br>
8 bit addr | 8 bit instr -> 16 bit

<ol>
  <li><strong>NOP</strong></li>
  <li><strong>LOAD_L #addr</strong>: load 16 * 32 bits into L register file</li>
  <li><strong>LOAD_R #addr</strong>: load 16 * 32 bits into R register file</li>
  <li><strong>LOAD_A #addr</strong>: load 16 * 32 bits into A register file</li>
  <li><strong>STORE #addr</strong>: store 16 * 32 bits</li>
  <li><strong>MUL</strong>: multiply(L.R)</li>
  <li><strong>MUL_ADD #addr</strong>: multiply(L.R) and add the matrix present @ #addr</li>
  <li><strong>MUL_ACT</strong>: multiply(L.R) and pass it through the activation function</li>
  <li><strong>MUL_ADD_ACT</strong>: multiply(L.R), add, and pass it through the activation function</li>
</ol>
