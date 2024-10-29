extends Label

class_name Stomach

var content: Array = [] #array of items to be broken down
var gas_volume: float = 0
var capacity: float = 2000 #maximum stomach volume
var volume: float = 0 #current stomach volume
var breakdown_rate: float = 0.03 #baseline percent of item breakdown per minute
var empty_rate: float = 0.03 #percent of chyme volume per min
var digestion_strength: float = 1 #maximum item toughness that can be brokendown
var chyme = Chyme.new()
var output: Object #Where to empty stomach contents.

func add_item(item: Item):
    volume += item.volume
    content.append(item)

func output_chyme(new_chyme: Chyme):
    output.input_chyme(new_chyme)

func digest(delta: float) -> void:
    #Start breaking down stomach contents
    for i in content.size():
        var item = content[i]
        
        if item.digestibility < digestion_strength:
            var r: float = pow(3 * item.volume / (4 * PI), 1/3)
            # Calculate the Surface Area to Volume Ratio (SA/V ratio)
            var SA_V_ratio: float = 3 / r
            # volume of the item that is converted into chyme per minute
            var breakdown_volume = min(item.volume * (breakdown_rate * delta * (SA_V_ratio/item.digestibility)), item.volume)
            item.volume = item.volume - breakdown_volume
            
            # volume after converting broken down material to chyme density while retaining mass. 
            # Items less dense than water should shrink, while denser expand due to the addition of gastric juice.
            # Feature: added water volume could be taken from the system that manages hydration. Though it's all reabsorbed.
            var breakdown_chyme_volume = (breakdown_volume * item.density) / chyme.density
            var water_volume = breakdown_volume * item.water_content + (breakdown_chyme_volume - breakdown_volume)
            var solid_volume = breakdown_chyme_volume - water_volume
            chyme.solid_volume += solid_volume
            chyme.water_volume += water_volume
            chyme.kcal += ((breakdown_volume / 100) * item.density) * item.caloric_density
            volume = item.volume + chyme.volume()
            #remove the item after fully broken down
            if item.volume <= 0:
                content.remove_at(i)
                item.queue_free()

func peristalsis(delta: float, ) -> void:
    delta = delta / 60
    # Chyme is input to the small intestine from the  The rate of emptying follows an exponential curve empyting around 3% of the chyme volume per minute. 
    # The percentage of chyme emptied per minute is adjusted by the caloric density of chyme, decreasing the percentage the more kcal rich the chyme is.
    # Problem: water volume in excess of the typical water content of chyme should take priortiy and ignore the caloric rate. 
    
    var chyme_output = Chyme.new()
    # alter emtpy rate based on caloric density, no idea if this math works out https://pubmed.ncbi.nlm.nih.gov/4054524/
    # var caloric_rate =  0.1 + 0.0024 * chyme.volume() + 0.96 * chyme.energy_density() # This doesn't work as expected
    # volume based exponetial emptying + base caloric rate. I feel like the two should be combined a little more intelligently
    var output_volume = chyme.volume() * (empty_rate * delta)
    chyme_output.solid_volume = output_volume * (chyme.solid_volume / chyme.volume())
    chyme_output.water_volume = output_volume * (chyme.water_volume / chyme.volume())
    chyme_output.kcal = output_volume * chyme.energy_density()
    chyme.kcal -= chyme_output.kcal
    chyme.solid_volume -= chyme_output.solid_volume
    chyme.water_volume -= chyme_output.water_volume
    output_chyme(chyme_output)
