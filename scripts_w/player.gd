extends CharacterBody2D

@onready var input_handler: Input_Handler = %Input_Handler
@onready var data_extractor : Data_Extractor = %Data_Extractor
@onready var data_handler : Data_Handler = %Data_Handler
@onready var executer : Executer = %Executer

var key_inputs = []

func _ready() -> void:
	init()

func init() -> void:
	data_handler.HandleData(data_extractor.ExtractData())
	print(data_handler.DataFilter("id","j2",["next_possible_move"]))

func ShowNextPossibleMoveOfId(id):
	return data_handler.DataFilter("id",id,["next_possible_move"],true)[0][0]

func _process(delta: float) -> void:
	ProcessSubNodes(delta)

func ProcessSubNodes(delta: float):
	input_handler.Process(delta)
	executer.PhysicsProcess(delta,key_inputs)

func _physics_process(delta: float) -> void:
	PhysicsProcessSubNodes(delta)

func PhysicsProcessSubNodes(delta:float):
	input_handler.PhysicsProcess(delta)
