import enum
import itertools

f = open("circuit.txt", "r")
global lines
lines = []
global topInputs
topInputs = {}
global allInputsOutpus
allInputsOutpus = {}
global truthTable
truthTable = []
elementTable = []
gateInputs = {}

for l in f:
    # print(l)
    lines.append(l.split())


class ElementType(enum.Enum):
    AND = 1
    OR = 2
    NOT = 3
    NOR = 4
    XOR = 5
    NAND = 6


class Element:
    def __init__(self, type, inputs, output, switchingActivity):
        self.type = type
        self.inputs = inputs
        self.output = output
        self.switchingActivity = switchingActivity

    def process(self):
        if (self.type == ElementType.NOT):
            allInputsOutpus[self.output], self.switchingActivity = spNOT(self.inputs)
        elif (self.type == ElementType.AND):
            allInputsOutpus[self.output], self.switchingActivity = spAND(self.inputs)
        elif (self.type == ElementType.OR):
            allInputsOutpus[self.output], self.switchingActivity = spOR(self.inputs)
        elif (self.type == ElementType.NOR):
            allInputsOutpus[self.output], self.switchingActivity = spNOR(self.inputs)
        elif (self.type == ElementType.XOR):
            allInputsOutpus[self.output], self.switchingActivity = spXOR(self.inputs)
        elif (self.type == ElementType.NAND):
            allInputsOutpus[self.output], self.switchingActivity = spNAND(self.inputs)
        return allInputsOutpus[self.output], self.switchingActivity


def spAND(inputs):
    switchingActivity = 1
    s = 1
    for i in inputs:
        s = s * inputs[i]
    switchingActivity = 2 * s * (1 - s)

    # print("AND gate with inputs "+ str(input1)+" , "+ str(input2))
    # print("output is "+str(s)+" signal prob is "+str(s)+" and switching activity is "+ str(switchingActivity) )
    return s, switchingActivity


def spNOT(input1):
    switchingActivity = 1
    s = 1 - input1
    switchingActivity = 2 * s * (1 - s)
    return s, switchingActivity


def spOR(inputs):
    switchingActivity = 1
    r = 1
    for i in inputs:
        r = r * (1 - inputs[i])
    s = 1 - r
    switchingActivity = 2 * s * (1 - s)
    return s, switchingActivity


def sp2XOR(input1, input2):
    switchingActivity = 1
    s = (1 - input1) * input2 + input1 * (1 - input2);

    switchingActivity = 2 * s * (1 - s)
    return s, switchingActivity


def spXOR(inputs):
    s = 1
    switchingActivity = 1
    for i in inputs:
        s = sp2XOR(s, inputs[i])

    switchingActivity = 2 * s * (1 - s)
    return s, switchingActivity


def spNAND(inputs):
    switchingActivity = 1
    r = 1
    for i in inputs:
        r = r * inputs[i]
    s = 1 - r
    switchingActivity = 2 * s * (1 - s)
    return s, switchingActivity


def spNOR(inputs):
    switchingActivity = 1
    for i in inputs:
        s = s * (1 - inputs[i])
    switchingActivity = 2 * s * (1 - s)
    return s, switchingActivity


def findTopInputs():
    firstInputs = []
    outputs = []
    if 'top_inputs' in lines[0]:
        firstInputs = lines[0]
        firstInputs.remove(firstInputs[0])  # remove 'top inputs' string
    else:
        for entity in lines:
            outputs.append(entity[1])
            for element in range(2, len(entity)):
                if (entity[element] not in twoInputsGates and entity[element] != 'NOT' and entity[
                    element] not in outputs):
                    firstInputs.append(entity[element])

    return firstInputs


def createCircuit(signals):
    global allInputsOutpus

    allInputsOutpus = dict(signals)
    for entity in lines:

        if entity[1] not in allInputsOutpus.keys():  # euresi kai arxikopoisi endiameswn simatwn
            allInputsOutpus[entity[1]] = 0
        if entity[0] == 'NOT':
            elementType = ElementType[entity[0]]
            print(elementType)
            newElement = Element(ElementType.NOT, allInputsOutpus[entity[2]], entity[1], 0)
            print("input:", newElement.inputs)
            elementTable.append(newElement)
            output, sw = newElement.process()
            print(f"sp:{output}, sw: {sw}")
        if entity[0] in twoInputsGates:
            gateOutput = entity[1]
            elementType = ElementType[entity[0]]
            print(elementType)
            for x in range(2, len(entity)):
                gateInputs[x] = allInputsOutpus[entity[x]]
            newElement = Element(elementType, gateInputs, gateOutput, 0)
            elementTable.append(newElement)
            print("input:", newElement.inputs.values())
            output, sw = newElement.process()
            print(f"sp:{output}, sw: {sw}")

def testbench():
    global topInputs
    topInputs = findTopInputs()
    print("top inputs ", topInputs)
    global truthTable
    truthTable = list(itertools.product([0, 1], repeat=len(topInputs)))
    for i in range(len(truthTable)):
        for j in range(len(topInputs)):
            allInputsOutpus[topInputs[j]] = truthTable[i][j]
        print(allInputsOutpus)
        createCircuit(allInputsOutpus)
        print(allInputsOutpus)


def testbenchAverageSW():
    allInputsOutpus.clear()
    print("------AVERAGE SW------")
    for i in range(len(topInputs)):
        allInputsOutpus[topInputs[i]] = 0.5
    print(allInputsOutpus)
    createCircuit(allInputsOutpus)

def giveInputs(topInputs):
    global allInputsOutpus
    c=0
    lenghtOftopInputs=len(topInputs)
    print(f"You must give {lenghtOftopInputs} values")
    for i in range(len(topInputs)):
        c=c+1
        allInputsOutpus[topInputs[i]]=float(input("\n give a value for %d top input: " % c))
    createCircuit(allInputsOutpus)


def testbenchForAM():
    allInputsOutpus.clear()
    print("------SW with AM------")
    for i in range(len(topInputs)):
        allInputsOutpus[topInputs[i]] = 0.4178
    print(allInputsOutpus)
    createCircuit(allInputsOutpus)

userChoose = input("Choose 0 for testbench inputs or 1 for give your inputs at the top_inputs:")
if userChoose=='0':
    # testbench()
    testbenchAverageSW()
    # testbenchForAM()
else:
    topInputs=findTopInputs()
    giveInputs(topInputs)
f.close()
