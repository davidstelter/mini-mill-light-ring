# Mini Mill Ring Light

Inspired by a nice looking product at
http://www.phenomengineering.com/blog/the-photonx2-mini-mill-light-is-here though there appear to be
a number of competitors and other DIY solutions around.

Using a cheap "headlight halo/angel eyes" kit intended for car headlights, I got a 2-pack for like
$12 off Amazon, for the mini mill an 80mm light is a good fit. The ones I got have double-stick foam
tape on the back as well as 3 mounting tabs, recesses to engage these tabs are included when the
customizer option `subtractLightTabRecess` is checked/true. Mine came with small inline power
regulator/constant current modules, I popped the outer shell off and it fits inside the electronics
hollows in the top of the main body.

## Mounting

Sticks to the mill with magnets so it's easy to remove if you need to attach a dial fixture to the
spindle or whatever. I used 8mm x 3mm neodymium disc magnets affixed with superglue, the magnet
recesses are sized accordingly for a good interference fit, but I found the magnets pulled out
sometimes when temporarily sticking the light on a larger ferrous surface so the superglue is
recommended to prevent this.

## Power

The automotive ring lights are supposed to run on "+12vdc", but in an actual car that's typically
more like 13.8v and the ones I got seem "happy" (meaning: hasn't burned out yet!) running up
around 16.4v, which gets significantly more brightness from it. I initially tried borrowing 12v from
the mill's fan supply, but the output there is a bit below 12v on my mill and the light was
disappointingly dim, so I dug around in my box of old power supplies and found that those marked as
12v in reality had outputs ranging from 12.3v to 18.5v so hunt around a bit, and good luck! Cars
often have the main voltage go as high as 18-19v when starting, so hopefully most of these lights
are relatively tolerant of wide voltage swings.

## Rendering & Printing

Use the [OpenSCAD customizer](https://en.wikibooks.org/wiki/OpenSCAD_User_Manual/Customizer) to
select options for rendering & printing, I've included presets for the main body and shroud each by
themselves, and one with everything turned on and the resolution turned down for better pan/zoom
performance.

See the `/stls/` directory for pre-rendered files for the main body and the shroud. 

## Semi-Optional Shroud

The shroud slips over the main body with a friction fit. It is optional but without it the light
gets in your eyes almost as much as down on the work surface. I added a thin strip of aluminum
flashing tape to the inside of the shroud as a light reflector, hard to tell how much without a
light meter but it does seem to increase the brightness of the illuminated work area somewhat.

## Extra Stuff

I included parts like the mill's R8 spindle, the DC jack, an approximation of the light ring etc. as
it helped me visualize things while designing this, but it's probably useless except as eye candy.
The DC jack got its own module in a separate file as it might conceivably be useful? To someone?

## Code Quality, Performance

I'm a novice at OpenSCAD, there are probably antipatterns and performance issues with the way I've
done things here, so be wary.

## License

Copyright David Stelter 2022

This project is licensed under the BSD & MIT licenses, see files `LICENSE-BSD` and `LICENSE-MIT` for details.
