import torch
import torch.nn as nn
import torch.optim as optim

class Net(nn.Module):
    def __init__(self):
        super().__init__()
        self.l1 = nn.Linear(2, 1)
        self.act = nn.ReLU(inplace=True)

    def forward(self, x):
        return self.act(self.l1(x))

dataSet = [
        (0,0),
        (0,1),
        (1,1),
        (1,0),
        ]

model = Net()
criterion = nn.MSELoss()
optimizer = optim.Adam(model.parameters())

for epoch in range(500):
    for data in dataSet:
        pred = model(torch.tensor(data, dtype=torch.float).reshape(1, -1))
        truth = torch.tensor(data[0] & data[1], dtype=torch.float).reshape(1, -1)
        loss = criterion(pred, truth)
        optimizer.zero_grad()
        loss.backward()
        optimizer.step()

for data in dataSet:
    pred = model(torch.tensor(data, dtype=torch.float))
    print(f"{data[0]} & {data[0]} = {pred.detach().numpy()}")

for row in model.l1.weight.data.T: print(row.tolist())
