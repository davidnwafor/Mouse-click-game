//SoundFile file - Lab 3
import ddf.minim.analysis.*;
import ddf.minim.*;
Minim        minim;
AudioPlayer music; // Background music
AudioPlayer correct; // audio for when a shape is clicked
AudioPlayer incorrect; // audio for when player loses a life
AudioPlayer lose; // audio for when all lives a lost
AudioPlayer win; // audio for when user wins

PImage scene; // info about background stored - Lab3

int totalLife = 3; // Set the number of lives from the start to 3
int phaseLevel = 1; // Set starting phase to 1
int totalshapes = 0; // Set total of shapes user has clicked on to 0

float s1 = 1101; // start location of square
float c1 = 1101; // start location of circle
float t1 = 1201; // start location of triangle x1
float t2 = 1101; // start location of triangle x2
float t3 = 1301; // start location of triangle x3

float colour1 = (int)random(255); // denote a random colour for 1
float colour2 = (int)random(255); // denote a random colour for 2
float colour3 = (int)random(255); // denote a random colour for 3

float speed1p1 = random(1,3); // choose a speed for speed1 between 1 and 3 in phase 1
float speed2p1 = random(1,3); // choose a speed for speed2 between 1 and 3 in phase 1
float speed3p1 = random(1,3); // choose a speed for speed3 between 1 and 3 in phase 1

float speed1p2 = random(3,5); // choose a speed for speed1 between 3 and 5 in phase 2
float speed2p2 = random(3,5); // choose a speed for speed2 between 3 and 5 in phase 2
float speed3p2 = random(3,5); // choose a speed for speed3 between 3 and 5 in phase 2

float p3speed = 6; // speed in in phase 3 is 6

int exitGame = 0; // exits game when set to 1 - Lab3

boolean gameNotLost = true; // Used for switching background music and game lost audio
boolean gameNotWon = true; // Used for switching background music and game won audio

void setup()
{
  size(1000,1000); // set up background size
  
  minim = new Minim(this); // Load background music and play - Lab3
  music = minim.loadFile("Touhou.wav");
  music.play();
  
  scene = loadImage("scene.jpg"); // Load background image - Lab3
  
  println("Phase 1 speed of square is: " + speed1p1); // Print out all speeds of all shapes
  println("Phase 1 speed of circle is: " + speed2p1);
  println("Phase 1 speed of triangle is: " + speed3p1);
  println("Phase 2 speed of square is: " + speed1p2);
  println("Phase 2 speed of circle is: " + speed2p2);
  println("Phase 2 speed of triangle is: " + speed3p2);
}

