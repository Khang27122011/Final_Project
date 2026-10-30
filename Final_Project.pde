/*
Khang
Final Processing Project
Eating Contest
*/

int scene = 0;
int score = 0;
int timeLeft = 30;
int startTime;

PImage hamburger;
PImage Bob;

float bobSize = 150;
float growth = 5;

void setup() {
  size(600, 400);

  hamburger = loadImage("hamburger.png");
  Bob = loadImage("Bob.png");

  textAlign(CENTER, CENTER);
}

void draw() {
  if (scene == 0) {
    drawMenu();
  } else if (scene == 1) {
    drawGame();
  } else if (scene == 2) {
    drawWin();
  } else if (scene == 3) {
    drawLose();
  }
}

// DECORATED MENU
void drawMenu() {
  background(135, 206, 250);

  // Sun
  noStroke();
  fill(255, 220, 50);
  ellipse(520, 65, 70, 70);

  // Clouds
  drawCloud(100, 65);
  drawCloud(280, 75);
  drawCloud(420, 130);

  // Grass
  fill(80, 200, 100);
  rect(0, 340, 600, 60);

  // Decorative hamburgers
  drawFood(65, 190);
  drawFood(535, 200);
  drawFood(100, 285);
  drawFood(500, 290);

  // Title
  fill(255, 100, 50);
  textSize(42);
  text("EATING CONTEST", 300, 110);

  fill(255);
  textSize(19);
  text("Can you eat 20 items in 30 seconds?", 300, 150);

  // Bob
  if (Bob != null) {
    imageMode(CENTER);
    image(Bob, 300, 210, 100, 100);
    imageMode(CORNER);
  }

  // Start button
  fill(255, 180, 40);
  rect(200, 265, 200, 60, 15);

  fill(255);
  textSize(28);
  text("START!", 300, 295);

  fill(0);
  textSize(16);
  text("Click START to play", 300, 365);
}

void drawCloud(float x, float y) {
  noStroke();
  fill(255);
  ellipse(x, y, 50, 35);
  ellipse(x + 25, y - 10, 50, 45);
  ellipse(x + 50, y, 50, 35);
}

void drawFood(float x, float y) {
  noStroke();

  // Top bun
  fill(255, 180, 60);
  arc(x, y, 45, 30, PI, TWO_PI);

  // Lettuce
  fill(70, 200, 70);
  rect(x - 22, y, 44, 6);
}

// GAME SCREEN
void drawGame() {
  background(135, 206, 235);

  timeLeft = 30 - (millis() - startTime) / 1000;

  fill(255);
  textSize(25);
  text("Score: " + score, 100, 35);
  text("Time: " + timeLeft, 500, 35);

  // Bob grows as he eats
  if (Bob != null) {
    imageMode(CENTER);
    image(Bob, 180, 200, bobSize, bobSize);
  }

  // Hamburger stays the same size
  if (hamburger != null) {
    imageMode(CENTER);
    image(hamburger, 420, 200, 100, 100);
  }

  imageMode(CORNER);

  // Eat button instructions
  fill(255, 200, 50);
  rect(180, 300, 240, 50, 15);

  fill(0);
  textSize(20);
  text("Press SPACE to eat!", 300, 325);

  // Check game result
  if (timeLeft <= 0) {
    if (score >= 20) {
      scene = 2;
    } else {
      scene = 3;
    }
  }
}

// WIN SCREEN
void drawWin() {
  background(80, 220, 120);

  fill(255);
  textSize(40);
  text("YOU WIN!", 300, 80);

  textSize(25);
  text("You ate " + score + " items!", 300, 125);

  if (Bob != null) {
    imageMode(CENTER);
    image(Bob, 300, 220, bobSize, bobSize);
    imageMode(CORNER);
  }

  drawRestartButton();
}

// GAME OVER SCREEN
void drawLose() {
  background(100, 140, 230);

  fill(255);
  textSize(40);
  text("GAME OVER", 300, 80);

  textSize(25);
  text("You ate " + score + " items!", 300, 125);

  if (Bob != null) {
    imageMode(CENTER);
    image(Bob, 300, 220, bobSize, bobSize);
    imageMode(CORNER);
  }

  drawRestartButton();
}

// RESTART BUTTON
void drawRestartButton() {
  fill(50, 200, 70);
  rect(200, 310, 200, 60, 15);

  fill(255);
  textSize(25);
  text("PLAY AGAIN", 300, 340);
}

// MOUSE CONTROLS
void mousePressed() {
  // Start game
  if (scene == 0) {
    if (mouseX > 200 && mouseX < 400 &&
        mouseY > 265 && mouseY < 325) {
      startGame();
    }
  }

  // Restart game
  else if (scene == 2 || scene == 3) {
    if (mouseX > 200 && mouseX < 400 &&
        mouseY > 310 && mouseY < 370) {
      startGame();
    }
  }
}

// KEYBOARD CONTROLS
void keyReleased() {
  if (scene == 1 && key == ' ' && timeLeft > 0) {
    score++;

    // Only Bob gets bigger
    bobSize = bobSize + growth;

    // Maximum Bob size
    if (bobSize > 250) {
      bobSize = 250;
    }
  }
}

// START OR RESTART GAME
void startGame() {
  score = 0;
  timeLeft = 30;
  bobSize = 150;
  startTime = millis();
  scene = 1;
}
