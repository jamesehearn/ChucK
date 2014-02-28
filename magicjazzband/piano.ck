// piano.ck
// Assignment_6_Magic_Jazz_Band
<<< "Assignment_6_Magic_Jazz_Band piano" >>>;


// notes
0.625 => float n4; // quarter note
n4 * 2 => float n2; // half note
n2 * 2 => float n1; // whole note
n4 / 2 => float n8; // eighth note
n8 / 2 => float n16; // sixteenth note;

[n4] @=> float beats[];
[0,1,0,1] @=> int hit[];

Rhodey piano[3];
piano[0] => dac;
piano[1] => dac.left;
piano[2] => dac.right;
0.5 => piano[0].gain;
0.5 => piano[1].gain;
0.5 => piano[2].gain;

// the Bb Aeolian mode
[46 - 12, 48 - 12, 49 - 12, 51 - 12, 53 - 12, 54 - 12, 56 - 12, // 0 to 6
46, 48, 49, 51, 53, 54, 56, 58, // 7 to 14
48 + 12, 49 + 12, 51 + 12, 53 + 12, 54 + 12, 56 + 12, 58 + 12 // 15 to 21
] @=> int midis[];

[15, 16, 18, 19, 18, 21] @=> int notes[];

0 => int i;
0 => int j;

fun float getFreq(int note) {
    // get the next chord
    0 => int scaleAdjust;
    while (note < 0) {
        scaleAdjust - 12 => scaleAdjust;
        note + midis.cap() => note;
    }
    while (note >= midis.cap()) {
        scaleAdjust + 12 => scaleAdjust;
        note - midis.cap() => note;
    }    
    return Std.mtof(midis[note] + scaleAdjust);
}

while(true){
    beats[i % beats.cap()] => float beat;
    if (hit[i % hit.cap()] == 1) {
        // get the next chord
        notes[j % notes.cap()] => int note;
        getFreq(note) => piano[0].freq;
        getFreq(note + 2) => piano[1].freq;
        getFreq(note + 4) => piano[1].freq;
        
        Math.random2f(0.5, 1.0) => piano[2].noteOn;
        (beat * 0.25)::second => now;
        Math.random2f(0.5, 1.0) => piano[1].noteOn;
        (beat * 0.25)::second => now;
        Math.random2f(0.5, 1.0) => piano[0].noteOn;
        (beat * 0.25)::second => now;
        1 => piano[0].noteOff;
        1 => piano[1].noteOff;
        1 => piano[2].noteOff;
        (beat * 0.25)::second => now;
        j + 1 => j;
    }
    else {
        // silence
        1 => piano[0].noteOff;
        1 => piano[1].noteOff;
        1 => piano[2].noteOff;
        beat::second => now;    
    }
    i + 1 => i;
}