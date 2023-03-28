
import enum


class ElementType(enum.Enum):
	AND=1
	OR=2
	NOT=3
	NOR=4
	XOR=5
	XNOR=6
	NAND=7


class Element:
	def __init__(self,type,inputs,output,switchingActivity):
		self.type=type
		self.inputs=inputs
		self.output=output
		self.switchingActivity=switchingActivity


	def process(self):
		#print(self.inputs[0])
		if(self.type==ElementType.AND):
			self.output,self.switchingActivity=spAND2(self.inputs[0],self.inputs[1])
		elif(self.type==ElementType.NOT):
			self.output,self.switchingActivity=spNOT(self.inputs)
		return self.output,self.switchingActivity



def spAND2(input1,input2):

	switchingActivity=1
	s=input1*input2;

	switchingActivity=2*s*(1-s)

	#print("AND gate with inputs "+ str(input1)+" , "+ str(input2))
	#print("output is "+str(s)+" signal prob is "+str(s)+" and switching activity is "+ str(switchingActivity) )
	return s,switchingActivity


def spNOT(input1):
	switchingActivity=1
	s=(1-input1);

	switchingActivity=2*s*(1-s)
	#print("NOT gate with input " +str(input1))
	#print("output is "+str(s)+" signal prob is "+str(s)+" and switching activity is "+ str(switchingActivity) )
	return s,switchingActivity


def findTopInputs():
	for entity in lines:
		for element in range(len(entity)):
			if entity[0] == 'top_inputs':
				topInputs = entity[1:len(entity)]

	return topInputs


f = open("circuit.txt", "r")
lines=[]
topInputs=[]
elementInputs=[]
elementTable=[]
twoInputsGates=['AND','OR','XOR','XNOR','NAND','NOR']
for l in f:
	#print(l)
	lines.append(l.split())

topInputs=findTopInputs()

print(topInputs)

for entity in lines:
	if entity[0]== 'NOT':
		elementTable.append(Element(ElementType.NOT,topInputs[2],entity[2],0))
	if entity[0] in twoInputsGates:
		gateOutput=entity[1]
		gateInputs=[topInputs[0],topInputs[1]]
		if entity[0]== 'AND':
			elementTable.append(Element(ElementType.AND,gateInputs,gateInputs,0))
		elif entity[0]== 'OR':
			elementTable.append(Element(ElementType.OR,gateOutput,gateInputs,0))
		elif entity[0]== 'NAND':
			elementTable.append(Element(ElementType.NAND,gateOutput,gateInputs,0))
		elif entity[0]== 'XOR':
			elementTable.append(Element(ElementType.XOR,gateOutput,gateInputs,0))
		elif entity[0]== 'XNOR':
			elementTable.append(Element(ElementType.XNOR,gateOutput,gateInputs,0))
		elif entity[0]== 'NOR':
			elementTable.append(Element(ElementType.NOR,gateOutput,gateInputs,0))



print(len(elementTable))
# for x in elementTable:
# 	out,sw=x.process()
# 	print(x.type)
# 	print(out,sw)


f.close()