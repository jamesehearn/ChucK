// initialize.ck
// Assignment_6_Magic_Jazz_Band
<<< "Assignment_6_Magic_Jazz_Band initialize" >>>;

// Something new will go here next week

// Add score file
<<< "Dir" + me.dir() >>>;
me.dir() + "/score.ck" => string score;
Machine.add(score);
<<< "done:" + score >>>;