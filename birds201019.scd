// From sccode.org
//http://sccode.org/1-5cy  (and others)
//:
(
SynthDef(\bird,{
	var sig, freqenv, env, trig;
	trig = Dust.ar(2);
	env = EnvGen.ar(Env.perc(0.01,0.4,0.8,-8), trig, doneAction: 2);
	freqenv = EnvGen.ar(Env([Rand(1000,3000), Rand(3000,6000), Rand(1000,2000), Rand(2000,5000)],[0.1,0.01,0.1]);, trig);
	sig = SinOsc.ar(freqenv, 0, env);
	sig = Pan2.ar(sig, Rand(-1.0,1.0));
	Out.ar(0, sig);
}).add;
)
//:Run this after running the SynthDef code above.
(
Routine({
	inf.do({
		Synth(\bird);
		rrand(1.0,2.0).wait;
	})
}).play;
)
//:«Digital Bird sounds» by monodread
{arg freq=1500, amp=0.5, rate=10;
	var osc, son, convIn, rand;
	osc=LFCub;
	rand = LFNoise1.ar(rate);
	convIn=LinCongN.ar(rate);
	son = osc.ar(Convolution.ar(convIn,convIn));
	freq = Latch.kr(rand.range(0,1).round(0.1), rand) * freq;
	freq = osc.ar(osc.ar(rand)*rand.range(0,10)).range(freq, freq*3);
	son = Formlet.ar(son, freq, convIn.abs*0.1, rand.abs);
	son = Normalizer.ar(son, 0.9, 0.1) * convIn.abs * LFPulse.kr(LFPulse.kr(rand.abs), 0, rand.abs);
	son = son + GVerb.ar(son, 99, 2, mul: rand.range(0,0.3));
	son * amp
}.play;
//:«pluck birds in desert» by vividsnow on 31 Mar'13 10:40 in sketchexperimentalrandomwind
// morning on Gliese 667Cb
(
{
	var gen = { rrand(1,10).reciprocal };
	BPF.ar(
		SelectX.ar(LFNoise2.kr(gen!4).exprange(0.02,2), [BrownNoise.ar, WhiteNoise.ar, PinkNoise.ar]).mean,
		LFNoise2.ar(gen!8).exprange(20,2e4),
		LFNoise2.ar(gen!8).exprange(0.1,2),
		LFNoise2.ar(gen!8).range(0.1,1)
	).clump(2).mean
	+ FreeVerb.ar(
		LFPar.ar(
			LFNoise2.ar(gen!8).exprange(20,2e4) * SinOsc.ar(1/gen!8).exprange(1,1.2), 0,
			LFNoise2.ar(gen!8).exprange(0.08,0.5) * EnvGen.ar(
				Env.perc.blend(Env.sine, LFNoise2.kr(gen!8)).circle, 
				timeScale: gen!8 // LFNoise2.ar(gen!8).range(1/5, 5)
			)
		).clump(2).mean,
		LFNoise2.ar(1/5)
	) 
	+ Pan2.ar(
		Pluck.ar(
			WhiteNoise.ar ! 2,
			Dust.ar(LFNoise2.kr(gen!2).exprange(1/5,5)), 
			1/200, LFNoise2.kr(gen!2).exprange(1/14000,1/200),
			LFNoise2.kr(gen!2).range(1,10),
			LFNoise2.kr(gen!2).range(0,1),
			LFNoise2.kr(gen!2).exprange(0.2,1)
		),
		LFNoise2.kr(gen!2).range(-1,1)
	).sum
	/ 3;
}.play
)
