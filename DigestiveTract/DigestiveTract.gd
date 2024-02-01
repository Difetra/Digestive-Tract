extends Control

var stomach: Stomach
var small_intestine: Intestine
var large_intestine: Intestine
var metabolism: Object
var abdominal_capacity: float = 0 # unused for now
var time_scale: float = 10 # multiplier for real-time calculations

var config_small = {
    segments = 8, # resolution of simulation
    length = 498, # cm
    max_diameter = 4, # cm
    caloric_rate = 0.6, # kcal/min per meter
    motility = 120, # minutes to traverse the small intestine 
}
var config_large = {
    segments = 4, #resolution of simulation
    length = 166, # cm
    max_diameter = 12, # cm
    caloric_rate = 0.1, # placeholder value, not researched.
    motility = 1440, # traversal time can vary significantly. Subject to further research and variables.
} 

# Called when the node enters the scene tree for the first time.
func _ready():
    stomach  = Stomach.new()
    small_intestine = Intestine.new(config_small)
    large_intestine = Intestine.new(config_large)
    
    small_intestine.input = stomach
    large_intestine.input = small_intestine
    
    stomach.output = small_intestine
    small_intestine.output = large_intestine
    
    metabolism = Metabolism.new()
    metabolism.time_scale = time_scale
    
    add_child(stomach)
    add_child(small_intestine)
    add_child(large_intestine)
    add_child(metabolism)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    delta = delta * time_scale
    stomach.digest(delta)
    small_intestine.digest(delta)
    large_intestine.digest(delta)
    stomach.peristalsis(delta)
    small_intestine.peristalsis(delta)
    large_intestine.peristalsis(delta)
