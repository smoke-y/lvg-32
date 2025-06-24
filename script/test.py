import os
import subprocess

files = [os.path.join('tb', f) for f in os.listdir('tb') if os.path.isfile(os.path.join('tb', f))]
for file in files:
    print("\nTESTING:", file)
    subprocess.run(['iverilog', file], check=True)
    subprocess.run(['./a.out'], check=True)
