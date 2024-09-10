extends CharacterBody2D

@onready var input_handler: Input_Handler = %Input_Handler
@onready var data_handler : Data_Handler = %Data_Handler
@onready var output_handler : Output_Handler = %Output_Handler

var key_inputs : Array = []

func _ready() -> void:
	init()

func init() -> void:
	data_handler.HandleData(data_handler.ExtractData())

func UpdateDebugText(i) -> void:
	output_handler.UpdateDebugText(i)

func ShowNextPossibleMoveOfId(id) -> Array:
	return data_handler.DataFilter("id",id,["next_possible_move"])[0][0]

func _process(delta: float) -> void:
	ProcessSubNodes(delta)

func _physics_process(delta: float) -> void:
	PhysicsProcessSubNodes(delta)

func ProcessSubNodes(delta: float) -> void:
	output_handler.PhysicsProcess(delta,key_inputs)

func PhysicsProcessSubNodes(delta:float) -> void:
	input_handler.PhysicsProcess(delta)
	output_handler.PhysicsProcess(delta,key_inputs)
	key_inputs = []
