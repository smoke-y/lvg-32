import torch
import torch.nn as nn
import torch.optim as optim
import struct

torch.manual_seed(0)

def float_to_hex(f):
    hex_val = struct.unpack('<I', struct.pack('<f', f))[0]
    return f"32'h{hex_val:08x}"

class Net(nn.Module):
    def __init__(self):
        super().__init__()
        self.l1 = nn.Linear(2, 4)
        self.l2 = nn.Linear(4, 1)
        self.act = nn.ReLU(inplace=True)

    def forward(self, x):
        x = self.act(self.l1(x))
        return self.l2(x)

dataSet = [
        (0,0),
        (0,1),
        (1,1),
        (1,0),
        ]

model = Net()
criterion = nn.MSELoss()
optimizer = optim.Adam(model.parameters(), lr=0.1)

for epoch in range(900):
    for data in dataSet:
        pred = model(torch.tensor(data, dtype=torch.float).reshape(1, -1))
        truth = torch.tensor(data[0] ^ data[1], dtype=torch.float).reshape(1, -1)
        loss = criterion(pred, truth)
        optimizer.zero_grad()
        loss.backward()
        optimizer.step()

for data in dataSet:
    pred = model(torch.tensor(data, dtype=torch.float))
    print(f"{data[0]} ^ {data[1]} = {pred.detach().numpy()}")

data = (0,0)
data = torch.tensor(data, dtype=torch.float).reshape(1, -1)
x = nn.functional.relu(data @ model.l1.weight.data.T + model.l1.bias.data)
print(x)

print(data)
print(model.l1.weight.data.T)
print(model.l1.bias.data)
print(model.l2.weight.data.T)
print(model.l2.bias.data)
exit()
print("WEIGHT_1")
matrix = model.l1.weight.data.T
expanded = torch.zeros(4, 4)
expanded[:2, :] = matrix
chunk = expanded.flatten()
for val in chunk:
    print(f"{float_to_hex(val)}")

print("BIAS_1", model.l1.bias.shape)
matrix = model.l1.bias.data
expanded = torch.zeros(4, 4)
expanded[0, :] = matrix
chunk = expanded.flatten()
for val in chunk:
    print(f"{float_to_hex(val)}")

print("WEIGHT_2", model.l2.weight.T.shape)
matrix = model.l2.weight.data.T
expanded = torch.zeros(4, 4)
expanded[:, 0] = matrix.squeeze(1)
chunk = expanded.flatten()
for val in chunk:
    print(f"{float_to_hex(val)}")

print("BIAS_2", model.l2.bias.shape)
matrix = model.l2.bias.data
expanded = torch.zeros(4, 4)
expanded[0, 0] = matrix[0]
chunk = expanded.flatten()
for val in chunk:
    print(f"{float_to_hex(val)}")
