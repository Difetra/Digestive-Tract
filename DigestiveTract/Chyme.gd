extends Node

class_name Chyme

# Although mass may be more intuitive for some measurements I want to keep it consistent.
@export var kcal: float = 0
@export var solid_volume: float = 0 # volume of solid material
@export var water_volume: float = 0 # volume of water
@export var undigestible_volume: float = 0 # Fiber and other material that create stool bulk
@export var biovolume: float = 0 # bacterial biomass, protien, lipids added throughout digestion.
@export var density: float = 970 # (kg/m^3) assume a default density for now. 

func water_ratio() -> void:
    pass
    
func volume() -> float:
    return solid_volume + water_volume
    
func energy_density() -> float:
    if kcal == 0 or volume() == 0:
        return 0
    else:
        return kcal/volume()
