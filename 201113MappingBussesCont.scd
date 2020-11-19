//: 13 Nov 2020 11:42 mapping busses - continued
//:================================================================
//:tests of recent stuff
//:testing fixing
\test.fix;
//:
\default +> \test;
//:
\test.unfix;
//:================================================================
//:Testing new version of Function:@>
{ SinOsc.kr(3) } @> \bus1;
//:Note that one can change the output bus in the usual manner:
\out <+.bus1 1;
//:
\bus1.unfix;
//:
\bus1 <@ 0;
//:set bus by index
1 <@ -0.5;
//:* Open scope (Control bus view!) to watch changing value of bus
1 <@ -0.9.rrand(0.9);
0.5.wait
//:================================================================
//:Multiple control functions - in sequence and in parallel
{ SinOsc.kr(2) } @> \bus1;
//:
{ LFSaw.kr(2) } @> \bus1;
//:
{ LFTri.kr(2) } @> \bus1;
//:
{ LFPulse.kr(2).range(-0.1, 0.1) } @> \bus1;
//:
{ SinOsc.kr(0.2).range(-0.5, 0.5) } @>.sinbus1 \bus1;
//:
\sinbus1.stop;
//:
\sinbus1.play;
//:
\bus1.play;
//:
Player.unfix;
//:
play
//:
\bus1;
//:
\bus1.bus;
//:
\out <+.bus1 1;
//:
\out <+.sinbus1 2;
//:
Bus(\control, 0, 1).get;
//
Bus(\control, 1, 1).get;
//:
Bus(\control, 2, 1).get;
//:
Server.default.options.numAudioBusChannels;
//:
Server.default.options.numControlBusChannels;
//:
{ Out.ar(1025, WhiteNoise.ar()) }.play;

{ Out.kr(3025, WhiteNoise.kr()) }.play;
//:
Bus(\control, 1, 1).get;
//:
Server.default.addr.sendMsg('/c_set', 0, 0.0);
//:
b = \bus1.bus;
//:
b.set(-0.5);

//:
\bus1.bus.set(0);
//:
Synth(\default);
//:
Server
//:
Server.default.scope;
//:
{ SinOsc.ar(400, 0, 0.1 ).dup(10) }.scope;
//:
{ SinOsc.ar(400 rrand: 1000, 0, 0.1 ) }.scope;
//:
{ { SinOsc.ar(400 rrand: 1000, 0, 0.1 ) } ! 10 }.scope;
//:
{ Mix({ SinOsc.ar(400 rrand: 1000, 0, 0.1 ) } ! 10) }.scope;
//:
{  SinOsc.ar({ 400 rrand: 1000 } ! 10, 0, 0.1 ) }.scope;
//:
{  SinOsc.ar([400, 600], 0, 0.1 ) }.scope;
//:
{  SinOsc.ar([400, 600], 0, 0.1 ) }.scope;
//:
{  SinOsc.ar([400, 600], 0, 0.1 ) }.scope;
//:
{
	var base;
	base = 4;
	SinOsc.ar([base * 100, base * 100 * 3 / 2], 0, 0.1 )
}.scope;
//:
{
	var base, fifth;
	base = 400;
	fifth = { | f | f * 3 / 2 };
	SinOsc.ar([base, fifth.(base)], 0, 0.1 )
}.scope;
//:
a = { | base = 400, arith = 3, paron = 2 |
	SinOsc.ar([base, base * arith / paron], 0, 0.1)
}.play;
//:
a.set(\base, 500);
//:+
var bases = Pbrown(70, 90, 7).midicps.asStream;
var ariths = Pseq([3, 4, 5, 6, 7, 8, 9, 10, 12, 13, 14, 15], inf).asStream;
var parons = Pseq([4, 5, 6, 7, 8, 9, 10, 11, 13, 14, 15, 16], inf).asStream;
a = { | base = 400, arith = 3, paron = 2 |
	SinOsc.ar([base, base * arith / paron], 0, 0.1)
}.play;
loop {
	10 do: {
		0.1.wait;
		a.set(\base, bases.next);
	};
	a.set(\arith, ariths.next.postln);
	a.set(\paron, parons.next.postln);
};
//:
(70 .. 90)
(70, 70.5 .. 90)
//:+
var chromatic = (70 .. 90);
var bases = Pseq(chromatic, inf).midicps.asStream;
var ariths = Pseq((2..15), inf).asStream;
var parons = Pseq((3..16), inf).asStream;
a = { | base = 400, arith = 3, paron = 2 |
	SinOsc.ar([base, base * arith / paron], 0, 0.1)
}.play;
loop {
	chromatic.size do: {
		0.1.wait;
		a.set(\base, bases.next);
	};
	a.set(\arith, ariths.next.postln);
	a.set(\paron, parons.next.postln);
};
//:+
var chromatic = (70 .. 90);
var bases = Pseq(chromatic, inf).midicps.asStream;
var ariths = Pstutter(chromatic.size, Pseq((2..15), inf)).asStream;
var parons = Pstutter(chromatic.size, Pseq((3..16), inf)).asStream;
a = { | base = 400, arith = 3, paron = 2 |
	SinOsc.ar([base, base * arith / paron], 0, 0.1)
}.play;
loop {
	chromatic.size do: {
		0.1.wait;
		a.set(
			\base, bases.next,
			\arith, ariths.next,
			\paron, parons.next
		);
	};
};
//:+
var chromatic = (70 .. 90);
var bases = Pseq(chromatic, inf).midicps.asStream;
var ariths = Pstutter(chromatic.size, Pseq((2..15), inf)).asStream;
var parons = Pstutter(chromatic.size, Pseq((3..16), inf)).asStream;
a = { | base = 400, arith = 3, paron = 2 |
	Mix(SinOsc.ar([base, base * arith / paron,
		base * arith / paron * arith / paron
	], 0, 0.1)
	).dup
}.play;
loop {
	chromatic.size do: {
		0.1.wait;
		a.set(
			\base, bases.next,
			\arith, ariths.next,
			\paron, parons.next
		);
	};
};
//:+
var chromatic = (70, 70.5 .. 90);
var bases = Pseq(chromatic, inf).midicps.asStream;
var ariths = Pstutter(chromatic.size, Pseq((2..15), inf)).asStream;
var parons = Pstutter(chromatic.size, Pseq((3..16), inf)).asStream;
a = { | base = 400, arith = 3, paron = 2 |
	Mix(SinOsc.ar([base, base * arith / paron,
		base * arith / paron * arith / paron,
		base * arith / paron * arith / paron * arith / paron
	], 0, 0.1)
	).dup
}.play;
loop {
	chromatic.size do: {
		0.05.wait;
		a.set(
			\base, bases.next,
			\arith, ariths.next,
			\paron, parons.next
		);
	};
};
//:
Pseq((1..3), 2).asStream.nextN(10);
Pbind(\degree, Pseq((1..3)), \dur, 0.1).play;
Pbind(\degree, Pseq((1..3), 2), \dur, 0.1).play;
Pbind(\degree, Pstutter(2, Pseq((1..3), 2)), \dur, 0.15).play;
Pbind(\degree, Pstutter(2, Pbrown(0, 10, 2)), \dur, Pseq([1, 2] / 10, inf)).play;
Pbind(\degree, Pstutter(4, Pbrown(0, 10, 2)), \dur, Pseq([1, 2] / 10, inf)).play;

