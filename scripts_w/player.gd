extends CharacterBody2D

@onready var input_handler: Input_Handler = %Input_Handler
@onready var data_extractor : Data_Extractor = %Data_Extractor
@onready var data_handler : Data_Handler = %Data_Handler
@onready var executer : Executer = %Executer

func _ready() -> void:
	init()

func init() -> void:
	data_handler.HandleData(data_extractor.ExtractData())
	#print(data_handler.DataFilter("id", "p2",["mid_air"]))

func _process(delta: float) -> void:
	UpdateSubNodes(delta)

func UpdateSubNodes(delta: float):
	input_handler.Update(delta)

func _physics_process(delta: float) -> void:
	PhysicsUpdateSubNodes(delta)

func PhysicsUpdateSubNodes(delta:float):
	input_handler.PhysicsUpdate(delta)
