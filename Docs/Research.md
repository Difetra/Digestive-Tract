# Research

## Stomach

Advances in the physiology of gastric emptying - https://www.ncbi.nlm.nih.gov/pmc/articles/PMC6850045/

---

Effect of meal volume and energy density on the gastric emptying of carbohydrates  - https://pubmed.ncbi.nlm.nih.gov/4054524/

empty rate  after 30-60 min`Caloric rate (kcal/min) = 0.1 + 0.0024 X volume(ml) + 0.96 x energy_density(kcal/ml)`

---

https://academic.oup.com/nutritionreviews/article/73/suppl_2/57/1930269

| Factor         | Effect                                                       |
| -------------- | ------------------------------------------------------------ |
| Volume         | Increased intragastric volume speeds the rate of emptying up to a maximum capacity |
| Energy density | High energy density of beverages reduces emptying rates      |
| Osmolality     | High osmolality of beverages slows emptying rates, but the effect is much less than for energy density |
| Temperature    | Beverage temperature that differs markedly from normothermia has little effect  on gastric emptying as intragastric temperatures rapidly equilibrate |
| pH             | Beverage pH has little effect on emptying rates as buffering capacity is  normally weak, and the type and concentration of salts in beverages are  not sufficient to influence emptying rates |
| Exercise       | Steady-state exercise levels above 70% VO2max and high-intensity intermittent exercise can both slow gastric emptying |

---

The importance of volume in regulating gastric emptying - https://journals.lww.com/acsm-msse/Abstract/1991/03000/The_importance_of_volume_in_regulating_gastric.8.aspx

> the *rate* of gastric emptying (expressed as percentage emptied per unit time) is regulated by the carbohydrate content of the solution but that the *volume* of the solution that is emptied is determined by the gastric volume, which is a function of the drinking pattern

---

https://www.ncbi.nlm.nih.gov/pmc/articles/PMC1392992/

>  When the mean rate of emptying of the gastric contents for the group is plotted against the mean volume of the gastric contents (Fig. 6) the result is a straight line, the slope of which indicates that about 3-3 % of the gastric contents are transferred to the duodenum per minute.

---

https://pubmed.ncbi.nlm.nih.gov/6344757/

> The stomach converts food into fragments and then liquifies it before  emptying it into the duodenum. Gastric emptying of liquid foodstuffs is  so controlled that about 200 kcal/hr are delivered to the duodenum. The  volume of the meal, its energy density (kcal/ml), and the proportions of fat, carbohydrate, and protein in the meal have minor effects on the  rate of gastric emptying of energy. 

An interesting way to look at it even if not necessarily accurate. 

---

### Review

In breaking down this complex process in a way I can simulate I think there's a few important factors to consider.

- Gastric emptying of liquid solutions ingested can be most predictably defined as exponential with total volume having the most impact on rate and energy density a lesser factor in slowing gastric emptying.
- The maximum gastric empty rate could be defined as the maximum capacity of the small intestine to absorb nutrients. Perhaps this rate could be exceeded when the stomach exceeds normal capacity, increasing intragastric pressure and forcing more through. 
- emptying of solid meals is much harder to define and subject to more variables. I think the time it takes to break solid foods into small enough particles to readily pass is the main slowing factor. 

## Intestine

- Reserve capacities of the small intestine
	for absorption of energy - https://journals.physiology.org/doi/pdf/10.1152/ajpregu.1998.275.1.R300

	

