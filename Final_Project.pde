  /*
  Khang
  Final Processing project
  Eating Contest: Bob grows every time he eats!
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

void drawMenu() {
  background(135, 206, 250);
  fill(255, 100, 50);
  textSize(42);
  text("EATING CONTEST", 300, 110);

  fill(255);
  textSize(19);
  text("Can you eat 20 items in 30 seconds?", 300, 150);

  if (Bob != null) {
    imageMode(CENTER);
    image(Bob, 300, 210, 100, 100);
    imageMode(CORNER);
  }

  fill(255, 180, 40);
  rect(200, 265, 200, 60, 15);

  fill(255);
  textSize(28);
  text("START!", 300, 295);
}

void drawGame() {
  background(135, 206, 235);

  timeLeft = 30 - (millis() - startTime) / 1000;

  fill(255);
  textSize(25);
  text("Score: " + score, 100, 35);
  text("Time: " + timeLeft, 500, 35);

  if (Bob != null) {
    imageMode(CENTER);
    image(Bob, 180, 200, bobSize, bobSize);
  }

  if (hamburger != null) {
    imageMode(CENTER);
    image(hamburger, 420, 200, 100, 100);
  }

  fill(255, 200, 50);
  rect(180, 300, 240, 50, 15);

  fill(0);
  textSize(20);
  text("Press SPACE to eat!", 300, 325);

  if (timeLeft <= 0) {
    if (score >= 20) {
      scene = 2;
    } else {
      scene = 3;
    }
  }
}

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

void drawRestartButton() {
  fill(50, 200, 70);
  rect(200, 310, 200, 60, 15);

  fill(255);
  textSize(25);
  text("PLAY AGAIN", 300, 340);
}

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

void startGame() {
  score = 0;
  timeLeft = 30;
  bobSize = 150;
  startTime = millis();
  scene = 1;
}
