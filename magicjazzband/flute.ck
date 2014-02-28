// flute.ck
// Assignment_6_Magic_Jazz_Band
<<< "Assignment_6_Magic_Jazz_Band flute" >>>;

// notes
0.625 => float n4; // quarter note
n4 * 2 => float n2; // half note
n2 * 2 => float n1; // whole note
n4 / 2 => float n8; // eighth note
n8 / 2 => float n16; // sixteenth note;

[n2] @=> float beats[];
[1,0] @=> int hit[];

Flute flute => JCRev rev => dac;
flute => Delay d => d => rev;
0.5 => flute.gain;
0.05 => rev.mix;
n8::second => d.max => d.delay;
0.05 => d.gain;


// the Bb Aeolian mode
[46 - 12, 48 - 12, 49 - 12, 51 - 12, 53 - 12, 54 - 12, 56 - 12, // 0 to 6
46, 48, 49, 51, 53, 54, 56, 58, // 7 to 14
48 + 12, 49 + 12, 51 + 12, 53 + 12, 54 + 12, 56 + 12, 58 + 12 // 15 to 21
] @=> int midis[];

[15, 16, 18, 19, 18, 21] @=> int notes[];
0 => int i;
0 => int j;

while(true){
    beats[i % beats.cap()] => float beat;
    if (hit[i % hit.cap()] == 1) {
        // get the next note
        notes[j % notes.cap()] => int note;
        0 => int scaleAdjust;
        while (note < 0) {
            -12 => scaleAdjust;
            note + midis.cap() => note;
        }
        while (note >= midis.cap()) {
            12 => scaleAdjust;
            note - midis.cap() => note;
        }
        
        Std.mtof(midis[note] + scaleAdjust) => flute.freq;
        
        1 => flute.noteOn;
        beat::second => now;    
        //1 => flute.noteOff;
        j + 1 => j;
    }
    else {
        // silence
        1 => flute.noteOff;
        beat::second => now;    
    }
    i + 1 => i;
}