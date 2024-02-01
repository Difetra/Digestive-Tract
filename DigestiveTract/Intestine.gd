extends Node

class_name Intestine


var resolution: float = 8 # resolution of simulation
var length:float = 498 # cm
var max_diameter:float = 4 # cm
var caloric_rate:float = 0.6 # kcal/min per meter
var motility:float = 120 # minutes to traverse the small intestine 

var segments:Array
var peristalsis_timer:float
var metabolism: Metabolism
var input:Object
var output:Object

func create_intestine() -> void:
    var last_seg = input
    var absorb_rate = (length/resolution)/100 * caloric_rate
    for i in range(resolution):
        var new_seg = Intestine_Segment.new()
        if last_seg:
            new_seg.input = last_seg
            last_seg.output = new_seg
        new_seg.capacity = PI * sqrt(max_diameter) * (length/resolution)
        new_seg.length = length/resolution
        new_seg.caloric_rate = absorb_rate
        add_child(new_seg)
        last_seg = new_seg
        segments.append(new_seg)
        
func peristalsis(delta: float) -> void:
    # travel functions as peristaltic waves, each wave moves the content of one segment to the next.
    # to control the travel time these waves occur at intervals. (motility / segments)
    delta = delta / 60
    peristalsis_timer += delta
    if peristalsis_timer <= motility:
        peristalsis_timer = 0
         # move contents of each segment to the next input in reverse order
        for i in range(resolution-1):
            var segment = segments[-i-1]
            if segment.volume() > 0:
                segment.input_chyme(segments[-i])
    pass  
    
func digest(delta: float) -> void:
    for i in range(resolution):
        var absorbed = segments[i].digest(delta)
        metabolism.water += absorbed.water_volume
        metabolism.energy += absorbed.kcal
        
        
func _init(config:Dictionary):
    resolution = config.resolution
    length = config.length
    max_diameter = config.max_diameter
    caloric_rate = config.caloric_rate
    motility = config.motility
    peristalsis_timer = motility
    
func _ready():
    create_intestine()
