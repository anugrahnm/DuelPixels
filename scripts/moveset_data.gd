extends Node
class_name moveset_data

const DATA = "moves"
const json_file_path = "res://scripts/data.json"
const empty = ""

var json_data = {}
var data = {}

var last_N0_value = ""
var last_N1_value = ""
var last_N2_value = ""
var last_N3_value = ""

var temp1 = {}
var temp2 = {}
var temp3 = {}
#const N0_data = {"N0":{"N0_punch":["left jab",N0_punch_N1],"kick":""}}
#const N0_punch_N1 = {"N1":{"N1_punch":["quick second left jab"]}}

func ExtractData():
	var json_data = FileAccess.open(json_file_path, FileAccess.READ)
	var parsedResult = JSON.parse_string(json_data.get_as_text())
	
	
	#for row in parsedResult:
		#for col in len(row.values()):
			#if row.values()[col] != empty:
				##data["N"+str(col)]=row.values()[col]
				#DoTheThing(str(col),row.values()[col],len(row.values()))
	
	for row in parsedResult:
		DoTheThing(int(row.keys()[1]),row.values())

	json_data = parsedResult[2]
	json_data = data
	
	
	return [json_data,DATA]
	
func DoTheThing(N_depth,col_values):
	
	var row_accessed_before = false
	
	for N in len(col_values):
		if N == 0 and col_values[N] != empty:
			last_N0_value = col_values[0]
			data["N"+"0"] = {last_N0_value:[last_N0_value]}
		if N == 1 and col_values[N] != empty:
			last_N1_value = col_values[1]
			temp1["N"+ "1"] = {last_N1_value:[last_N1_value]}
			data["N0"][last_N0_value].append(temp1)
		if N == 2 and col_values[N] != empty:
			last_N2_value = col_values[2]
			temp2["N" + "2"] = {last_N2_value:[last_N2_value]}
			data["N0"][last_N0_value][1]["N1"][last_N1_value].append(temp2)
		if N == 3 and col_values[N] != empty:
			last_N3_value = col_values[3]
			temp3["N" + "3"] = {last_N3_value:[last_N3_value]}
			data["N0"][last_N0_value][1]["N1"][last_N1_value][1]["N2"][last_N2_value].append(temp3)
	#data["N"+N_depth] = col_value
	#{ "N0": { "punch (left jab)": ["punch (left jab)", { "N1": { "punch (quick left jab)": ["punch (quick left jab)", { "N2": { "N0.punch": ["N0.punch"] } },
	#																												 { "N2": { "kick (high left kick)": ["kick (high left kick)"] } }] } }] } }


# json_data = dictionary for the first/next layer of N , which leads to a list of move names, which act as a dictionary key
# its value is a array that contain all its relevant details ex. index(0) = name and index(-1)
