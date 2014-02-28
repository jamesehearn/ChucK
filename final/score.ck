// score.ck
// Final Project: Please be kind!

<<<"Assignment 7: elcriC murD">>>;

// Add your composition files when you want them to come in

BPM tempo;

//Technical/Code Score: Use of variables
96.0 => float beat;

tempo.tempo(beat);

Scale sc;

60.1::second => dur loopDuration; // Loop duration, adding 0.1 second to be sure that the loop ends after all the machines were removed.
now + loopDuration => time later; // Define time for the loop to end
 
//Technical/Code Score: Use of spork ~ to call functions concurrently
// main program
spork ~ setScore();
 
// loop
while (now < later) {
	1::second => now;
}
 
//Technical/Code Score: Use of at least one hand-written function
// function to set the score for the entire composition
fun void setScore() {
 
	// paths to chuck file
	me.dir() + "/bass.ck" => string bassPath;
	me.dir() + "/drums.ck" => string drumsPath;
	me.dir() + "/piano.ck" => string pianoPath;
 
	// start piano
	Machine.add(pianoPath) => int pianoID;
	10::second => now; // advance time
 
	// start drums & bass
	Machine.add(bassPath) => int bassID;
	10::second => now; // advance time
 
	// start drums & bass
	Machine.add(drumsPath) => int drumsID;
	40::second => now; // advance time
 
	// ending after 60 seconds so remove all instruments and classes
	Machine.remove(pianoID);
	Machine.remove(bassID);
	Machine.remove(drumsID);	
  	
}