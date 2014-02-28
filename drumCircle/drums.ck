// drums.ck
// Assignment 7: eclriC murD

// Part of your composition goes here
BPM tempo;

// sound chain
Pan2 master => dac;
tempo.quarterNote => dur quarter;
 
// Set up SndBuf for drums
 
// kick
["kick_01.wav", "kick_02.wav", "kick_03.wav", "kick_04.wav", "kick_05.wav"] @=> string Kick[];
readFiles(Kick, .3) @=> SndBuf kick;
kick => Pan2 k1 => master;
 
// snare
["snare_01.wav", "snare_02.wav", "snare_03.wav"] @=> string Snare[];
readFiles(Snare, .3) @=> SndBuf snare;
snare => Pan2 s1 => master;
 
// hihat
["hihat_01.wav", "hihat_02.wav", "hihat_03.wav", "hihat_04.wav"] @=> string Hihat[];
readFiles(Hihat, .3) @=> SndBuf hihat;
hihat => Pan2 h1 => master;
 
// loop
while (true) {
 
    drummer();
    
}
 
// Function to load sound files and prepare SoundBuf
fun SndBuf readFiles (string File[], float volume) {
    
    SndBuf sound;
    me.dir(-1) + "/audio/" + File[Math.random2(0, File.cap() - 1)] => sound.read;
    volume => sound.gain;
    sound.samples() => sound.pos;
    
    return sound;
 
}
 
// Function to control drumming sequence
fun void drummer() {
 
    [1.0, 0.5, 0.5, 1.0] @=> float k[];
    [0.5, 1.0, 1.0, 0.5] @=> float h[];
    [0.5, 0.5, 1.0, 1.0] @=> float s[];
 
    .1 => hihat.gain;
    .4 => kick.gain;
    .2 => snare.gain;
    
    0.7 => h1.pan;
    0 => k1.pan;
    -0.5 => s1.pan;
    
    for (0 => int i; i < 3 - 1; i++) {
    
        0 => hihat.pos;
        quarter * h[i] => now;
        
        0 => kick.pos;
        quarter * k[i] => now;
 
        0 => snare.pos;
        quarter * s[i] => now;
 
    }
 
}