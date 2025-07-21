import torch
import torch.nn as nn
import torch.optim as optim
from torch.utils.data import Dataset, DataLoader, random_split
import pandas as pd
import struct
import numpy as np

torch.manual_seed(0)

def float_to_hex(f):
    hex_val = struct.unpack('<I', struct.pack('<f', f))[0]
    return f"{hex_val:08x}"

class IrisDataset(Dataset):
    def __init__(self, csv_file):
        # Load the CSV file
        df = pd.read_csv(csv_file)
        
        # Extract features and labels
        self.features = df[['SepalLengthCm', 'SepalWidthCm', 'PetalLengthCm', 'PetalWidthCm']].values
        self.labels = df['Species'].map({
            'Iris-setosa': 0,
            'Iris-versicolor': 1,
            'Iris-virginica': 2
        }).values
        
        # Convert to float32
        self.features = self.features.astype(np.float32)
        
    def __len__(self):
        return len(self.features)
    
    def __getitem__(self, idx):
        return torch.tensor(self.features[idx]), torch.tensor(self.labels[idx])

class IrisNet(nn.Module):
    def __init__(self):
        super().__init__()
        self.l1 = nn.Linear(4, 4)  # 4 input features, 8 hidden units
        self.l2 = nn.Linear(4, 3)
        self.act = nn.ReLU(inplace=True)
        
    def forward(self, x):
        x = self.act(self.l1(x))
        return self.l2(x)

# Load dataset
dataset = IrisDataset('data/Iris.csv')

# Split into train and test
train_size = int(0.8 * len(dataset))
test_size = len(dataset) - train_size
train_dataset, test_dataset = random_split(dataset, [train_size, test_size])

# Create data loaders
train_loader = DataLoader(train_dataset, batch_size=16, shuffle=True)
test_loader = DataLoader(test_dataset, batch_size=16, shuffle=False)

# Initialize model, loss, and optimizer
model = IrisNet()
criterion = nn.CrossEntropyLoss()
optimizer = optim.Adam(model.parameters(), lr=0.01)

# Training loop
for epoch in range(200):
    for inputs, labels in train_loader:
        optimizer.zero_grad()
        outputs = model(inputs)
        loss = criterion(outputs, labels)
        loss.backward()
        optimizer.step()
    
    if epoch % 20 == 0:
        print(f'Epoch {epoch}, Loss: {loss.item():.4f}')

# Evaluation
correct = 0
total = 0
with torch.no_grad():
    for inputs, labels in test_loader:
        outputs = model(inputs)
        _, predicted = torch.max(outputs.data, 1)
        total += labels.size(0)
        correct += (predicted == labels).sum().item()

print(f'Test Accuracy: {100 * correct / total:.2f}%')
memFile = open("data/irisMem.hex", "w+")

first_data, first_target = next(iter(test_loader))
first_data, first_target = first_data[0], first_target[0]
pred = model(first_data)
for val in pred: print(f"{val} -> {float_to_hex(val)}")
x = (nn.functional.relu(first_data @ model.l1.weight.data.T + model.l1.bias.data))
x = x @ model.l2.weight.data.T + model.l2.bias.data
print(x)
for val in first_data: 
    memFile.write(f"{float_to_hex(val)}\n")
    memFile.write("00000000\n"*3)

matrix = model.l1.weight.data.T
print(matrix.shape)
chunk = matrix.flatten()
for val in chunk:
    memFile.write(f"{float_to_hex(val)}\n")

matrix = model.l1.bias.data
print(matrix.shape)
for val in matrix:
    memFile.write(f"{float_to_hex(val)}\n")
memFile.write("00000000\n"*12)

matrix = model.l2.weight.data.T
print(matrix.shape)
expanded = torch.zeros(4, 4)
expanded[:, :3] = matrix
chunk = expanded.flatten()
for val in chunk:
    memFile.write(f"{float_to_hex(val)}\n")

matrix = model.l2.bias.data
print(matrix.shape)
for val in matrix:
    memFile.write(f"{float_to_hex(val)}\n")
memFile.write("00000000\n"*13)

memFile.close()
