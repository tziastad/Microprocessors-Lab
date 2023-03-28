import enum
import itertools
import random
import statistics
import matplotlib.pyplot as plt
import numpy as np
from copy import deepcopy

f = open("unsorted.txt", "r")

global lines
lines = []
global elementTableSorted
elementTableSorted = []
global elementTableSortedCopy
elementTableSortedCopy = []
global outputsOfSortedElements
outputsOfSortedElements = []
global elementTable
elementTable = []
global signalTable
signalTable = []
# global signalsBefore
# signalsBefore=[]
# global signals
# signals=[]
global processOutput
processOutput = []
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
global workLoad
workLoad = []
global nInputsGates
nInputsGates = ['AND', 'OR', 'XOR', 'XNOR', 'NAND', 'NOR']
global isSorted
isSorted = True


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
    # print("topInputs:", topInputs)
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
        if (isSorted == True):
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
    isSorted = False
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
    # print("signalTable:", signalTable)
    # vale sto inputValue tis times twn topInputs
    inputValue = inputs.copy()

    for i in range(len(topInputs), len(signalTable)):
        inputValue.append(0)  # arxikopoiise ta endiamesa simata tou signalTable sto 0 ektos apo ta topInputs
    # print("input values",inputValue)

    fillElementTable()
    elementTableSortedCopy.clear()
    if (isSorted == True):
        sortTheCircuit()
    # for i in elementTableSorted:
    #     print(i.type,i.inputs,i.output)
    elementTableSortedCopy = deepcopy(elementTableSorted)

    # print(signalTable)
    # print(inputValue)
    # print("_____sorted_____")
    for i in elementTableSortedCopy:
        # print(i.type)
        # print(i.inputs)
        for j in range(len(i.inputs)):
            i.inputs[j] = inputValue[signalTable.index(i.inputs[j])]
        # print(i.inputs)
        # print(i.output)
        out, sw = i.process()
        # print(f"out:{out}, sw: {sw}")
        processOutput.append(out)
        # print(f"out:{out}, sw: {sw}")
    return processOutput


def countSwitches(l1, l2):
    switches = 0
    for i in range(len(l1)):
        if (l1[i] != l2[i]):
            switches = switches + 1
    return switches


def findTwoLargest(list1):
    # SE PERIPTWSI POY UPARXEI DYO FORES TO MAX KANE AYTO

    yolo = list1.copy()
    yolo.sort(reverse=True)
    return yolo[0], yolo[1]
    # mx=list1[0]
    # for x in list1:
    #     mx = max(mx,x)
    #
    # indices_of_max = []
    # for i in range (0,len(list1)):
    #     x = list1[i]
    #     if (x == mx):
    #         indices_of_max.append(i)
    #
    # if (len(indices_of_max) >=2):
    #     return mx,mx
    # return mx

    # for x in list1:
    #     if (x == mx):
    #         indices_of_max.append()
    #
    # for x in list1:
    #     if x==mx:
    #
    #
    #         for i in range(list1.index(mx)+1,len(list1)):
    #             if list1[i]==mx:
    #                 secondmaxIndex = [i for i, n in enumerate(list1) if n == mx][1]
    #                 secondmax=list1[secondmaxIndex]
    #                 return mx,secondmax
    # #-------------------------------------------------------------
    #     else:
    #
    # #SE PERIPTWSI POU YPARXEI MIA FORA TO MAX KANE TA PARAKATW
    #         mx = max(list1[0], list1[1])
    #         secondmax = min(list1[0], list1[1])
    #         n = len(list1)
    #         for i in range(2, n):
    #
    #             if list1[i] > mx:
    #                 secondmax = mx
    #                 mx = list1[i]
    #             elif list1[i] > secondmax and mx != list1[i]:
    #                 secondmax = list1[i]
    #
    # return mx,secondmax


def find_indices_of_maximum_numbers(max1, max2, scores):
    index1 = scores.index(max1)
    index2 = scores.index(max2)
    if (index1 != index2):
        return index1,index2

    index1 = scores.index(max1)
    index2 = scores.index(max2,index1 +1)
    return index1, index2


def selectParents(scores):
    global workLoad
    largest, secondLargest = findTwoLargest(scores)
    print(scores)
    print(largest, secondLargest)

    ind1, ind2 = find_indices_of_maximum_numbers(largest,secondLargest,scores)
    print(ind1, ind2)
    parent1 = workLoad[ind1]
    parent2 = workLoad[ind2]
    print("___PARENT1___")
    for i in parent1:
        print(i)
    print("___PARENT2___")
    for i in parent2:
        print(i)
    return parent1, parent2