void draw()
{
  background(scene); // clear background every frame
  s1 = s1 - speed1p1; // speed of square
  fill(colour1,colour2,colour3); // Colour of square
  rect(s1,400,150,150); // draw square
  
  if (s1 < -150) // when square passes screen
  {
    totalLife = totalLife - 1; // Decrease life counter by 1
    s1 = 1101; // Reposition square
    incorrect = minim.loadFile("wrong.wav"); // Load and play audio
    incorrect.play();
  }
  
  c1 = c1 - speed2p1; // speed of circle
  fill(colour3,colour1,colour2); // Colour of circle
  ellipse(c1,150,150,150); // draw circle
  
  if (c1 < -150) // when circle passes screen
  {
    totalLife = totalLife - 1; // Decrease life counter by 1
    c1 = 1101; // Reposition circle
    incorrect = minim.loadFile("wrong.wav"); // Load and play audio
    incorrect.play();
  }
  
  t1 = t1 - speed3p1; // speed of triangle
  t2 = t2 - speed3p1; // speed of triangle
  t3 = t3 - speed3p1; // speed of triangle
  fill(colour1,colour3,colour2); // Colour of triangle
  triangle(t1,700,t2,850,t3,850); // Draw triangle
  
  if (t3 < 0) // when triangle passes screen
  {
    totalLife = totalLife - 1; // Decrease life counter by 1
    t1 = 1201; // Reposition triangle
    t2 = 1101; // Reposition triangle
    t3 = 1301; // Reposition triangle
    incorrect = minim.loadFile("wrong.wav"); // Load and play audio
    incorrect.play();
  }
  
  if (totalshapes == 33) // When the user has clicked on 33 shapes
  {
    phaseLevel = 2; // They proceed to play in Phase 2
  }
  
  if (phaseLevel == 2) // When user is in Phase 2
  {
    s1 = s1 - speed1p2; // new speed of square
    c1 = c1 - speed2p2; // new speed of circle
    t1 = t1 - speed3p2; // new speed of triangle
    t2 = t2 - speed3p2; // new speed of triangle
    t3 = t3 - speed3p2; // new speed of triangle
  }
  
  if (totalshapes == 67) // When the user has clicked on at least 67 shapes
  {
    phaseLevel = 3; // They proceed to play in Phase 3
  }
  
  if (phaseLevel == 3) // When user is in Phase 3
  {
    s1 = s1 - p3speed; // new speed of square
    c1 = c1 - p3speed; // new speed of circle
    t1 = t1 - p3speed; // new speed of triangle
    t2 = t2 - p3speed; // new speed of triangle
    t3 = t3 - p3speed; // new speed of triangle
  }
  
  // Text information
  textSize(35);
  fill(255,255,255);
  text("Lives: " + totalLife, 140, 36); // Display current life count
  
  textSize(35);
  fill(255,255,255);
  text("Phase: " + phaseLevel, 385, 36); // Display current Phase level
  
  textSize(35);
  fill(255,255,255);
  text("Completion: " + totalshapes + "%", 610, 36); // Display how close the user is from completing the game
  
  if (exitGame == 0) // While game is in playable state
  {
    textSize(35);
    fill(255,255,255);
    text("Click on all the shapes before they pass the screen!", 130, 980); // Display aim of the game
  }
  
  if (totalLife < 1) // When all lives are lost
  {
    exitGame = 1; // allow Failure screen to be displayed (Gotten from Lab3)
  }
  
  if (exitGame == 1) // When player loses
  {
    if(gameNotLost) 
    {
      music.pause(); // Pause background music
      incorrect.rewind(); // Stops live lost audio from overlapping with game lost audio
      incorrect.pause();
      if (totalshapes > 0) // Incase user does not click on a shape at all
      {
        correct.rewind(); // Stops audio from overlapping
        correct.pause();
      }
      lose = minim.loadFile("loss.wav"); // Load and play sound for when player loses
      lose.play();
      gameNotLost = false;
    }
    totalLife = 0; // Ensure Life counter is set to 0 incase more than one shape passes the screen
    textSize(150);
    fill(255,255,255);
    text("FAILURE", 230, 500); // Show Failure screen
    textSize(40);
    fill(255,255,255);
    text("Press R to Restart or E to Exit", 250, 590);
    s1 = 1101; // Reposition square so user can't see or click it
    s1 = s1 + 1; // Reverse direction
    c1 = 1101; // Reposition circle so user can't see or click it
    c1 = c1 + 1; // Reverse direction
    t1 = 1201; // Reposition triangle so user can't see or click it
    t1 = t1 + 1; // Reverse direction
    t2 = 1101;
    t2 = t2 + 1;
    t3 = 1301;
    t3 = t3 + 1;
  }
 
  if (totalshapes == 100) // When the user has clicked on 100 shapes
  {
    exitGame = 2; // allow Success screen to be displayed
  }
  
  if (exitGame == 2) // when player wins
  {
    if (gameNotWon)
    {
      music.pause(); // Pause background music
      correct.rewind(); // Stops audio from overlapping
      correct.pause();
      if (totalLife < 3) // Incase user does not lose a life
      {
        incorrect.rewind(); // Stops live lost audio from overlapping with game lost audio
        incorrect.pause();
      }
      win = minim.loadFile("victory.wav"); // Load and play sound for win screen
      win.play();
      gameNotWon = false;
    }
    textSize(150);
    fill(255,255,255);
    text("SUCCESS", 210, 500); // Show Failure screen
    textSize(40);
    fill(255,255,255);
    text("Press R to Restart or E to Exit", 250, 590);
    s1 = 1101; // Reposition square so user can't see or click it
    s1 = s1 + 1; // Reverse direction
    c1 = 1101; // Reposition circle so user can't see or click it
    c1 = c1 + 1; // Reverse direction
    t1 = 1201; // Reposition triangle so user can't see or click it
    t1 = t1 + 1; // Reverse direction
    t2 = 1101;
    t2 = t2 + 1;
    t3 = 1301;
    t3 = t3 + 1;
  }
}
   
