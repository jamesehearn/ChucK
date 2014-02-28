// bass.ck
// Assignment_6_Magic_Jazz_Band
<<< "Assignment_6_Magic_Jazz_Band bass" >>>;

// the Bb Aeolian mode
[46 - 12, 48 - 12, 49 - 12, 51 - 12, 53 - 12, 54 - 12, 56 - 12, 
46, 48, 49, 51, 53, 54, 56, 58, 
48 + 12, 49 + 12, 51 + 12, 53 + 12, 54 + 12, 56 + 12, 58 + 12] @=> int midis[];

[5, 5, 3, 3, 1, 0] @=> int notes[];

// notes
0.625 => float n4; // quarter note
n4 * 2 => float n2; // half note
n2 * 2 => float n1; // whole note
n4 / 2 => float n8; // eighth note
n8 / 2 => float n16; // sixteenth note;

[n4, n8, n8, n4, n8, n8] @=> float beats[];
[1, 1, 0] @=> int hit[];

Mandolin bass => NRev r => dac;

0.05 => r.mix;
0.05 => bass.stringDamping;
0.02 => bass.stringDetune;
0.05 => bass.bodySize;
0.5 => bass.gain;

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
        Std.mtof(midis[note] + scaleAdjust) => bass.freq;
        Math.random2f(0.05, 0.5) => bass.pluckPos;
        
        1 => bass.noteOn;
        (beat * 0.80)::second => now;    
        1 => bass.noteOff;
        (beat * 0.20)::second => now;    
        
        j + 1 => j;
    }
    else {
        // silence
        beat::second => now;    
    }
    i + 1 => i;
}