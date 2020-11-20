/* 20 Nov 2020 14:06 Explaining Signal arrays, plotting, and sines */
//:plot can be used to show signals created from Arrays, Envelopes or Synths:
//: ================================================================
(1..10).size;
(0..10).size;
//:(SImple, basic, or interesting) things you can do with a signal.
(1..10).plot; // plot
()


// plot an array from -100 to 100;



a = (-100..100); // store an array of intergers from -100 to 100 into a to work with
(-100..100).size.postln; // 201 elements in the array.
(-100..100).plot;        // plot the array
