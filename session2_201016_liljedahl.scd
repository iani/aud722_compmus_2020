// 19 Oct 2020 10:35
// All code submitted by Jonatan Liljedahl to sccode.org
//:Many patterns controlling a single synth
(
SynthDef(\sawFilt, { |out = 0, freq = 440, amp = 0.1, gate = 1, cf = 100, wobble = 3, t_bd, t_sd, pw = 0.4|
    var base = Splay.ar(RLPF.ar(Pulse.ar(freq * [0.99,0.5,1.01],pw),cf.lag(0.05),0.3).madd(SinOsc.ar(wobble).range(0.5,4)).sin) * 0.5;
    var env = Linen.kr(gate, attackTime: 0.01, releaseTime: 0.5, doneAction: 2);
    var sig = base;
    var bd = tanh(Ringz.ar(LPF.ar(Trig.ar(t_bd,SampleDur.ir),1000),30,0.5,5).sin*2);
    var sd = tanh(Ringz.ar(LPF.ar(Trig.ar(t_sd,SampleDur.ir),1000),120,0.75,PinkNoise.ar(2!2)).sin*2);
    sd = HPF.ar(sd,60);
    sig = tanh(GVerb.ar(HPF.ar(base * env,30), 70, 11, 0.15)*0.5 + sig + bd + sd);
    Out.ar(out, sig*amp*env);
}).add;
)

