class GeneticAlgorithm {
  int getFitness(Player player) {
    return player.score;
  }
  
  NeuralNetwork[] getBestBrains(Player[] players, int brainsNo) {
    NeuralNetwork[] bestBrains = new NeuralNetwork[brainsNo];
    int[] fitnesses = new int[players.length];
    
    for(int i = 0;i < fitnesses.length;i++) {
      fitnesses[i] = getFitness(players[i]);
    }
    
    for(int i = 0;i < bestBrains.length;i++) {
      int maxFitness = 0;
      int maxFitnessIndex = -1;
      
      for(int n = 0;n < fitnesses.length;n++) {
        if(fitnesses[n] > maxFitness) {
          maxFitness = fitnesses[n];
          maxFitnessIndex = n;
        }
      }
      
      bestBrains[i] = new NeuralNetwork(players[maxFitnessIndex].brain);
      fitnesses[maxFitnessIndex] = 0;
    }
    
    return bestBrains;
  }
  
  NeuralNetwork[] breedBrains(NeuralNetwork[] parentBrains, int childrenNo) {
    NeuralNetwork[] childBrains = new NeuralNetwork[childrenNo];
    
    for(int i = 0;i < childBrains.length;i++) {
      childBrains[i] = new NeuralNetwork();
      
      for(int n = 0;n < childBrains[i].firstWeights.length;n++) {
        for(int m = 0;m < childBrains[i].firstWeights[n].length;m++) {
          childBrains[i].firstWeights[n][m] = parentBrains[(int)Math.floor(Math.random()*parentBrains.length)].firstWeights[n][m];
        }
      }
      
      for(int n = 0;n < childBrains[i].firstBiases.length;n++) {
        childBrains[i].firstBiases[n] = parentBrains[(int)Math.floor(Math.random()*parentBrains.length)].firstBiases[n];
      }
      
      for(int n = 0;n < childBrains[i].secondWeights.length;n++) {
        for(int m = 0;m < childBrains[i].secondWeights[n].length;m++) {
          childBrains[i].secondWeights[n][m] = parentBrains[(int)Math.floor(Math.random()*parentBrains.length)].secondWeights[n][m];
        }
      }
      
      for(int n = 0;n < childBrains[i].secondBiases.length;n++) {
        childBrains[i].secondBiases[n] = parentBrains[(int)Math.floor(Math.random()*parentBrains.length)].secondBiases[n];
      }
    }
    
    return childBrains;
  }
  
  NeuralNetwork[] mutateBrains(NeuralNetwork[] brains, float mutationRate, float weightMutationMag) {
    NeuralNetwork[] mutatedBrains = new NeuralNetwork[brains.length];
    
    for(int i = 0;i < mutatedBrains.length;i++) {
      mutatedBrains[i] = new NeuralNetwork();
      
      for(int n = 0;n < mutatedBrains[i].firstWeights.length;n++) {
        for(int m = 0;m < mutatedBrains[i].firstWeights[n].length;m++) {
          if(Math.random() < mutationRate) {
            mutatedBrains[i].firstWeights[n][m] = brains[i].firstWeights[n][m] + (float)Math.random()*(2*weightMutationMag)-weightMutationMag; 
            //randomly generate small change between -weightMutationMag and weightMutationMag
          }
          else {
            mutatedBrains[i].firstWeights[n][m] = brains[i].firstWeights[n][m]; 
            //not mutated
          }
        }
      }
      
      for(int n = 0;n < mutatedBrains[i].firstBiases.length;n++) {
        if(Math.random() < mutationRate) {
          mutatedBrains[i].firstBiases[n] = brains[i].firstBiases[n] + (float)Math.random()*2-1; 
          //randomly generate change between -1 and 1;
        }
        else {
          mutatedBrains[i].firstBiases[n] = brains[i].firstBiases[n];
        }
      }
      
      for(int n = 0;n < mutatedBrains[i].secondWeights.length;n++) {
        for(int m = 0;m < mutatedBrains[i].secondWeights[n].length;m++) {
          if(Math.random() < mutationRate) {
            mutatedBrains[i].secondWeights[n][m] = brains[i].secondWeights[n][m] + (float)Math.random()*(2*weightMutationMag)-weightMutationMag;
          }
          else {
            mutatedBrains[i].secondWeights[n][m] = brains[i].secondWeights[n][m];
          }
        }
      }
      
      for(int n = 0;n < mutatedBrains[i].secondBiases.length;n++) {
        if(Math.random() < mutationRate) {
          mutatedBrains[i].secondBiases[n] = brains[i].secondBiases[n] + (float)Math.random()*2-1;
        }
        else {
          mutatedBrains[i].secondBiases[n] = brains[i].secondBiases[n];
        }
      }
    }
    
    return mutatedBrains;
  }
}
