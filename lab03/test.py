f = open("circuit.txt", "r")
lines = []

topInputs = {}
elementInputs = []
elementTable = []
twoInputsGates = ['AND', 'OR', 'XOR', 'XNOR', 'NAND', 'NOR']
for l in f:
    # print(l)
    lines.append(l.split())


def findTopInputs():
    firstInputs = []
    for entity in lines:
        for element in range(len(entity)):
            if entity[0] == 'top_inputs':
                firstInputs = entity[1:len(entity)]
    for x in firstInputs:
        topInputs[x]=0

    return topInputs


topInputs = findTopInputs()

for x in topInputs.values():
    print(x)
print(topInputs)
