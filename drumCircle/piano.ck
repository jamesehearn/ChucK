// piano.ck
// Assignment 7: elcriC murD

// Part of your composition goes here
BPM tempo;
Scale sc;

tempo.quarterNote => dur quarter;
 
[0.5, 0.5, 1.0, 1.0] @=> float p[];
 
// sound chain
Pan2 master => dac;
 
// piano
Moog piano => Echo echo => master;
quarter => echo.max;
quarter / 4 => echo.delay;
.1 => piano.gain;
 
// SinOsc 1
SinOsc s1 => Pan2 p1 => master;
.3 => s1.gain;
-1 => p1.pan;
 
// SinOsc 2
SinOsc s2 => Pan2 p2 => master;
.3 => s2.gain;
1 => p2.pan;
 
while (true)  {
 
    Math.random2(0, sc.Cmaj.cap() - 1) => int note;
    
    // piano freq
    Math.mtof(sc.Cmaj[note] + 12) => piano.freq;
    
    // SinOsc 1 freq
    Math.mtof(sc.Cmaj[note] - 12) => s1.freq;
    
    // SinOsc 2 freq
    Math.mtof(sc.Cmaj[note] - 24) => s2.freq;
    
    // note duration
    Math.random2f(.50, .75) => piano.noteOn;
    
    0.9 => piano.filterSweepRate;
    0.1 => piano.filterQ;
 
    for (0 => int i; i < 3; i++) {
        // advance time
        quarter * p[i] => now;
    }
 
}