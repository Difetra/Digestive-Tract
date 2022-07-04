extends Label

class_name Intestine

var capacity: float = 200 #maximum segment volume, may be exceeded causing pain and potentially rupture. 
var absorb_rate: float = 5.8 #kcal/min
var effeciency: float = 0.8 #proportion of solid volume absorbed per kcal. 
var motility: float = 20 #ml per fuck it 
var chyme: Chyme = Chyme.new() #digestive matter
var contents: Array = [] #item contents of segment
var gas_volume: float = 0
var input: Object = null #stomach or previous segment
var output: Object = null #intestine or anus?

func content_volume() -> float:
	var total_volume = 0
	for item in contents:
		total_volume += item.volume
	return total_volume

func volume() -> float:
	var chyme_volume = chyme.solid_volume + chyme.water_volume
	return chyme_volume + content_volume() + gas_volume

func add_item(item: Item) -> void:
	pass

#full_segs(optional) - number of previous segments found to be full
func input_chyme(new_chyme: Chyme, full_segs: int):
	full_segs = full_segs or 0
	var o_capacity = capacity + (full_segs * (capacity * 0.1)) #amount allowed over capacity based on preceding full segements
	var chyme_volume = new_chyme.solid_volume + new_chyme.liquid_volume
	var excess =  (volume() + chyme_volume) - o_capacity
	if excess > o_capacity:
		chyme.solid_volume += new_chyme.solid_volume
		chyme.water_volume += new_chyme.liquid_volume
		chyme.kcal += new_chyme.kcal
	else:
		#push excess to next segment
		var within_capacity = chyme_volume - excess 
		var ratio = new_chyme.liquid_volume/new_chyme.solid_volume
		var solid_volume = within_capacity/ratio
		var liquid_volume = within_capacity - solid_volume
		
		chyme.solid_volume += solid_volume
		chyme.liquid_volume += liquid_volume
		chyme.kcal += new_chyme.kcal/(chyme_volume/within_capacity)
		if output:
			new_chyme.solid_volume = new_chyme.solid_volume - solid_volume
			new_chyme.liquid_volume = new_chyme.liquid_volume
			new_chyme.kcal = new_chyme.kcal/(chyme_volume/excess)
			output.input_chyme(new_chyme, full_segs + 1)

func digest() -> Dictionary:
	# Solid volume is reduced as kcal is absorbed. When kcal is depleted remaining solid volume is passed along unabsorbed.
	# solid absorption depends on digestion efficiency.
	# water absorption ammount decreases as the ratio of solids to water increases. Helps avoid making a desert in your intestines.
	
	#absorption stage
	var absorb_solid = absorb_rate * effeciency
	var absorb_liquid = chyme.liquid_volume/chyme.solid_volume # A basic urinary system will go on to process liquids into the bladder. 
	chyme.solid_volume -= absorb_solid
	chyme.liquid_volume -= absorb_liquid
	chyme.kcal = chyme.kcal - absorb_rate # will have some kind of metabolism to do something with calories one day.
	
	return {"solid": absorb_solid, "liquid": absorb_liquid, "kcal": absorb_rate} 

func peristalsis() -> void:
	var move_chyme = Chyme.new()
	move_chyme.solid_volume = 
	move_chyme.water_volume = 
	move_chyme.kcal = 
	pass
