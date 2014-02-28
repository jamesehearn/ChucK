// drums.ck
// Assignment_6_Magic_Jazz_Band
<<< "Assignment_6_Magic_Jazz_Band drums" >>>;

// notes
0.625 => float n4; // quarter note
n4 * 2 => float n2; // half note
n2 * 2 => float n1; // whole note
n4 / 2 => float n8; // eighth note
n8 / 2 => float n16; // sixteenth note;

// Part of your composition goes here
SndBuf hihat => dac;

me.dir(-1) + "/audio/" => string path;

[n4, n8, n8, n4, n8, n8] @=> float beats[];
[1,1,1,1] @=> int hit[];

// function for loading a sound
fun void loadSound(string path, string filename, SndBuf buf)
{
    path + filename => buf.read;
    buf.samples() => buf.pos;
}

loadSound(path, "hihat_01.wav", hihat);

0 => int i;

while(true){
    Math.random2f(0.5,0.8) => hihat.gain;
    Math.random2f(0.9,1.5) => hihat.rate;    
    beats[i % beats.cap()]::second => now;
    if (hit[i % hit.cap()] == 1) {
        0 => hihat.pos;
    }
    (i + 1) => i;
}