void mousePressed()
{
  float epsilon = 0.05; // allows for margin of error, https://forum.processing.org/two/discussion/20887/collision-detection-why-not-working-properly
  float areaOriginal = abs((t2 - t1) * (850 - 700) - (t3 - t1) * (850 - 700)); // Original area of triangle, https://www.jeffreythompson.org/collision-detection/tri-point.php
  float area1 = abs(((t1 - mouseX) * (850 - mouseY)) - ((t2 - mouseX) * (700 - mouseY))); // Area 1
  float area2 = abs(((t2 - mouseX) * (850 - mouseY)) - ((t3 - mouseX) * (850 - mouseY))); // Area 2
  float area3 = abs(((t3 - mouseX) * (700 - mouseY)) - ((t1 - mouseX) * (850 - mouseY))); // Area 3

  if (mouseX > s1 && mouseX < s1 + 150 && mouseY > 400 && mouseY < 550) // When mouse is clicked on square
  {
    totalshapes = totalshapes + 1; // Increase total shapes by one
    s1 = 1101; // Reposition square
    correct = minim.loadFile("correct.wav"); // Load and play audio
    correct.play();
  }
  if (dist(mouseX, mouseY, c1, 150) < 75) // When mouse is clicked on circle
  {
    totalshapes = totalshapes + 1; // Increase total shapes by one
    c1 = 1101; // Reposition circle
    correct = minim.loadFile("correct.wav"); // Load and play audio
    correct.play();
  }
 
  if ((area1 + area2 + area3) - areaOriginal < epsilon) // When triangle is clicked, https://www.jeffreythompson.org/collision-detection/tri-point.php
  {
    totalshapes = totalshapes + 1; // Increase total shapes by one
    t1 = 1201; // Reposition triangle
    t2 = 1101; // Reposition triangle
    t3 = 1301; // Reposition triangle
    correct = minim.loadFile("correct.wav"); // Load and play audio
    correct.play();
  }
}

void keyPressed()
{
  if (exitGame == 1 || exitGame == 2) // Only when the user wins or loses
  {
    if ((key == 'r') || (key == 'R')) // If user presses the key r the game resets
    {
      if (gameNotLost == false) // Check to see if game lost music is playing and stop it
      {
        lose.rewind();
        lose.pause();
      }
      if (gameNotWon == false) // Check to see if game won music is playing and stop it
      {
        win.rewind();
        win.pause();
      }
      music.rewind(); // Restart background music
      music.play();
      gameNotLost = true;
      gameNotWon = true;
      exitGame = 0; // game is in playable state
      totalLife = 3; // Lives are back to 5
      phaseLevel = 1; // User starts back in Phase 1
      totalshapes = 0; // Shape counter resets
      s1 = 1101; // The following shapes are repositioned and their speeds are set back to Phase 1
      s1 = s1 - speed1p1;
      c1 = 1101;
      c1 = c1 - speed2p1;
      t1 = 1201;
      t1 = t1 - speed3p1;
      t2 = 1101;
      t2 = t2 - speed3p1;
      t3 = 1301;
      t3 = t3 - speed3p1;
      }
    if ((key == 'e') || (key == 'E')) // If user presses E the game exits
    {
      exit();
    }
  }
}