def crossOverParents(parent1, parent2, N, L):
    newGeneration = []
    individuals = []
    newWorkload = []
    scores=[]
    newGeneration.append(parent1)
    newGeneration.append(parent2)
    for i in range(0, N - 2):
        individuals.append(i)
        C = random.randint(1, 2)
        print("C", C)

        R = random.randint(1, L)
        print("R", R)
        newWorkload.clear()

        if C == 1:
            for i in range(0, R):
                newWorkload.append(parent1[i])
            for j in range(R, L):
                newWorkload.append(parent2[j])
        else:
            for i in range(0, R):
                newWorkload.append(parent2[i])
            for j in range(R, L):
                newWorkload.append(parent1[j])

        newWorkload_copy=deepcopy(newWorkload)
        newGeneration.append(newWorkload_copy)
    print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
    return newGeneration
    # for i in range(0,len(newGeneration)):
    #     print(f"------{i}-------")
    #     print(newGeneration[i])
    #     scoreOfEachIndividual = mesurePopulation(N, L, newGeneration[i])
    #     scores.append(scoreOfEachIndividual)
    #     # for j in range(0,len(newGeneration[i])):
    #     #     print(newGeneration[i][j])
    # print("geniaaaaaa")
    # print(scores)
    # parent1, parent2 = selectParents(scores)

def mutation(newPopulation):
    m = 0.05
    # print("--prin --")
    # for i in newPopulation:
    #     print(i)
    old = newPopulation[0].copy()
    old1 = newPopulation[1].copy()
    # print(newPopulation[0])
    # print(newPopulation[1])
    for i in range(2, len(newPopulation)):
        for j in range(0, len(newPopulation[i])):
            for k in range(0, len(newPopulation[i][j])):
                prob = random.random()
                if prob <= m:
                    if newPopulation[i][j][k] == 0:
                        newPopulation[i][j][k] = 1
                    else:
                        newPopulation[i][j][k] = 0
    if (old != newPopulation[0] or old1 !=newPopulation[1]):
        raise Exception("DEN INE IDIA")
    # print("--meta--")
    # for i in newPopulation:
    #     print(i)

    return newPopulation


def mesurePopulation(N,L,individual):
    global workLoad
    outputSignals=[]
    numberOfSwitches=[]
    total=0
    for i in range(0,len(individual)):
        output = createCircuit(individual[i])
        signals= output.copy()
        outputSignals.append(signals)
        processOutput.clear()
        elementTableSortedCopy.clear()
        signalTable.clear()
    print("-----------------output-----------")
    for i in outputSignals:
        print(i)
    # for i in outputSignals:
    for i in range(len(outputSignals)-1):
        switches = countSwitches(outputSignals[i], outputSignals[i+1])
        i=i+1
        numberOfSwitches.append(switches)

    for i in range(0,len(numberOfSwitches)):
        total=total+numberOfSwitches[i]

    return total

def genericAlgorithm(newPop,N,L):
    scores = []
    for i in range(0,100):
        scoreOfEachIndividual = mesurePopulation(N, L, newPop)
        scores.append(scoreOfEachIndividual)
        parent1, parent2 = selectParents(scores)
        newPop = crossOverParents(parent1, parent2, N, L)
        mutatedPopulation=mutation(newPop)
        genericAlgorithm(mutatedPopulation,N,L)


def giveInputs():
    global topInputs
    global signalTable
    global workLoad
    output = []
    vectors_copy = []
    c = 0
    # userChoose = input("Choose 1 for testbench inputs or 0 to give your inputs at the top_inputs:")
    topInputs = findTopInputs()
    lenghtOftopInputs = len(topInputs)
    L = 2
    vectors = []
    individuals = []
    scores = []
    N = 10
    for j in range(0, N):
        individuals.append(j)
        print(f"***********************{j}*******************************")
        vectors.clear()
        for i in range(0, L):
            vectors.append([])
            for j in range(0, lenghtOftopInputs):
                n = random.randint(0, 1)
                vectors[i].append(n)
        vectors_copy = deepcopy(vectors)
        workLoad.append(vectors_copy)
        print(vectors)
        scoreOfEachIndividual=mesurePopulation(N,L,vectors)
        scores.append(scoreOfEachIndividual)

    # for i in range(0, N):
    #     print(individuals[i], workLoad[i], scores[i])
    parent1, parent2 = selectParents(scores)
    newPop=crossOverParents(parent1,parent2,N,L)
    genericAlgorithm(newPop,N,L)
    # plt.plot(individuals,scores)
    # plt.show()
    # print("mean:",statistics.mean(scores))
    # print("variance:", statistics.variance(scores))


readFile(f)
giveInputs()