Small bowel dilation on [CT scan](https://en.wikipedia.org/wiki/CT_scan) in adults[[6\]](https://en.wikipedia.org/wiki/Small_intestine#cite_note-JacobsRozenblit2007-6)

| Diameter   | Dilation           |
| ---------- | ------------------ |
| <2.5 cm    | Non-dilated        |
| 2.5-2.9 cm | Mildly dilated     |
| 3–4 cm     | Moderately dilated |
| >4 cm      | Severely dilated   |

preforation risk >6cm

![](https://upload.wikimedia.org/wikipedia/commons/2/22/Diameters_of_the_large_intestine.svg)

preforation risk of colon >12cm and cecum >14cm

Interestingly the total volume of the average large intestine dilated to 12cm would be 18 liters. The small intestine dilated to 6cm would be a volume of  14 liters. Now I can't imagine it'd be possible to even approach those numbers. An individual section might become dilated to that extent from an obstruction, but there simply isn't enough room in the abdominal cavity for complete dilation of the intestines. I think an abdominal capacity would make sense to include. Realistically what happens would be something along the lines of abdominal compartment syndrome and the loss of circulation to various organs from compression. The less realistic option would be abdominal rupture for fans of bursting. Either could occur when abdominal capacity has been exceeded. Of course I do intend to have non-lethal outcomes for a more friendly simulation.

---

https://www.britannica.com/science/human-digestive-system/Secretions
> Each day approximately 1.5 to 2 litres (about 2 quarts) of chyme pass through the ileocecal valve that separates the small and large intestines. The chyme is reduced by absorption in the colon to around 150 ml (5 fluid ounces). The residual indigestible matter, together with sloughed-off mucosal cells, dead bacteria, and food residues not digested by bacteria, constitute the feces.

---

https://openstax.org/books/anatomy-and-physiology-2e/pages/23-7-chemical-digestion-and-absorption-a-closer-look
> Each day, about nine liters of fluid enter the small intestine. About 2.3 liters are ingested in foods and beverages, and the rest is from GI secretions. About 90 percent of this water is absorbed in the small intestine. Water absorption is driven by the concentration gradient of the water: The concentration of water is higher in chyme than it is in epithelial cells. Thus, water moves down its concentration gradient from the chyme into cells. As noted earlier, much of the remaining water is then absorbed in the colon.

---

https://link.springer.com/article/10.1007/BF01309499
> The absorption rates of water (0.035 ml), sodium (4.72μEq), and potassium (0.183μEq) per minute and per centimeter of bowel were constant along the small intestine and were independent of the perfusion rate. Stools only appeared when terminal ileal input to the colon was above 6 ml/min. When this occurred, the net absorption of water by the colon was 2.7±0.3 ml/min whatever the rate fluid entered the colon. 

## Abdominal Capacity

Some research here is required to determine at what volumes does intra-abdominal pressure become dangerously elevated. I can start with known volumes safely consumed by individuals and compare to case studies to get a feel for a reasonable number. 

Some self reported numbers without any reported medical trauma. 

- 8 quart enemas tend to cause vomiting and can possibly lead to water backing up into the stomach. 
- There are various asian competitive eaters that can consume 5-10kg within an hour or so.
- I've seen a particular woman eat 3lbs of fruit and 8L of custard.
- 12-13kg consumed by a woman within 1-6hrs on a regular basis. 



## Metabolism

- Urine Concentration and Dilution; Regulation of Extracellular Fluid Osmolarity and Sodium Concentration - https://doctorlib.info/physiology/textbook-medical-physiology/28.html
- https://www.researchgate.net/figure/Normal-physiologic-relationships-among-EC-osmolality-ADH-also-termed-Arginine_fig10_220243960
- https://cjasn.asnjournals.org/content/4/6/1140/tab-figures-data



## Cases

- Acute gastric dilatation in a patient with anorexia nervosa binge/purge subtype - https://www.ncbi.nlm.nih.gov/pmc/articles/PMC2966577/
- 

# Gas Production

https://open.oregonstate.education/aandp/chapter/23-6-the-small-and-large-intestines/
> In people with lactose intolerance, the lactose in chyme is not digested. Bacteria in the large intestine ferment the undigested lactose, a process that produces gas. In addition to gas, symptoms include abdominal cramps, bloating, and diarrhea. Symptom severity ranges from mild discomfort to severe pain; however, symptoms resolve once the lactose is eliminated in feces.

>Although the glands of the large intestine secrete mucus, they do not secrete digestive enzymes. Therefore, chemical digestion in the large intestine occurs exclusively because of bacteria in the lumen of the colon. Through the process of saccharolytic fermentation, bacteria break down some of the remaining carbohydrates. This results in the discharge of hydrogen, carbon dioxide, and methane gases that create flatus (gas) in the colon; flatulence is excessive flatus. Each day, up to 1500 mL of flatus is produced in the colon. More is produced when you eat foods such as beans, which are rich in otherwise indigestible sugars and complex carbohydrates like soluble dietary fiber.
