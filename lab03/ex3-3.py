import enum
import itertools
from copy import deepcopy

f = open("circuit.txt", "r")

global lines
lines = []
global elementTableSorted
elementTableSorted = []
global elementTableSortedCopy
elementTableSortedCopy=[]
global outputsOfSortedElements
outputsOfSortedElements = []
global elementTable
elementTable = []
global signalTable
signalTable = []
global inputValue
inputValue = []
global gateInput
gateInput = []
global topInputs
topInputs = []
global truthTable
truthTable = []
global checkList
checkList = []
global nInputsGates
nInputsGates = ['AND', 'OR', 'XOR', 'XNOR', 'NAND', 'NOR']
global isSorted
isSorted=True


def readFile(file):
    global lines
    for l in f:
        # print(l)
        lines.append(l.split())
    return lines


class ElementType(enum.Enum):
    AND = 1
    OR = 2
    NOT = 3
    NOR = 4
    XOR = 5
    NAND = 6
    XNOR = 7


class Element:
    def __init__(self, type, inputs, output, switchingActivity):
        self.type = type
        self.inputs = inputs
        self.output = output
        self.switchingActivity = switchingActivity

    def process(self):
        if (self.type == ElementType.NOT):
            inputValue[signalTable.index(self.output)], self.switchingActivity = spNOT(self.inputs)
        elif (self.type == ElementType.AND):
            inputValue[signalTable.index(self.output)], self.switchingActivity = spAND(self.inputs)
        elif (self.type == ElementType.OR):

            inputValue[signalTable.index(self.output)], self.switchingActivity = spOR(self.inputs)
        elif (self.type == ElementType.NOR):
            inputValue[signalTable.index(self.output)], self.switchingActivity = spNOR(self.inputs)
        elif (self.type == ElementType.XOR):
            inputValue[signalTable.index(self.output)], self.switchingActivity = spXOR(self.inputs)
        elif (self.type == ElementType.NAND):
            inputValue[signalTable.index(self.output)], self.switchingActivity = spNAND(self.inputs)
        elif (self.type == ElementType.XNOR):
            inputValue[signalTable.index(self.output)], self.switchingActivity = spXNOR(self.inputs)
        return inputValue[signalTable.index(self.output)], self.switchingActivity


def spAND(inputs):
    switchingActivity = 1
    s = 1
    for i in inputs:
        s = s * i
    switchingActivity = 2 * s * (1 - s)
    return s, switchingActivity


def spNOT(input1):
    s = 0
    switchingActivity = 1
    for i in input1:
        s = 1 - i
    switchingActivity = 2 * s * (1 - s)
    return s, switchingActivity


def spOR(inputs):
    switchingActivity = 1
    r = 1
    for i in inputs:
        r = r * (1 - i)
    s = 1 - r
    switchingActivity = 2 * s * (1 - s)
    return s, switchingActivity


def sp2XOR(input1, input2):
    switchingActivity = 1
    s = (1 - input1) * input2 + input1 * (1 - input2)
    switchingActivity = 2 * s * (1 - s)
    return s, switchingActivity


def spXOR(inputs):
    s = 1
    switchingActivity = 1
    for i in inputs:
        s, _ = sp2XOR(s, i)
    switchingActivity = 2 * s * (1 - s)
    return s, switchingActivity


def spNAND(inputs):
    switchingActivity = 1
    r = 1
    for i in inputs:
        r = r * i
    s = 1 - r
    switchingActivity = 2 * s * (1 - s)
    return s, switchingActivity


def spNOR(inputs):
    s = 1
    switchingActivity = 1
    for i in inputs:
        s = s * (1 - i)
    switchingActivity = 2 * s * (1 - s)
    return s, switchingActivity


def spXNOR(inputs):
    s = 1
    r = 1
    switchingActivity = 1
    for i in inputs:
        r, _ = sp2XOR(r, i)
    s = 1 - r
    switchingActivity = 2 * s * (1 - s)
    return s, switchingActivity


def findTopInputs():
    firstInputs = []
    outputs = []
    for entity in lines:
        if (entity[0] == 'top_inputs'):
            continue
        outputs.append(entity[1])
    if 'top_inputs' in lines[0]:
        firstInputs = lines[0].copy()
        firstInputs.remove(firstInputs[0])  # remove 'top inputs' string
    else:
        for entity in lines:
            for element in range(2, len(entity)):
                if (entity[element] in outputs):
                    continue
                elif (entity[element] not in nInputsGates and entity[element] not in firstInputs and entity[
                    element] != 'NOT'):
                    firstInputs.append(entity[element])
    return firstInputs
