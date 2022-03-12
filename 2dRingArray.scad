module 2dRingArray(itemCount, ringRadius) {
	arcSpread = 360 / itemCount;

	for (i = [0 : itemCount - 1])
	rotate(i * arcSpread) 
	translate([0, ringRadius])
		circle(d = magnetRemovalHoleDiam);
}

