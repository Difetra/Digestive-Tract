extends Control

var stomach: Object = null
var intestines: Array = []
var metabolism: Object = null
var config = {
	segments = 5,
	transit_time = 720 # minutes to reach the other end .
}
#consider adjusting transit time based on number of kcal in segment relative to volume. More kcal = longer to digest.

func create_intestines(num_seg):
	var last_seg = stomach
	var intestines = []
	for i in range(num_seg):
		var new_seg = Intestine.new()
		new_seg.input = last_seg
		last_seg.output = new_seg
		intestines.append(new_seg)
	return 
	

# Called when the node enters the scene tree for the first tyeaime.
func _ready():
	stomach  = Stomach.new()
	intestines = create_intestines(config.segments)
	metabolism = Metabolism.new()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	intestines[intestines.size()]
		
