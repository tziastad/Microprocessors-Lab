

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
		if(self.type==ElementType.AND):
			self.output,self.switchingActivity=spAND2(self.inputs[0],self.inputs[1])
		elif(self.type==ElementType.NOT):
			self.output,self.switchingActivity=spNOT(self.inputs[0])
		return self.output,self.switchingActivity


def spAND2(input1,input2):

	switchingActivity=1
	s=input1*input2;
	
	switchingActivity=2*s*(1-s)

	return s,switchingActivity


def spNOT(input1):
	switchingActivity=1
	s=(1-input1);
	
	switchingActivity=2*s*(1-s)
	return s,switchingActivity


def testbenchForVerification():
#                a, b, c, e, f, d
	truthTable=[[0, 0, 0, 0, 1, 0],
				[0, 0, 1, 0, 0, 0],
				[0, 1, 0, 0, 1, 0],
				[0, 1, 1, 0, 0, 0],
				[1, 0, 0, 0, 1, 0],
				[1, 0, 1, 0, 0, 0],
				[1, 1, 0, 1, 1, 1],
				[1, 1, 1, 1, 0, 0]]


	for vector in truthTable:
		display=True
		for j in range(len(vector)):
			while(display==True):
				display=False
				workLoad=[vector[0],vector[1],vector[2]]  #three first inputs of each line
				print(str(workLoad))
				inputsforE1=[vector[0],vector[1]]
				inputsforE2=[vector[2]]
				inputsforE3=[vector[3],vector[4]]
				E1=Element(ElementType.AND,inputsforE1,vector[3],0)
				E2=Element(ElementType.NOT,inputsforE2,vector[4],0)
				E3=Element(ElementType.AND,inputsforE3,vector[5],0)

				outputE1,_=E1.process()
				outputE2,_=E2.process()
				outputE3,_=E3.process()
				workLoad.append(outputE1)
				workLoad.append(outputE2)
				workLoad.append(outputE3)
				if(outputE1==vector[3] and outputE2==vector[4] and outputE3==vector[5]):
					print("success --> "+str(vector) + " vs "+ str(workLoad))
				else:
					print("failure --> "+ str(vector) + " vs "+ str(workLoad))

def testbenchForAverageSa():

		#             	 a,  b,  c
		unknownWorkLoad=[0.5,0.5,0.5,0,0,0]
		print(str(unknownWorkLoad))

		inputsforE1=[unknownWorkLoad[0],unknownWorkLoad[1]]
		inputsforE2=[unknownWorkLoad[2]]
		E1=Element(ElementType.AND,inputsforE1,unknownWorkLoad[3],0)
		E2=Element(ElementType.NOT,inputsforE2,unknownWorkLoad[4],0)
		

		outputE1,swE1=E1.process()
		outputE2,swE2=E2.process()
		inputsforE3=[outputE1,outputE2]
		E3=Element(ElementType.AND,inputsforE3,unknownWorkLoad[5],0)
		outputE3,swE3=E3.process()
		print("average switching activity is ", swE3)

def AMSwitcingActivity():

		amWorkLoad=[0.4178,0.4178,0.4178,0,0,0]
		print(str(amWorkLoad))

		inputsforE1=[amWorkLoad[0],amWorkLoad[1]]
		inputsforE2=[amWorkLoad[2]]
		E1=Element(ElementType.AND,inputsforE1,amWorkLoad[3],0)
		E2=Element(ElementType.NOT,inputsforE2,amWorkLoad[4],0)
		

		outputE1,swE1=E1.process()
		outputE2,swE2=E2.process()
		inputsforE3=[outputE1,outputE2]
		E3=Element(ElementType.AND,inputsforE3,amWorkLoad[5],0)
		outputE3,swE3=E3.process()
		print("switching activity is ", swE3)

				
	




testbenchForVerification()
testbenchForAverageSa()
AMSwitcingActivity()