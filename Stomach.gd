extends Label

class_name Stomach

var content: Array = [] #array of items to be broken down
var gas_volume: float = 0
var capacity: float = 2000 #maximum stomach volume
var volume: float = 0 #current stomach volume
var breakdown_rate: float = 0.1 #rate of item breakdown into chyme
var empty_rate: float = 10 #ml/minute may be affected by liquid content and caloric density
var liquid_empty_mult: float = 2 #multiplier to empty rate for liquids. 
var digestion_strength: float = 0.5 #maximum item toughness that can be brokendown
var chyme = Chyme.new()
var output: Object = null #Where to empty stomach contents.

func add_item(item: Item):
	volume += item.volume
	content.append(item)

func output_chyme(new_chyme: Chyme):
	output.input_chyme(new_chyme)

func digest() -> void:
	#Start breaking down stomach contents
	for i in content.size():
		var item = content[i]
		
		if item.toughness < digestion_strength:
			var breakdown_volume = item.volume - (item.volume*item.toughness) * item.integrity
			item.integrity = max(0, item.integrity - breakdown_rate)
			item.volume = item.volume - breakdown_volume
			
			#volume after converting broken down material to preset chyme density while retaining mass. Items less dense then water should shrink, while denser technically expand?
			var breakdown_chyme_volume = (breakdown_volume * item.density) / chyme.density
			var water_volume = breakdown_chyme_volume * item.fluid_content
			var solid_volume = breakdown_chyme_volume - water_volume
			chyme.solid_volume = solid_volume
			chyme.water_volume = water_volume
			chyme.kcal = ((breakdown_volume / 100) * item.density) * item.caloric_density
			#remove the item after fully broken down
			if item.volume <= 0:
				content.remove(i)
				item.queue_free()
	#Start emptying Chyme from stomach to intestines
	
	# Should check if either volume is 0 and avoid processing that part or figure it into the math.
	var output_chyme = Chyme.new()
	output_chyme.solid_volume = min(chyme.solid_volume, empty_rate) #use empty rate or remaining volume.
	output_chyme.liquid_volume = min(chyme.water_volume, empty_rate + empty_rate * (chyme.solid_volume / (capacity/liquid_empty_mult)))
	output_chyme.kcal = (output_chyme.sold_volume / chyme.solid_volume) * chyme.kcal
	chyme.kcal = chyme.kcal - output_chyme.kcal
	chyme.solid_volume -= output_chyme.solid_volume
	chyme.liquid_volume -= output_chyme.liquid_volume
	output_chyme(output_chyme)

