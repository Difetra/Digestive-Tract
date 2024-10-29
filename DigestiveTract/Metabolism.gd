extends Node

# Collects and allocates nutrients(kcal) and water absorbed from the intestines. May also handle chemical and drug reactions, keeping a base reference and modifying attributes for a time. 

class_name Metabolism

var energy: float = 0 # energy stored from calories absorbed. Passively burned in addition to activity. Excess energy would be stored as fat, but for now it won't really do much.
var water: float = 0 # Water absorbed from the digestive tract. For now it's just a buffer between the intestines and bladder when absorption exceeds excretion.
# The extra water is found in the blood and intracellular fluid compartments distributed throughout the body.
var bladder: Object = null
var excretion_rate: float = 13 # ml/min of urine production at maximimum rate.   
# excretion rate increases the greater the water buffer is until it reaches the excretion rate. What should water need to be to reach that rate? 
# One diuresis study finds after (0.9-1.8 l/h x 3 h) 2.7kg of weight retained after absorption while urine production peaked at 778 ml/h. 
# Around 2-3 Liters perhaps? Finding a chart it looks like the increase is exponetial 
var time_scale: float = 1 

func _ready():
    bladder = Bladder.new()
    bladder.time_scale = time_scale
    add_child(bladder)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    delta = delta / 60 * time_scale
    var ratio = min(1, water/2000) # 2,000ml water 
    var adjusted_excretion = excretion_rate * (1 - pow(1 - ratio, 4)) #quartic easing up to excretion_rate. 
    bladder.add(adjusted_excretion * delta)
    water -= adjusted_excretion * delta
