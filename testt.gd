
water_volume = 1500
kcal = 1500

liquid_empty_volume = (water_volume * 0.2) * (kcal < 1000 and 1 or 1000 / kcal)
print(liquid_empty_volume)


water_volume = 1500
kcal = 1500

liquid_empty_volume = (kcal < 1000 and 1 or 1000 / kcal)
print(liquid_empty_volume)
