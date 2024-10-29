extends Node

class_name Item

var item_name: String = ""
var volume: float = 1000 #cm^3 (ml)
var density: float = 977 #kg/m^3
var caloric_density: float = 5 #kcal/g
var digestibility: float =  0.2 #how easily is the item broken down into chyme. 1 is instant, 0 never.
var water_content: float = 0.1 #percentage of volume made up of water
var integrity: float = 1 #how much of the item remains intact. Breakdown rate increases as integrity lowers simulating additional surface exposed by digestive processes.

func weight() -> float:
    var vol_m = volume / 100
    return vol_m * density

#Include an event to signal when digested? Would be used for special behaviors that temporarily alter properties, diaretics, drugs, etc. Might be suitable for a Metabolism class. 
