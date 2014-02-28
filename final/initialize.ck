//Tecnical/Code Score: Use of comments
// initialize.ck
// Final Project: Please be kind!

//Technical/Code Point: Use of Machine.add() to launch files
// our conductor/beat-timer class
Machine.add(me.dir()+"/BPM.ck");

// a scale class to set the scale
Machine.add(me.dir()+"/Scale.ck");

//Adds score.ck
me.dir() + "/score.ck" => string scorePath;
Machine.add(scorePath);