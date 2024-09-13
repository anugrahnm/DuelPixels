extends CharacterBody2D

@onready var input_handler: Input_Handler = %Input_Handler
@onready var data_handler : Data_Handler = %Data_Handler
@onready var output_handler : Output_Handler = %Output_Handler
@onready var stat_handler : Stat_Handler = %Stat_Handler

var key_inputs : Array = []
var empty_template_for_move : Dictionary = {"id":"p1", "next_possible_combo_list":["j2","p1","k1"], "animation_duration":"", "animation_early_window":"", "animation_speed":""}
var current_move : Dictionary
var unfiltered_next_possible_move : Array 
var filtered_next_possible_move : Array
var restricted_input : Array = []
var apply_gravity : bool
var combo_tracker : Array = []

func _ready() -> void:
	init()

func init() -> void:
	current_move = empty_template_for_move
	data_handler.HandleData(data_handler.ExtractData())

func GetAllVariablesInPlayer():
	#Copy-Pasted from reddit user u/kleonc
	var thisScript: GDScript = get_script()
	print('Properties of "%s":' % [ thisScript.resource_path ])
	for propertyInfo in thisScript.get_script_property_list():
		if "_handler" in propertyInfo.name or "player.gd" in propertyInfo.name: 
			continue
		var propertyName: String = propertyInfo.name
		var propertyValue = get(propertyName)
		print(' %s = %s' % [ propertyName, propertyValue ])

func ProcessClearUpVariables() -> void:
	restricted_input = []
	unfiltered_next_possible_move = [] 
	filtered_next_possible_move = []

func PhysicsProcessClearUpVariables() -> void:
	key_inputs = []

func _process(delta: float) -> void:
	ProcessSubNodes(delta)
	ProcessClearUpVariables()

func _physics_process(delta: float) -> void:
	PhysicsProcessSubNodes(delta)
	PhysicsProcessClearUpVariables()

func ProcessSubNodes(delta: float) -> void:
	data_handler.Process(delta)
	stat_handler.Process(delta)
	input_handler.Process(delta)
	output_handler.Process(delta)

func PhysicsProcessSubNodes(delta: float) -> void:
	output_handler.PhysicsProcess(delta)

### D_H > data from the orginal after extraction is the unfiltered with addition of dictionary key and value of "combo_break" : bool.
### S_H > unfiltered will eleminate all the needless data so that every user possible input will either have one or no matching class.
### I_H > filtered will also be reformated to just the info that will be essential for O_H.
#data = {"id":"p1","class":"punch","name":"jab","next_possible_move":["j1","k1"]}
#unfiltered = [{"id":"j1","class":"jump" ,"name":"simple jump"}, "next_possible_move":["j2","p2","k3"], "combo_breaker":"false"]
#filtered = [{"jump":"j2","combo_breaker":"false"},{"heavy":"h1","combo_breaker":"true"}]
#
###when a the character is in middle of the previous move's animation 
#>If the next input is too early, it will be denied, 
#	but this does not reset the current combo, the key is just straight up ignored. 
#>If the next input is in the early key input window,
#	then the move is registered just as if the previous animation is done, 
#	but the execution will be only done after the previous animation is completed, every input inbetween is ignored.
#	This also means that the move in queue also has the same ability to make or break a combo
#	
###For this, the animtaion time has to be calculated and the information has to be stored along with the move name in the current_move
#	current_name = {"name":"p1", "animation_duration":"x", "animation_early_window":"x-y", "animation_time_passed":"+delta", "animation_speed":"z"}
#	If animtion_time_passed >= early_window: player next_move = {same format, except that animation_time_passed has not started ticking
#	so the first thing that denies whether or not a key will be condsidered in I_H is whether or not next_move is empty.
#
###Algorithm for filtering unfiltered_next_possible_move
#	remove the moves that needs more stamina than what the user currently has, moves also can not need stamina
#	jump priority : mountable surfaces if nearby > continue combo > normal jump if not mid air
#	goes through the min and max enemy criteria
#	if there are two more possible keys in a class, the one that is not going to be a combo_breaker is prioritiesed
#	
###Enemy_Handler implementation
#	When enemy triggers collsion, the E_H waits for the D_H and S_H ticks to be completed
#	E_H takes the information of player health, armour, iFrams and other damage taken relevent stat into consideration
#	changes the player health accordingly,
#	if the current player animation is interruptable by the current enemy collision factors, updates player interupted status
#	for the interuption, the relavant O_H animation, sound, effects and movement is updated and the combo_list and current_move is emptied
#	in I_H, unless there is a key that is higher priotrity than being interupted, all player inputs are denied
#	O_H executes the interuption output.
#
