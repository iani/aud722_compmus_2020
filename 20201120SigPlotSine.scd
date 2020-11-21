/* 20 Nov 2020 14:06 Explaining Signal arrays, plotting, and sines */
//:plot can be used to show signals created from Arrays, Envelopes or Synths:
//: ================================================================
(1..10).size;
(0..10).size;
//:(SImple, basic, or interesting) things you can do with a signal.
(1..10).plot; // plot
(1..10).reverse.plot // reverse
(1..10).rotate(5).plot //: rotate

//:normalize: adapt to range from 0 to 1
(1..10).normalize.plot; // plot
//:reverse
(1..10).reverse.plot; // plot
//: Plot envelopes
Env.perc.plot;
//:Plot signals from synth
{ SinOsc.ar(1) }.plot(1);

//:================================================================
//:21 Nov 2020 21:45 Explore phases
//:rotate several times to understand rotate better
10    do:   { | i | (1..10).rotate(i).plot;   };
//:rotate several times and collect in one plot.
var data;
data = (1..1000).normalize;
({ | i | data.rotate(i * 100); } ! 10).plot;

//:as above, but collect sines
var data;
data = (1..1000).normalize * 2pi;
({ | i | data.rotate(i * 100).sin; } ! 11).plot;

//:With UGens
{ SinOsc.ar(1, pi) }.plot(1);
{ SinOsc.ar(1, pi / 2) }.plot(1);
