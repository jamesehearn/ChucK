// score.ck
// Assignment_6_Magic_Jazz_Band
<<< "Assignment_6_Magic_Jazz_Band score" >>>;
now => time started;
30::second + now => time later;

// function that shows the time elapsed
function void showTimeElapsed() {
    while (now <= later) {
        <<< "time elapsed:", (now - started)/second >>>;
        1::second => now;
    }
}

// spork the function that shows the time that has elapsed
spork ~ showTimeElapsed();

0.625 => float n4; // quareter note
n4 * 2 => float n2; // half note
n2 * 2 => float n1; // whole note
n4 / 2 => float n8; // eighth note
n8 / 2 => float n16; // sixteenth note;

// Add your composition files when you want them to come in
Machine.add(me.dir() + "/bass.ck") => int bassID;
(n4 * 4)::second => now;

Machine.add(me.dir() + "/drums.ck") => int drumID;
(n4 * 8)::second => now;

Machine.add(me.dir() + "/flute.ck") => int fluteID;
(n4 * 4)::second => now;

Machine.add(me.dir() + "/piano.ck") => int pianoID;

(n4 * 16)::second => now;

Machine.remove(pianoID);
(n4 * 4)::second => now;
Machine.remove(fluteID);
(n4 * 4)::second => now;
Machine.remove(drumID);
(n4 * 6)::second => now;
Machine.remove(bassID);

function void outro() {
    // Outro
    1.0 => float gain;
    SinOsc s => Pan2 p => dac;
    gain => s.gain;
    Std.mtof(51 - 12) => s.freq;
    while (now < later) {
        Math.sin( now / 1::second * 2 * pi ) => p.pan;
        
        gain * 0.9 => gain;
        gain => s.gain;
        n16::second => now;
    }
}


// Outro so it doesn't end abruptly
outro();
