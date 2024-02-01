extends Label

class_name Bladder

var volume: float = 0 # current bladder volume.
var critical_capacity: float = 4000 # ml of urine before medical consequences. 
var capacity: float = 1000 # ml of urine before being forced to void. 
var flow_rate: float = 18 #ml/s expelled from the bladder. Typical rates: Men(10-21)ml/s  Women(15-18)ml/s
# in the context of gameplay when capacity is reached a character would be on the verge of loosing control. There may be ways to push past that limit with other game mechanics. 
# critcal_capacity could only be reached with a physical blockage like a plug, and perhaps some kind of drug that sets capacity beyond or at critical. What happens when this is reached or what it should be set at I'm not certain.
var holding: bool = true # whether the bladder is holding or voiding.
var time_scale: float = 1

func add(v: float) -> void:
    volume += v

func release() -> void:
    holding = false

func hold() -> void:
    holding = true

# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.




# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    if volume > capacity:
        release()
    if holding == false:
        # void
        volume -= flow_rate * delta
    text = str(volume) + "/" + str(capacity)
