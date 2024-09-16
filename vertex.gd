extends Node2D


class_name Vertex


@export var neighbors: Array[Vertex]

var cost_dict: Dictionary # key: Vertex, value: cost (float)


# computes cost from this vertex to each other
# connected vertex in graph
# stores costs in `cost_dict`
func dfs() -> void:
	
	var searched: Array[Vertex] = []
	var stack: Array[Vertex] = [self]
	
	cost_dict[self] = 0.0
	
	while not stack.is_empty():
		var cur: Vertex = stack.pop_front()
		
		for neighbor in cur.neighbors:
			
			# add unsearched vertices to stack
			if not searched.has(neighbor):
				stack.push_front(neighbor)
			
			# compute cost
			var temp_cost = cost_dict[cur] + sqrt(
				((cur.position.x - neighbor.position.x) ** 2) + \
				((cur.position.y - neighbor.position.y) ** 2)
			)
			
			# update cost
			if not cost_dict.keys().has(neighbor) or \
					cost_dict[neighbor] > temp_cost:
				cost_dict[neighbor] = temp_cost
		
		searched.push_back(cur)


func get_nearest_five() -> Array[Vertex]:
	
	cost_dict.clear()
	dfs()
	
	var result: Array[Vertex] = []
	
	for v in cost_dict.keys():
		if v == self:
			continue
		insert_if_nearest_x(result, v, 5)
	
	return result


func insert_if_nearest_x(arr: Array[Vertex], v: Vertex, total: int) -> void:
	
	if arr.size() < total:
		arr.push_back(v)
	
	else:
		for i in arr.size():
			if cost_dict[v] < cost_dict[arr[i]]:
				arr.remove_at(i)
				arr.push_back(v)
				break
