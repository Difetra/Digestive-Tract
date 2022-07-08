## Stomach

Accepts [items](#Item) and breaks them down into [chyme](#Chyme). Chyme is steadily transferred to the [intestines](#Intestine) for further digestion. Indigestible items small enough to pass through the stomach will also be passed along to the intestines in time. Items too big to pass will remain until thrown up.

### Properties

| Name               | Description                                                  | Type   |
| ------------------ | ------------------------------------------------------------ | ------ |
| content            | array of [Items](#Item) to be broken down in the stomach    | array  |
| volume             | current stomach volume                                       | float  |
| capacity           | maximum volume of the stomach before becoming sick           | float  |
| breakdown_rate     | rate of item breakdown into chyme                            | float  |
| empty_rate         | mL/minute may be affected by liquid content and caloric density | float  |
| liquid_empty_mult  | multiplier to empty_rate for liquids                         | float  |
| digestion_strength | maximum [item](#Item) toughness that can be broken down     | float  |
| chyme              | the stomach's [chyme](#Chyme) object                        | object |
| output             | Object [chyme](#Chyme) contents and [items](#Item) are transferred to. In most cases the [intestines](#Intestine) |        |
| gas_volume         | volume of gas in the stomach - not currently used.           | float  |



## Item

An object with digestive and physical properties that determine how the item will be broken down. Items can be consumed whole or in part. When partially consumed a copy of the item is made with the volume substracted from the original. The copied item is then consumed.

### properties

| Name            | Description                                                  | type   |
| --------------- | ------------------------------------------------------------ | ------ |
| item_name       | Name of the item                                             | string |
| volume          | Physical volume of the item as cm^3 (ml)                     | float  |
| density         | Physical density of the item as Kg/m^3                       | float  |
| caloric_density | Kcal per gram                                                | float  |
| toughness*      | determines how quickly an item is broken down when below stomach digestion_strength | float  |
| water_content*  | volumetric water content as a percentage (0-1)               | float  |
| integrity*      | percentage of object not broken down.                        | float  |

These properties were chosen for ease of scaling for portions of food to volume. A liter of soup can be measured out and consumed while only changing the volume.

- Toughness - toughness isn't based on any real physical property. It serves both as a threshold for what is indigestible and a multiplier to the rate of breakdown in the stomach. A standard range will need to be defined for digestibility. 0.5 is the baseline threshold for digestible items as of now. 
- water_content - Part of me would like to keep the system of measurement for ratio consistent. gravimetric water content may be more consistent. Still thinking about how that might affect different interactions (like an item that could absorb water and expand in the stomach). 
- integrity - The rate of item breakdown increases as integrity lowers simulating additional surface area exposed by the digestive process. Not strictly a necessary number, but it adds a bit of additional realism in nicely fudgeable way and another way to balance how digestion works. 

## Chyme

The digestive soup items a broken down into. Any unique properties of the original item are reduced down to the properties of Chyme.

### Properties

 

| Name          | Description                        | Type  |
| ------------- | ---------------------------------- | ----- |
| kcal          | kcal content of the chyme          | float |
| solid_volume* | volume of solid matter in mL       | float |
| water_volume  | volume of water content in mL      | float |
| density*      | kg/m^3 (970 typical chyme density) | float |

- solid_volume - I'm rethinking how chyme volume works. I'm thinking instead having a single `volume` property and a property for indigestible material (like fiber). Need to think about how that works with kcal and water absorption.
- density - Chyme in my reading tends to be  of a somewhat consistent density thanks to digestive fluids and the way the stomach contents breakdown. Although I think with this model if a considerably dense item was broken down there could be a drastic increases in volume. Not an issue for most actually edible things I don't think. On the flip side something with a very low density like a cheese puff would be appropriately reduced in volume.  

## Intestine

Where food is absorbed as it is transported through the digestive tract. The intestines are made up of intestine objects linked together by input and output. Each intestine segment works to digest [chyme](#Chyme) absorbing both liquid and kcals. Intestines may also pass [items](#Item) which are most often indigestible. Each segment has a maximum volume which can be occupied by both chyme and items. 

### properties

| Name        | Description                                             | Type   |
| ----------- | ------------------------------------------------------- | ------ |
| capacity    | maximum segment volume                                  | float  |
| absorb_rate | kcal/min absorbed by a segment                          | float  |
| efficiency* | proportion of solid volume absorbed per kcal            | float  |
| motility*   | mL/min of material moved through a segment?             | float  |
| chyme       | Intestine segment's [chyme](#Chyme) object             | Object |
| contents    | Array of [items](#Item) occupying the segment          | Array  |
| input       | The [stomach](#Stomach) or preceding intestine segment | Object |
| output      | The next Intestine segment or anus                      | Object |
| gas_volume  | volume of gas in the segment - unused                   | float  |

- efficiency - I'm not a fan of this method of absorbing solid volume. It feels entirely too arbitrary.
- motility - I think this has something to do with a peristalsis function I was adding. It certainly has something to do with the rate material moves through the intestines, but it's currently unused.



## Digestive Tract

Controller to initialize the stomach, intestines, and metabolism 

## Metabolism

Collects and allocates nutrients(kcal) and water absorbed from the intestines. May also handle chemical and drug reactions, keeping a base reference and modifying attributes for a time. 

Currently handles filling the bladder from absorbed water. Attempting to do so in a way that approximates real world excretion rate of the kidneys based on hydration.   

## Bladder

Holds urine added by the [metabolism](#Metabolism) and handles functions related to the holding and release of urine.

### properties

| Name              | Description                             | Type  |
| ----------------- | --------------------------------------- | ----- |
| volume            | mL of urine held within the bladder     | float |
| capacity          | mL of urine before being forced to void | float |
| critical_capacity | mL of urine before medical consequences | float |
| flow_rate         | mL/s expelled from the bladder          | float |
| holding           | Is the bladder holding or voiding       | bool  |

## Additional Notes

- Adding indigestible fiber as a property of food to affect stool bulk. Could either be a made a property of chyme or broken down into it's own entity to travel like other indigestible objects.
	- In practice fiber would be more closely linked to the behavior of chyme and travel with it as such.
	- Using indigestible matter as a property of chyme to determine what will remain as stool may make more sense than the current approach which is somewhat arbitrary.
- Chyme is handled as fluid mass able to gradually move through the intestines. Swallowed indigestible objects small enough move through the intestines as a whole. One edge case that is missing is indigestible fluids that would not move as a whole. Unifying how fluids move would lend some flexibility with what I can do. 
	- Following that line of thought creating standards for the movement of fluids, solids, and gases would make sense. 
	- fluids - volume of fluid can gradually shift through the system and around solids
	- solids - an object that moves as a whole. 
	- gas - similar to an indigestible fluids with a very low density. In fact, it might make sense to treat them the same. 
- Hydration may need to be tracked to curtail some undesirable effects of adding digestive fluids to reach appropriate chyme density. A buffer between absorption of water and the bladder would make sense and pulling from that buffer for digestive fluid would help. The exponential way the bladder fills from hydration should allow for a general baseline of hydration to be available . 

## MORE Notes

### Digestion

As kcals are absorbed a proportional solid volume is reduced. Minimum volume is dictated by undigestible_mass  which also holds onto a minimum water content based on the proportion of undigestible_mass to lets say bacterial biomass. 

along the way bacterial biomass is added as volume of solid material is absorbed.

 ### Absorption

water absorption rate in small bowel - 0.035mL/min per cm of bowel or 2.6-7.2mL/cm/hr

large intestine can absorb as much as 5 liters of water a day

### Fecal Facts

- average fecal density - 1.06 g/ml

- average composition of mass- 75% water, solids - 25-54% bacteria biomass, 2-25% protien, 25% fiber, 2-15% undigested lipids

- water mass varies with fiber intake (63-86%)

- transit time increases with higher total water mass.

	 
