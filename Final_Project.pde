
import processing.sound.*;

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
PImage pizza;
PImage coke;
PImage Bob;
PImage BobFat;

SoundFile backgroundSound;

float bobSize = 150;
float growth = 8;

void setup() {
  size(600, 400);

  hamburger = loadImage("hamburger.png");
  pizza = loadImage("pizza.png");
  coke = loadImage("coke.png");
  Bob = loadImage("Bob.png");
  BobFat = loadImage("BobFat.png");

  backgroundSound = new SoundFile(this, "cartoon_bite_sound_effect.mp3");

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

  drawCloud(100, 65);
  drawCloud(280, 75);
  drawCloud(420, 130);

  fill(80, 200, 100);
  rect(0, 340, 600, 60);

  drawFood(65, 190);
  drawFood(535, 200);
  drawFood(100, 285);
  drawFood(500, 290);

  fill(255, 100, 50);
  textSize(42);
  text("EATING CONTEST", 300, 110);

  fill(255);
  textSize(19);
  text("Can you eat 30 items in 30 seconds?", 300, 150);

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

  fill(255, 180, 60);
  arc(x, y, 45, 30, PI, TWO_PI);

  fill(70, 200, 70);
  rect(x - 22, y, 44, 6);

  fill(120, 65, 30);
  rect(x - 22, y + 6, 44, 7);

  fill(255, 180, 60);
  rect(x - 22, y + 13, 44, 7);
}

void drawGame() {
  background(135, 206, 235);

  timeLeft = 30 - (millis() - startTime) / 500;

  fill(255);
  textSize(25);
  text("Score: " + score, 100, 35);
  text("Time: " + timeLeft, 500, 35);

  imageMode(CENTER);

  if (score >= 30) {
    if (BobFat != null) {
      image(BobFat, 180, 200, bobSize, bobSize);
    }
  } else {
    if (Bob != null) {
      image(Bob, 180, 200, 150, 150);
    }
  }

  if (hamburger != null) {
    image(hamburger, 360, 200, 80, 80);
  }

  if (pizza != null) {
    image(pizza, 450, 200, 80, 80);
  }

  if (coke != null) {
    image(coke, 535, 200, 65, 90);
  }

  imageMode(CORNER);

  fill(255, 200, 50);
  rect(180, 300, 240, 50, 15);

  fill(0);
  textSize(20);
  text("Press SPACE to eat!", 300, 325);

  if (timeLeft <= 0) {
    if (score >= 30) {
      scene = 2;
    } else {
      scene = 3;
    }
  }
}

void drawWin() {
  background(135, 206, 250);

  drawCloud(80, 70);
  drawCloud(420, 65);


  fill(80, 200, 100);
  rect(0, 340, 600, 60);

  drawFood(80, 290);
  drawFood(520, 290);

  fill(255, 150, 20);
  textSize(45);
  text("YOU WIN!", 300, 55);

  fill(255);
  textSize(22);
  text("Amazing! You ate " + score + " items!", 300, 100);

  imageMode(CENTER);

  if (score >= 30 && BobFat != null) {
    image(BobFat, 300, 215, 170, 170);
  } else if (Bob != null) {
    image(Bob, 300, 215, 130, 130);
  }

  imageMode(CORNER);

  drawRestartButton();
}

void drawLose() {
  background(135, 206, 250);

  drawCloud(80, 70);
  drawCloud(420, 65);

  fill(80, 200, 100);
  rect(0, 340, 600, 60);

  drawFood(80, 290);
  drawFood(520, 290);

  fill(255, 70, 70);
  textSize(43);
  text("GAME OVER!", 300, 55);

  fill(255);
  textSize(22);
  text("You ate " + score + " items!", 300, 100);

  fill(255, 255, 100);
  textSize(18);
  text("Try again and reach 30!", 300, 130);

  imageMode(CENTER);

  if (score >= 30 && BobFat != null) {
    image(BobFat, 300, 215, 170, 170);
  } else if (Bob != null) {
    image(Bob, 300, 215, 130, 130);
  }

  imageMode(CORNER);

  drawRestartButton();
}

void drawRestartButton() {
  noStroke();
  fill(40, 140, 60);
  rect(205, 310, 200, 60, 15);

  fill(50, 200, 70);
  rect(200, 305, 200, 60, 15);

  fill(255);
  textSize(25);
  text("PLAY AGAIN", 300, 335);
}

void mousePressed() {
  if (scene == 0) {
    if (mouseX > 200 && mouseX < 400 &&
        mouseY > 265 && mouseY < 325) {
      startGame();
    }
  } else if (scene == 2 || scene == 3) {
    if (mouseX > 200 && mouseX < 400 &&
        mouseY > 305 && mouseY < 370) {
      startGame();
    }
  }
}

void keyReleased() {
  if (scene == 1 && key == ' ' && timeLeft > 0) {
    score++;

    if (backgroundSound != null) {
      backgroundSound.play();
    }

    // Bob grows after reaching 30 points
    if (score >= 30) {
      bobSize = bobSize + growth;

      if (bobSize > 300) {
        bobSize = 300;
      }
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
