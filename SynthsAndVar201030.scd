1 + 1;
10000.rand;

(
Synth("default", [freq: 600, amp: 0.95]);
Synth("default");
Synth("default");
)
//:
(
SynthDef("iz", { | freq = 400 |
	Out.ar(0, SinOsc.ar(freq, 0, Env.perc(0.01, 1, 0.1).kr(2, 1)));
}).add;
)

(
SynthDef("iz2", { | freq = 400 |
	Out.ar(0, SinOsc.ar(freq, 0, Env.perc(0.01, 1, 0.1).kr(2, 1)));
}).add;
)

SynthDescLib.global.browse


Synth("iz2");


Server.default.scope;


a = Synth("default", [freq: 600, amp: 0.05]);

a.free;

a.release(5);

a.set(\freq, 1200);

(
{
	var stream;
	var a;
	stream = Pbrown(60, 120, 5).asStream;
	a = Synth("default", [freq: 600, amp: 0.15]);
	90 do: {
       a.set(\freq, stream.next.midicps);
		0.1.wait;
	};
	1.wait;
	a.release(5);
}.fork;
)

/*
Παρενθεση () Parenthesis
Αγκύλη [] Bracket
Άγκιστρο {} Brace

Parenthesis: enclose expressions, arguments, and series/array shortcuts:

Synth("a") // argument
3 * (1 + 2) // expression
(1..10) /// series/array expansion
(1, 1.5 .. 5) // series array expansion

Bracket: Index, array
(1..10)[5] // index
(a: 1, b: 2)[\a] // also index !!!!
[1, 2, 3, 100] // array

Brace: Function!!! (also: Class, Method)
{ /// this is a function:
"hello world".postln;
}

Function definition rules:

1. Variables must be in the start, before any expression
{
   var myvar1, myvar2;
   var myvar3;
   // expressions must be after the vars:
   myvar1 = 1000.rand;

}
*/
/////
(
{
	var stream;
	var a, b;
	stream = Pbrown(50, 120, 5).asStream;
	a = Synth("default", [freq: 600, amp: 0.15]);
	b = Synth("default", [freq: 500, amp: 0.15]);
	90 do: {
		0.5.wait;
		a.set(\freq, stream.next.midicps);
		0.5.wait;
		b.set(\freq, stream.next.midicps);
	};
	1.wait;
	a.release(5);
	b.release(10);
}.fork;
)

(
~wait1 = 0.25;
~wait2 = 0.25;
{
	var stream;
	var a, b;
	stream = Pbrown(50, 120, 5).asStream;
	a = Synth("default", [freq: 600, amp: 0.15]);
	b = Synth("default", [freq: 500, amp: 0.15]);
	inf do: {
		~wait1.wait;
		a.set(\freq, stream.next.midicps);
		~wait2.wait;
		b.set(\freq, stream.next.midicps);
	};
	1.wait;
	a.release(5); // no longer needed with inf
	b.release(10);
}.fork;
)

~wait1 = 0.5;
~wait2 = 0.15;

(
c = {
	var wait1 = 0.25;
	var wait2 = 0.25;
{
	var stream;
	var a, b;
	stream = Pbrown(50, 120, 5).asStream;
	a = Synth("default", [freq: 600, amp: 0.15]);
	b = Synth("default", [freq: 500, amp: 0.15]);
	inf do: {
		wait1.wait;
		a.set(\freq, stream.next.midicps);
		wait2.wait;
		b.set(\freq, stream.next.midicps);
	};
	1.wait;
	a.release(5); // no longer needed with inf
	b.release(10);
}.fork;
	{ | argw1, argw2 |
		argw1 !? { wait1 = argw1 };
		argw2 !? { wait2 = argw2 };
	}
}.value;
)


c.(1);
c.(nil, 2);
c.(argw1: 0.15);
c.(argw2: 0.16);



~wait1 = 0.5;
~wait2 = 0.15;


(
var a;

a

);


