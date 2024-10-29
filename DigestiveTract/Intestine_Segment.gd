extends Label

class_name Intestine_Segment

# Should be determined by length/segments
@export var capacity: float = 200 #ml maximum segment volume, may be exceeded causing pain and potentially rupture. 
@export var length: float = 100 #cm length of segment 
@export var caloric_rate: float = 5.8 #kcal/min
@export var water_absorb_rate: float = 6.25 # ml/min base rate
@export var effeciency: float = 0.8 #proportion of solid volume absorbed per kcal. 
@export var motility: float = 144 #minutes... mL/minute? interval? what do
@export var chyme: Chyme = Chyme.new() #digestive matter
@export var contents: Array = [] #item contents of segment
@export var gas_volume: float = 0
@export var input: Node #stomach or previous segment
@export var output: Node #intestine or anus?

func content_volume() -> float:
    var total_volume = 0
    for item in contents:
        total_volume += item.volume
    return total_volume

func volume() -> float:
    return chyme.volume() + content_volume() + gas_volume

func add_item(item: Item) -> void:
    pass

#full_segs(optional) - number of previous segments found to be full
func input_chyme(chyme_input: Chyme, full_segs: float = 0) -> void:
    full_segs = full_segs or 0
    var o_capacity = capacity + (full_segs * (capacity * 0.1)) #amount allowed over capacity based on preceding full segements
    var chyme_volume = chyme_input.solid_volume + chyme_input.water_volume
    var excess =  o_capacity - (volume() + chyme_volume)
    if o_capacity > excess:
        #print("new_solid: ", chyme.solid_volume)
        #print("new_water:", chyme.water_volume)
        chyme.solid_volume += chyme_input.solid_volume
        chyme.water_volume += chyme_input.water_volume
        chyme.kcal += chyme_input.kcal
    else:
        #push excess to next segment
        var within_capacity = chyme_volume - excess 
        var ratio = chyme_input.water_volume / chyme_input.solid_volume
        var solid_volume = within_capacity / ratio
        var water_volume = within_capacity - solid_volume
        
        chyme.solid_volume += solid_volume
        chyme.water_volume += water_volume
        chyme.kcal += chyme_input.kcal/(chyme_volume/within_capacity)
        if output:
            var chyme_overflow = Chyme.new()
            chyme_overflow.solid_volume = chyme_input.solid_volume - solid_volume
            chyme_overflow.water_volume = chyme_input.water_volume
            chyme_overflow.kcal = chyme_input.kcal/(chyme_volume/excess)
            output.input_chyme(chyme_overflow, full_segs + 1)
       
func digest(delta: float) -> Dictionary:
    delta = delta / 60
    # The rate of chyme absorption starts at a fixed caloric_rate per segment, but increases proportionally to the surfaces area of the segment as the volume increases. Caps out at 2 times the base rate.
    # Solid volume is reduced proportional to the kcal absorbed
    # water absorption ammount decreases as the ratio of solids to water increases. Research on some practical values required.
    # one figure shows 30% of the volume entering the large intestine remaining by the time it reaches the rectum. 
    if chyme.kcal > 0:
        var absorb_kcal = caloric_rate * delta   
        var absorb_solid = (absorb_kcal / chyme.kcal) * chyme.solid_volume
        # Water absorption increases as the water content does.
        # TO DO: water absorption should exponentially decrease below a certain ratio. Fiber content should increase that threshhold.
        var absorb_water = water_absorb_rate * Math.s_div(chyme.water_volume, chyme.solid_volume) * delta
        chyme.solid_volume -= absorb_solid
        chyme.water_volume -= absorb_water
        chyme.kcal -= absorb_kcal 
        return {solid_volume = absorb_solid, water_volume = absorb_water, kcal = absorb_kcal}
    else:
        return {solid_volume = 0, water_volume = 0, kcal = 0}