(
p = Pproto(
    {
        ~id = (
            type: \on,
            dur: 0,
            instrument: \sawFilt,
            amp: 1,
        ).yield[\id];
        ~type = \set;
    },
    Ppar([
        Pbind(
            \args, #[freq],
            \freq, Pseq([49,47,50,48]-12,inf).midicps,
            \dur, 4,
        ),
        Pbind(
            \args, #[cf],
            \cf, Pseq([100,Prand([700,400,1100],3)],inf),
            \stutter, Prand([1,2,4,8],inf),
            \dur, PdurStutter(Pkey(\stutter)*2, 2),
            // NOTE: also useful is .collect on patterns!
            // \dur, Prand([1,2,4,8], inf).collect{ |x| (1/x)!(x*2) }.flatten
        ),
        Pbind(
            \args, #[wobble],
            \wobble, Pxrand([3,1.5,6],inf),
            \dur, Prand([2,1],inf),
        ),
        Pbind(
            \args, #[t_bd],
            \t_bd, Pseq([1,0,0,1],inf),
            \dur, 0.5,
        ),
        Pbind(
            \args, #[t_sd],
            \t_sd, Pseq([0,0,1,0],inf),
            \dur, 0.5,
        ),
        Pbind(
            \args, #[pw],
            \pw, Prand([0.4,0.3,0.5],inf),
            \dur, 2,
        ),
    ])
).play;
)
//:techno
(
play{
    i=Impulse.ar(_);
    h = LPF.ar(WhiteNoise.ar(Decay.ar(Impulse.ar([1,1/7],[0.5,0.75]).sum,0.1)!2),12000);
    Limiter.ar(
    (z=Pluck.ar(Saw.ar(4),i.(1),1,1,6/7,SinOsc.ar(PulseCount.ar(i.(11),i.(5)).cos%[3,4]*120),2.5).sin)
    + LPF.ar(HPF.ar(FreeVerb.ar(z.mean,1,0.999,0.2)*0.3,750)*Line.kr(0,1,16),2500)
    + HPF.ar(Ringz.ar(LPF.ar(Impulse.ar([0.5,1],[1/6,0]).sum,3000),40,0.8,3).sin*3,40).tanh.madd(0.6)
    + h + RHPF.ar(CombL.ar(h*0.4,1,5/8,10)*Line.kr(0,1,8),10000,0.5)
    )
}
)
//:auto rhythm
play{Ringz.ar(CoinGate.ar([5,3,9]/10*Line.kr(0,1,30),T2A.ar(Impulse.kr([4,12,6]))),[45,9e3,50,8e3],[6,1,10,3]/10,[9,2,3,1]).sin.sum.tanh!2}
//:metallic rhythmic patterns 1
play{Limiter.ar(GVerb.ar(sin(Ringz.ar(Impulse.ar(2**LFNoise0.ar(1!2).range(1,4).round),[40,200,234,889],0.7).sum*2),5,2,0.7))}
//:metallic rhythmic patterns 2
play{Limiter.ar(GVerb.ar(sin(Ringz.ar(Impulse.ar(2**LFNoise0.ar(1!3).range(1,5).round/2),[40,200,234,889,1320,150],0.7).sum),5,2,0.7)/2)}
//:drum tweet
play{a=Impulse;tanh(a.kr(8).lag*Crackle.ar(LFSaw.kr(3).abs.lag*1.8)+GVerb.ar([a.kr(2)+a.kr(4,0.5)].lag*Blip.ar(4.9,7,0.4)!2,1,1)*5)}
//:PWM crossfade
(
play {
    var notes = [ 400, 500, 450, 376, 600 ];
    var dur = 1/20;
    var freq = Demand.kr(Impulse.kr(dur, [0,0.5]), 0, Dseq(notes, inf));
    freq = LFPulse.kr(8, 0, LFTri.kr(dur, 1).range(0, 1)).range(*freq).max(376);
    LPF.ar(Saw.ar(freq * [1,0.99],0.5),8000);
}
)
//:Shaman ceremony»
(
play{
    p=LFPulse;
    n=LFNoise1;
    Limiter.ar(
        GVerb.ar(
            LPF.ar(LeakDC.ar(
                mean({|n|(p.ar(n*1e2+50*p.kr(4-n/[4,7,5]).sum+3e2)*p.kr(n+1*2,0,0.8).lag(0.1))}!3)
            ),4000) * 0.4, 200, 9, 0.6, 0.5, 40, 1, 0.15, 0.25
        ).madd(0.8) + GVerb.ar(
            {|i|BPF.ar(PinkNoise.ar(Decay.ar(Impulse.ar(2,0.95+n.kr(1,0.08)),rrand(0.2,0.4),2)).tanh,600*i+1200,0.4)}.dup(6).sum*1.2,
            90, 3, 0.7, 0.5, 30, 1, 0.2, 0.3
        ) + Splay.ar(
            {|i|Ringz.ar(LPF.ar(Impulse.ar(6,n.kr(1,0.08)),4000),6*i+40+n.kr(30,2),0.5,n.kr(3).range(4,8)).tanh}.dup(3),0.5
        ).madd(0.3)
    )
}
)
//:Glitch folk 4
play{p=LFPulse;cos(p.ar(p.kr(2)+p.kr(3)*[50,51]).lag(2e-3)+mean({|n|(p.ar(n*1e2+50*p.kr(4-n/[2,7,4]).sum+3e2)*p.kr(n+1*2,0,0.8))}!3))}
//:Dark sea horns
n=LFNoise1;Ndef(\x,{a=SinOsc.ar(65,Ndef(\x).ar*n.ar(0.1,3),n.ar(3,6)).tanh;9.do{a=AllpassL.ar(a,0.3,{0.2.rand+0.1}!2,5)};a.tanh}).play
//:Rain and thunder
(
play {
    Limiter.ar(
        tanh(
            3 * GVerb.ar(
                HPF.ar(
                    PinkNoise.ar(0.08+LFNoise1.kr(0.3,0.02))+LPF.ar(Dust2.ar(LFNoise1.kr(0.2).range(40,50)),7000),
                    400
                ),
                250,100,0.25,drylevel:0.3
            ) * Line.kr(0,1,10)
        ) + (
            GVerb.ar(
                LPF.ar(
                    10 * HPF.ar(PinkNoise.ar(LFNoise1.kr(3).clip(0,1)*LFNoise1.kr(2).clip(0,1) ** 1.8), 20)
                    ,LFNoise1.kr(1).exprange(100,2500)
                ).tanh,
               270,30,0.7,drylevel:0.5
            ) * Line.kr(0,0.7,30)
        )
    )
};
)
//:Glitch folk II
play{p=LFPulse;tanh(p.ar([50,52])*p.kr([2,1]/4)+mean({|n|(p.ar(n*3e2+99*p.kr(2-n/[1,5,7],(0..2)/10).sum+2e2)*p.kr(n+1*6,0,0.8).lag)}!2)/2)}
//:Dark ambience
play{a=HPF.ar(ar(PinkNoise,5e-3),10)*Line.kr(0,1,9);ar(GVerb,({|i|ar(Ringz,a*LFNoise1.kr(0.05+0.1.rand),55*i+60,0.2)}!99).sum,70,99).tanh}
//:PM stack tweet
play{x=0;(50..120).do{|f|f=f/2;x=SinOsc.ar(f+[0,1],x*Line.kr(1,3,240,doneAction:2))};tanh(x+Ringz.ar(Impulse.ar(2),45,0.3,3))}

