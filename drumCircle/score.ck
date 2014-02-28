// score.ck
// Assignment 7: elcriC murD

<<<"Assignment 7: elcriC murD">>>;

// Add your composition files when you want them to come in

BPM tempo;
tempo.tempo(96.0);

Scale sc;

30.1::second => dur loopDuration; // Loop duration, adding 0.1 second to be sure that the loop ends after all the machines were removed.
now + loopDuration => time later; // Define time for the loop to end
 
// main program
spork ~ setScore();
 
// loop
while (now < later) {
	1::second => now;
}
 
// function to set the score for the entire composition
fun void setScore() {
 
	// paths to chuck file
	me.dir() + "/bass.ck" => string bassPath;
	me.dir() + "/drums.ck" => string drumsPath;
	me.dir() + "/piano.ck" => string pianoPath;
 
	// start piano
	Machine.add(pianoPath) => int pianoID;
	5::second => now; // advance time
 
	// start drums & bass
	Machine.add(bassPath) => int bassID;
	5::second => now; // advance time
 
	// start drums & bass
	Machine.add(drumsPath) => int drumsID;
	20::second => now; // advance time
 
	// ending after 30 seconds so remove all instruments and classes
	Machine.remove(pianoID);
	Machine.remove(bassID);
	Machine.remove(drumsID);	
  	
}