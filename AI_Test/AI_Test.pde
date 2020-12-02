Dictionary keys;
int frameRate;
Ball[] balls;
Player[] players;
GeneticAlgorithm ga;
int generationNo;
int framesOneAlive;
boolean showBestPlayer;
BrainLogger brainLogger;

void setup() {
  size(800, 800);
  frameRate = 60;
  frameRate(frameRate);
  
  brainLogger = new BrainLogger("C:\\Users\\samgo\\OneDrive\\Desktop\\AI_Brains");
  
  keys = new Dictionary();
  keys.set(RIGHT, false);
  keys.set(LEFT, false);
  keys.set(UP, false);
  keys.set(DOWN, false);
  
  balls = new Ball[5];
  for(int i = 0;i < balls.length;i++) {
    balls[i] = new Ball();
  }
  
  players = new Player[50];
  for(int i = 0;i < players.length;i++) {
    players[i] = new Player(width/2, height/2);
    players[i].brain = new NeuralNetwork(players[i], brainLogger.uploadBrain("Best Brain.txt"));
  }
  
  ga = new GeneticAlgorithm();
  generationNo = 1;
  framesOneAlive = 0;
  showBestPlayer = false;
}

void keyPressed() {
  keys.set(keyCode, true);
}

void keyReleased() {
  if(key == 's') {
    if(showBestPlayer) {
      showBestPlayer = false;
    }
    else {
      showBestPlayer = true;
    }
  }
  else if(key == 'l') {
    brainLogger.downloadBrain(players[0].brain, "Weights & Biases.txt");
  }
  
  keys.set(keyCode, false);
}

void draw() {
  background(240);
  
  for(int i = 0;i < balls.length;i++) {
      balls[i].update();
  }
  
  for(int i = 0;i < players.length;i++) {
    if(!players[i].isDead) {  
      players[i].update();
    }
    
    //kill player if it's been still for 2 seconds
    if(players[i].framesStill > frameRate*2) { //&& generationNo < 200) {
      players[i].isDead = true;
    }
    
    //kill player if it's only been moving on a single axis for 4 seconds
    if(players[i].framesSameAxis > frameRate*4) { //&& generationNo < 200) {
      players[i].isDead = true;
    }
  }
  
  for(int i = 0;i < balls.length;i++) {
    balls[i].show();
  }
  
  if(showBestPlayer) {
    for(int i = 0;i < players[0].eyes.length;i++) {
      players[0].eyes[i].show();
    }
  }
  for(int i = players.length-1;i >= 0;i--) {
    players[i].show();
  }
  
  //Find how many players are dead and alive.
  int playersDead = 0;
  int playersAlive = 0;
  for(int i = 0;i < players.length;i++) {
    if(players[i].isDead) {
      playersDead += 1;
    }
    else {
      playersAlive += 1;
    }
  }
  
  fill(0);
  text("Players Alive: "+playersAlive, 20, 20);
  text("Players Dead: "+playersDead, 20, 40);
  text("Generation: "+generationNo, 160, 20);
  
  //if the last player remaining has been alive for 10 seconds, kill him.
  if(playersAlive == 1) {
    framesOneAlive++;
  }
  if(framesOneAlive > frameRate*10) {
    for(int i = 0;i < players.length;i++) {
      players[i].isDead = true;
    }
  }
  
  //Once all players are dead, make a new batch.
  if(playersAlive == 0) {
    generationNo++;
    framesOneAlive = 0;
    
    for(int i = 0;i < balls.length;i++) {
      balls[i] = new Ball();
    }
    
    NeuralNetwork[] parentBrains = ga.getBestBrains(players, 3); //number of parents
    NeuralNetwork[] childBrains = ga.breedBrains(parentBrains, players.length); //number of children (which should always be the number of players)
    NeuralNetwork[] mutatedBrains = ga.mutateBrains(childBrains, 0.4, 1); //rate of mutation, max magnitude of weight mutation
    
    //The brains of the parents move on to the next generation.
    for(int i = 0;i < parentBrains.length;i++) {
      mutatedBrains[i] = new NeuralNetwork(parentBrains[i]);
    }
    
    for(int i = 0;i < players.length;i++) {
      players[i] = new Player(width/2, height/2);
      players[i].brain = new NeuralNetwork(players[i], mutatedBrains[i]);
    }
    
    //Give the best players from the previous generation a different colour
    players[0].colour = color(255, 0, 255);
    for(int i = 1;i < parentBrains.length;i++) {
      players[i].colour = color(0, 0, 255);
    }
  }
}
