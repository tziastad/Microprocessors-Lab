import enum
import sys

f = open("circuit.txt", "r")
lines = []
topInputs = {}
elementInputs = []
elementTable = []
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
		print(self.type)
		print(self.inputs)
		print("prin")
		print(topInputs)
		if (self.type == ElementType.AND):
			print("---mesa")
			print(self.inputs)
			topInputs[self.output], self.switchingActivity = spAND2(self.inputs[0], self.inputs[1])
		elif (self.type == ElementType.NOT):
			topInputs[self.output], self.switchingActivity = spNOT(self.inputs)
		print("meta")
		print(topInputs)
		return topInputs[self.output], self.switchingActivity


def spAND2(input1, input2):
	print("klithika", input1,input2)
	switchingActivity = 1
	s = input1 * input2;
	print("apotelesma",s)
	switchingActivity = 2 * s * (1 - s)

	# print("AND gate with inputs "+ str(input1)+" , "+ str(input2))
	# print("output is "+str(s)+" signal prob is "+str(s)+" and switching activity is "+ str(switchingActivity) )
	return s, switchingActivity


def spNOT(input1):
	switchingActivity = 1
	s = (1 - input1);

	switchingActivity = 2 * s * (1 - s)
	# print("NOT gate with input " +str(input1))
	# print("output is "+str(s)+" signal prob is "+str(s)+" and switching activity is "+ str(switchingActivity) )
	return s, switchingActivity


def findTopInputs():
	firstInputs = []
	for entity in lines:
		for element in range(len(entity)):
			if entity[0] == 'top_inputs':
				firstInputs = entity[1:len(entity)]

	# for x in firstInputs:
	# 	topInputs[x]=1
	topInputs['a']=0.5
	topInputs['b'] = 0.5
	topInputs['c'] = 0.5


	return topInputs


topInputs = findTopInputs()
print(topInputs)
lines.remove(lines[0])
for entity in lines:
	topInputs[entity[1]]=0
	if entity[0] == 'NOT':
		newElement=Element(ElementType.NOT, topInputs[entity[2]], entity[1], 0)
		newElement.process()
		elementTable.append(newElement)
	if entity[0] in twoInputsGates:
		gateOutput = entity[1]
		gateInputs = [topInputs[entity[2]], topInputs[entity[3]]]
		if entity[0] == 'AND':
			newElement=Element(ElementType.AND, gateInputs, gateOutput, 0)
			newElement.process()
		elif entity[0] == 'OR':
			newElement = Element(ElementType.OR, gateInputs, gateOutput, 0)
			newElement.process()
		elif entity[0] == 'NAND':
			newElement = Element(ElementType.NAND, gateInputs, gateOutput, 0)
			newElement.process()
		elif entity[0] == 'XOR':
			newElement = Element(ElementType.XOR, gateInputs, gateOutput, 0)
			newElement.process()
		elif entity[0] == 'XNOR':
			newElement = Element(ElementType.XNOR, gateInputs, gateOutput, 0)
			newElement.process()
		elif entity[0] == 'NOR':
			newElement = Element(ElementType.NOR, gateInputs, gateOutput, 0)
			newElement.process()
		elementTable.append(newElement)

print(topInputs)
for x in elementTable:
	print(x.type)
	print(x.switchingActivity)





f.close()
