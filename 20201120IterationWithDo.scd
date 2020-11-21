/* 20 Nov 2020 16:25
iterating with do.
*/
//:================================================================
//:1. Simple iteration: Repeat something a certain number of times.
//:Repeat 1 time:
1 do: { "Hello".postln; };
//:
2 do: { "Hello".postln; };
//:Repeat infinite times. For ever. This needs a routine
// DANGER: If you do not wait between repetitions, then sclang will freeze.
{
	inf do: {
		"Hello".postln;
		0.25.wait;
	};
}.fork;
//:2. Arguments inside an iteration with do:
//:2a: do used with an integer as receiver:
// The count of the iteration is passed as argument to the function.
10 do: { | i | i.postln; };
//:2b: do used with a collection iterates with the elements of the collection
/// and also gives the count of the repetiton as second argument.
[\a, \b, \c] do: { | element, count |
	postf("my element was: % and my count was: %\n", element, count);
};
//:

//:
r = {
	loop {
		"Hello".postln;
		1.wait;
		"Done".postln;
	}
}.fork;
//:
