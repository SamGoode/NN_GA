class NeuralNetwork {
  Player agent;
  float[] inputNeurons = new float[8];
  
  float[][] firstWeights = new float[8][8];
  float[] firstBiases = new float[8];
  float[] hiddenNeurons = new float[8];
  
  float[][] secondWeights = new float[4][8];
  float[] secondBiases = new float[4];
  float[] outputNeurons = new float[4];
  
  NeuralNetwork(Player owner, NeuralNetwork brain) {
    this.agent = owner;
    
    for(int i = 0;i < this.firstWeights.length;i++) {
      for(int n = 0;n < this.firstWeights[i].length;n++) {
        this.firstWeights[i][n] = brain.firstWeights[i][n];
      }
    }
    for(int i = 0;i < this.firstBiases.length;i++) {
      this.firstBiases[i] = brain.firstBiases[i];
    }
    
    for(int i = 0;i < this.secondWeights.length;i++) {
      for(int n = 0;n < this.secondWeights[i].length;n++) {
        this.secondWeights[i][n] = brain.secondWeights[i][n];
      }
    }
    for(int i = 0;i < this.secondBiases.length;i++) {
      this.secondBiases[i] = brain.secondBiases[i];
    }
  }
  
  NeuralNetwork(NeuralNetwork brain) {
    for(int i = 0;i < this.firstWeights.length;i++) {
      for(int n = 0;n < this.firstWeights[i].length;n++) {
        this.firstWeights[i][n] = brain.firstWeights[i][n];
      }
    }
    for(int i = 0;i < this.firstBiases.length;i++) {
      this.firstBiases[i] = brain.firstBiases[i];
    }
    
    for(int i = 0;i < this.secondWeights.length;i++) {
      for(int n = 0;n < this.secondWeights[i].length;n++) {
        this.secondWeights[i][n] = brain.secondWeights[i][n];
      }
    }
    for(int i = 0;i < this.secondBiases.length;i++) {
      this.secondBiases[i] = brain.secondBiases[i];
    }
  }
  
  NeuralNetwork(Player owner) {
    agent = owner;
    
    for(int i = 0;i < firstWeights.length;i++) {
      for(int n = 0; n < firstWeights[i].length;n++) {
        firstWeights[i][n] = (float)Math.random()*2-1;
      }
    }
    
    for(int i = 0;i < firstBiases.length;i++) {
      firstBiases[i] = (float)Math.random()*16-8;
    }
    
    for(int i = 0;i < secondWeights.length;i++) {
      for(int n = 0; n < secondWeights[i].length;n++) {
        secondWeights[i][n] = (float)Math.random()*2-1;
      }
    }
    
    for(int i = 0;i < secondBiases.length;i++) {
      secondBiases[i] = (float)Math.random()*16-8;
    }
  }
  
  NeuralNetwork() {
    
  }
  
  float sigmoid(float x) {
    return 1/(1+exp(-x));
  }
  
  void update() {
    for(int i = 0;i < agent.eyes.length;i++) {
      inputNeurons[i] = agent.eyes[i].getDist()/400;
    }
    
    for(int i = 0;i < hiddenNeurons.length;i++) {
      float weightedSum = 0;
      
      for(int n = 0;n < firstWeights[i].length;n++) {
        weightedSum += firstWeights[i][n]*inputNeurons[n];
      }
      
      hiddenNeurons[i] = sigmoid(weightedSum + firstBiases[i]);
    }
    
    for(int i = 0;i < outputNeurons.length;i++) {
      float weightedSum = 0;
      
      for(int n = 0;n < secondWeights[i].length;n++) {
        weightedSum += secondWeights[i][n]*hiddenNeurons[n];
      }
      
      outputNeurons[i] = sigmoid(weightedSum + secondBiases[i]);
    }
  }
  
  void show() {
    for(int i = 0;i < inputNeurons.length;i++) {
      fill(0);
      text("inputNeuron "+(i+1)+": "+inputNeurons[i], 25, i*25+600);
    }
    
    for(int i = 0;i < hiddenNeurons.length;i++) {
      fill(0);
      text("hiddenNeuron "+(i+1)+": "+hiddenNeurons[i], 225, i*25+600);
    }
    
    for(int i = 0;i < outputNeurons.length;i++) {
      fill(0);
      text("outputNeuron "+(i+1)+": "+outputNeurons[i], 425, i*25+600);
    }
  }
}