//:
(70..90).size;
//:+
var bases = Pseq((70 .. 90), inf).midicps.asStream;
var ariths = Pseq([3, 4, 5, 6, 7, 8, 9, 10, 12, 13, 14, 15], inf).asStream;
var parons = Pseq([4, 5, 6, 7, 8, 9, 10, 11, 13, 14, 15, 16], inf).asStream;
a = { | base = 400, arith = 3, paron = 2 |
	SinOsc.ar([base, base * arith / paron], 0, 0.1)
}.play;
loop {
	20 do: {
		0.1.wait;
		a.set(\base, bases.next);
	};
	a.set(\arith, ariths.next.postln);
	a.set(\paron, parons.next.postln);
};
//:
4 * (3/2) * 100;
//:
4 * 100 * 3 / 2;
//:
{  Mix(SinOsc.ar({ 400 rrand: 1000 } ! 10, 0, 0.1 )) }.scope;
//:
{ SinOsc.ar(400.rrand(1000), 0, 0.1 ).dup(10) }.scope;
//:
{ SinOsc.ar(rrand(400, 1000), 0, 0.1 ).dup(10) }.scope;
//:
1 respondsTo: \run;
//:
1.run;
//:
2 respondsTo: \squared;
//:
2.squared;
//:
Object respondsTo: \value;
//:
Object.dumpClassSubtree;
//:
1.value;
//:
[1 ,2, 3].value;
//:
a = Bus.control;
a;
a.value;
a ! 10;
//:
f = { 1000.rand };
//:
f;
//:
f.value;
//:
f ! 10;
//:
{ 1000.rand }.value;
//:
{ 1000.rand } ! 10;
//:
{ SinOsc.ar(400 rrand: 1000, 0, 0.1 ) }.value;

{ SinOsc.ar(400 rrand: 1000, 0, 0.1 ) } ! 10;
//:
f = { SinOsc.ar(400 rrand: 1000, 0, 0.1 ) };
//:
f ! 10;
//:
Pwhite(0, 90).asStream.nextN(10);
Pbrown(70, 90, 2).asStream.nextN(10);
