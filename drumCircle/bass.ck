// bass.ck
// Assignment 7: eclriC murD

// Part of your composition goes here
BPM tempo;
Scale sc;

// sound chain
Gain master => dac;
Mandolin bass[3];
 
for (0 => int i; i < bass.cap(); i++) {
    bass[i] => master;
    .3 => bass[i].gain;
    .1 => bass[i].bodySize;
    .8 => bass[i].pluckPos;
    .7 => bass[i].stringDamping;
}
 
// parameter setup
4 => int walkPos;
 
tempo.quarterNote => dur quarter;
 
// loop
while (true) {
    
    bassPlayer();
 
}
 
fun void bassPlayer() {
    
    [1.0, 0.5, 0.5, 1.0] @=> float p[];
    
    Math.random2(-2, 2) +=> walkPos; 
    
    if (walkPos < 0) {
        1 => walkPos;
    }
    
    if (walkPos >= sc.Cmaj.cap()) {
        sc.Cmaj.cap() - 2 => walkPos;
    }
    
    playChord(sc.Cmaj[walkPos], "major");
    
    for (0 => int i; i < 3; i++) {
        quarter * p[i] => now;
    }
 
}
 
 
// Function will make major or minor chord
fun void playChord (int root, string quality) {
 
    // Root
    Std.mtof(root) => bass[0].freq;
    .6 => bass[0].pluck;
    
    // Third
    if (quality == "major") {
        
        Std.mtof(root + 4) => bass[1].freq;
        .4 => bass[1].pluck;
        
        } else if (quality == "minor") {
            
            Std.mtof(root + 3) => bass[1].freq;
            1 => bass[1].pluck;
 
        } else {
            
            <<< "Must specify if 'major' or 'minor' chord type." >>>;
 
        }
    
    // Fifth
    Std.mtof(root + 7) => bass[2].freq;
    .2 => bass[2].pluck;
 
}