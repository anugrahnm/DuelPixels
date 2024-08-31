extends Node
class_name moveset_data

const DATA = "moves"

#const N0_data = {"N0":{"N0_punch":["left jab",N0_punch_N1],"kick":""}}
#const N0_punch_N1 = {"N1":{"N1_punch":["quick second left jab"]}}

func ExtractData():
	return DATA


# data = dictionary for the first/next layer of N , which leads to a list of move names, which act as a dictionary key
# its value is a array that contain all its relevant details ex. index(0) = name and index(-1)
