extends Control

@export var stomach: Stomach
@export var small_intestine: Intestine
@export var large_intestine: Intestine
@export var metabolism: Metabolism
@export var abdominal_capacity: float = 0 # unused for now
@export var time_scale: float = 10 # multiplier for real-time calculations

var config_small = {
    resolution = 8, # resolution of simulation
    length = 498, # cm
    max_diameter = 4, # cm
    caloric_rate = 0.6, # kcal/min per meter
    motility = 120, # minutes to traverse the small intestine 
}
var config_large = {
    resolution = 4, #resolution of simulatio22n
    length = 166, # cm
    max_diameter = 12, # cm
    caloric_rate = 0.1, # placeholder value, not researched.
    motility = 1440, # traversal time can vary significantly. Subject to further research and variables.
} 

# Called when the node enters the scene tree for the first time.
func _ready():
    stomach  = Stomach.new()
    small_intestine = Intestine.new(config_small)
    small_intestine.position = stomach.position + Vector2(0, stomach.size.y)
    large_intestine = Intestine.new(config_large)
    
    stomach.name = "stomach"
    small_intestine.name = "small intestine"
    large_intestine.name = "large intestine"
    
    
    add_child(stomach)
    add_child(small_intestine)
    add_child(large_intestine)
    
    small_intestine.input = stomach
    large_intestine.input = small_intestine
    
    stomach.output = small_intestine.segments[0]
    small_intestine.output = large_intestine.segments[0]
    
    metabolism = Metabolism.new()
    metabolism.name = "metabolism"
    add_child(metabolism)
    metabolism.time_scale = time_scale
    small_intestine.metabolism = metabolism
    large_intestine.metabolism = metabolism
    
    var item = Item.new()
    item.name = "Test"
    stomach.add_item(item)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    delta = delta * time_scale
    stomach.digest(delta)
    small_intestine.digest(delta)
    large_intestine.digest(delta)
    stomach.peristalsis(delta)
    small_intestine.peristalsis(delta)
    large_intestine.peristalsis(delta)
    #print("stomach_volume: %10d" % stomach.volume)
    #print("item volume: %10d" % stomach.content[0].volume)
    #print("Stomach_chyme: %10d" % stomach.chyme.volume())
    #print("Duodenum: %10d" % small_intestine.segments[0].chyme.volume())
    #print("Metabolism_E: %10d" % metabolism.energy)
    #print("metabolism_W: %10d" % metabolism.water)
    #print("Bladder_volume: %10d" % metabolism.bladder.volume)
