// initialize.ck
// Assignment 7: elcriC murD

// Something new will go here next week

// our conductor/beat-timer class
Machine.add(me.dir()+"/BPM.ck");

// a scale class to set the scale
Machine.add(me.dir()+"/Scale.ck");

//Adds score.ck
me.dir() + "/score.ck" => string scorePath;
Machine.add(scorePath);