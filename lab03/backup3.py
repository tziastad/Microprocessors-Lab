import enum
import sys

f = open("circuit.txt", "r")
lines = []
topInputs = {}
allInputsOutpus={}
elementTable = []
gateInputs={}
twoInputsGates = ['AND', 'OR', 'XOR', 'XNOR', 'NAND', 'NOR']
for l in f:
	# print(l)
	lines.append(l.split())


class ElementType(enum.Enum):
	AND = 1
	OR = 2
	NOT = 3
	NOR = 4
	XOR = 5
	XNOR = 6
	NAND = 7


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
			allInputsOutpus[self.output], self.switchingActivity = NAND(self.inputs)
		return allInputsOutpus[self.output], self.switchingActivity


def spAND(inputs):
	switchingActivity = 1
	s=1
	for i in inputs:
		s = s*inputs[i]

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
	for i in inputs:
		r =r* (1-inputs[i])
	s=1-r
	switchingActivity = 2 * s * (1 - s)
	return s,switchingActivity

def sp2XOR(input1,input2):
	switchingActivity = 1
	s=(1-input1)*input2 + input1*(1-input2);

	switchingActivity = 2 * s * (1 - s)
	return s, switchingActivity

def spXOR(inputs):
	s=1
	switchingActivity = 1
	for i in inputs:
		s=sp2XOR(s,inputs[i])

	switchingActivity = 2 * s * (1 - s)
	return s, switchingActivity

def spNAND(inputs):
	switchingActivity = 1
	for i in inputs:
		r=r*inputs[i]
	s=1-r
	switchingActivity = 2 * s * (1 - s)
	return s, switchingActivity

def spNOR(inputs):
	switchingActivity = 1
	for i in inputs:
		s = s*(1-inputs[i])
	switchingActivity = 2 * s * (1 - s)
	return s, switchingActivity






def findTopInputs():
	firstInputs = []
	outputs=[]
	if 'top_inputs' in lines[0]:
		firstInputs = lines[0]
		firstInputs.remove(firstInputs[0]) #remove 'top inputs' string
	else:
		for entity in lines:
			outputs.append(entity[1])
			for element in range(2,len(entity)):
				if(entity[element] not in twoInputsGates and entity[element]!='NOT' and entity[element] not in outputs):
					firstInputs.append(entity[element])

	return firstInputs




def createCircuit(signals):
	topInputs = findTopInputs()
	print(topInputs)
	allInputsOutpus={}

	#copy top inputs in the dictionary of all inputs and outputs
	for x in topInputs:
		allInputsOutpus[x]=0


	for entity in lines:
		gateInputs.clear()
		if entity[1] not in allInputsOutpus.keys(): # euresi kai arxikopoisi endiameswn simatwn
			allInputsOutpus[entity[1]]=0
		if entity[0] == 'NOT':
			newElement=Element(ElementType.NOT, allInputsOutpus[entity[2]], entity[1], 0)
			output,sw=newElement.process()
			elementTable.append(newElement)
			print(newElement.type)
			print(newElement.inputs)
			print(output, sw)
		if entity[0] in twoInputsGates:
			gateOutput = entity[1]
			for x in range(2,len(entity)):
				gateInputs[x]=allInputsOutpus[entity[x]]
			#print(gateInputs)
			elementType=ElementType[entity[0]]
			newElement=Element(elementType, gateInputs, gateOutput, 0)
			output,sw=newElement.process()
			elementTable.append(newElement)
			print(newElement.type)
			print(newElement.inputs)
			print(output,sw)



	print(allInputsOutpus)


def testbench():
	truthTable=[[0,0,0],
				[0,0,1],
				[0,1,0],
				[0,1,1],
				[1,0,0],
				[1,0,1],
				[1,1,0],
				[1,1,1]]

	for vector in truthTable:
		allInputsOutpus['a']=vector[0]
		allInputsOutpus['b']=vector[1]
		allInputsOutpus['c']=vector[2]

	return allInputsOutpus


createCircuit()
f.close()
