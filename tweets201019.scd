// Tweets from sccode
// 19 Oct 2020 12:04
// «tweets» by aucotsi on 18 Aug'11 11:23 in sctweet
//: a noisy
play{f=Saw.kr(1);x=LagUD.kr(LFPulse.kr(5,0,0.48,4),0.7,0.8)*SinOsc.kr(TRand.kr(799,1020,Dust.kr(3)));Trig.kr(x,0.244)*SinOsc.ar(x*f!2,0,4)}

//: and a liquid one
play{x=LagUD.kr(LFPulse.kr(2,0,1,4),0.2,0.8)*SinOsc.kr(TRand.kr(9,12,Dust.kr(3))).lag(1);f=Slope.kr(x);Trig.kr(x,0.24)*SinOsc.ar(x**f!2)}

//: bomb bass
play{FreeVerb.ar(EnvGen.ar(Env([0.0,0.2,0.0],[0.7,0.5]).circle)*PMOsc.ar(4.4*Saw.kr(9).abs,8.8*Saw.kr(19.sin).abs,94,0.5*Saw.kr(7).lag)!2)}