def fillSignalTable():
    global signalTable
    global topInputs
    global lines
    topInputs = findTopInputs()
    print("topInputs:", topInputs)
    # vale sto signalTable ta topInputs
    for i in topInputs:
        signalTable.append(i)
    for entity in lines:
        if (entity[0] == 'top_inputs'):
            continue
        if (entity[1] not in signalTable):
            signalTable.append(entity[1])  # vale ta output twn pulwn pou sunantas

    for entity in lines:
        if entity[1] not in signalTable:
            signalTable.append(entity[1])  # vale kai tin eksodo tou kuklwmatos

def fillElementTable():
    global lines
    global gateInput
    global elementTable
    global elementTableSorted
    global outputsOfSortedElements
    for entity in lines:
        if (entity[0] == 'top_inputs'):
            continue
        gateInput.clear()
        for i in range(2, len(entity)):
            # onomata simatwn stis eisodous tis kathe pulis
            gateInput.append(entity[i])
        newElement = Element(ElementType[entity[0]], gateInput.copy(), entity[1], 0)
        elementTable.append(newElement)
        if(isSorted==True):
            if all(elem in topInputs for elem in gateInput):
                elementTableSorted.append(newElement)
                outputsOfSortedElements.append(newElement.output)

def sortTheCircuit():
    global outputsOfSortedElements
    global topInputs
    global elementTable
    global elementTableSorted
    global isSorted
    checkList = []
    isSorted=False
    checkList = outputsOfSortedElements + topInputs
    for i in elementTable:
        if i not in elementTableSorted and all(elem in checkList for elem in i.inputs):
            elementTableSorted.append(i)
            checkList.append(i.output)

    count = 0
    while (count < len(elementTable)):
        for i in elementTable:
            if i in elementTable and i not in elementTableSorted and all(elem in checkList for elem in i.inputs):
                elementTableSorted.append(i)
                checkList.append(i.output)
        count = count + 1



def createCircuit(inputs):
    global lines
    global gateInput
    global signalTable
    global elementTable
    global topInputs
    global inputValue
    global outputsOfSortedElements
    global elementTableSortedCopy

    fillSignalTable()
    print("signalTable:", signalTable)
    # vale sto inputValue tis times twn topInputs
    inputValue = inputs.copy()

    for i in range(len(topInputs), len(signalTable)):
        inputValue.append(0)  # arxikopoiise ta endiamesa simata tou signalTable sto 0 ektos apo ta topInputs
    print("input values",inputValue)

    fillElementTable()
    elementTableSortedCopy.clear()
    if(isSorted==True):
        sortTheCircuit()
    # for i in elementTableSorted:
    #     print(i.type,i.inputs,i.output)
    elementTableSortedCopy=deepcopy(elementTableSorted)

    # print(signalTable)
    # print(inputValue)
    print("_____sorted_____")
    for i in elementTableSortedCopy:
        print(i.type)
        print(i.inputs)
        for j in range(len(i.inputs)):
            i.inputs[j] = inputValue[signalTable.index(i.inputs[j])]
        print(i.inputs)
        print(i.output)
        out, sw = i.process()
        print(f"out:{out}, sw: {sw}")

    # for i in elementTableSortedCopy:
    #     print(i.type,i.inputs,i.output)






def testbench():
    global topInputs
    global signalTable
    global truthTable
    topInputs = findTopInputs()
    print("top inputs ", topInputs)
    truthTable = list(itertools.product([0, 1], repeat=len(topInputs)))
    for i in range(len(truthTable)):
        for j in range(len(topInputs)):
            topInputs[j] = truthTable[i][j]
        print("---------------")
        signalTable.clear()
        elementTableSortedCopy.clear()
        createCircuit(topInputs)


def testbenchAverageSW():
    print("------AVERAGE SW-------")
    for i in range(len(topInputs)):
        topInputs[i] = 0.5
    signalTable.clear()
    elementTableSortedCopy.clear()
    createCircuit(topInputs)


def testbenchForAM():
    print("------AVERAGE AM-------")
    for i in range(len(topInputs)):
        topInputs[i] = 0.4178
    signalTable.clear()
    elementTableSortedCopy.clear()
    createCircuit(topInputs)


def giveInputs():
    global topInputs
    global signalTable
    c = 0
    userChoose = input("Choose 1 for testbench inputs or 0 to give your inputs at the top_inputs:")
    topInputs = findTopInputs()
    lenghtOftopInputs = len(topInputs)
    if userChoose == '0':
        print("top inputs", topInputs)
        print(f"You must give {lenghtOftopInputs} values")
        for i in range(len(topInputs)):
            c = c + 1
            topInputs[i] = float(input("\n give a value for %d top input: " % c))
        createCircuit(topInputs)
    else:
        testbench()
        # testbenchAverageSW()
        # testbenchForAM()


readFile(f)
giveInputs()
