extends Node2D


@onready var v1: Vertex = $Vertex


func _ready() -> void:
	var nearest_five = v1.get_nearest_five()
	
	print("All Vertices and Costs:")
	for v in v1.cost_dict.keys():
		print(v.name + " : " + str(v1.cost_dict[v]))
	
	print("\nNearest Five: ")
	for v in nearest_five:
		print(v.name)
