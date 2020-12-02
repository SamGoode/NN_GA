import java.io.FileWriter;
import java.util.Scanner;

class BrainLogger {
  String filePath;
  
  BrainLogger(String filePath) {
    this.filePath = filePath;
  }
  
  NeuralNetwork uploadBrain(String fileName) {
    NeuralNetwork brain = new NeuralNetwork();
    String fileString = "";
    try {
      File NNFile = new File(filePath+"\\"+fileName);
      Scanner NNFileReader = new Scanner(NNFile);
      
      while(NNFileReader.hasNextLine()) {
        fileString += NNFileReader.nextLine()+"\n";
      }
      NNFileReader.close();
    }
    catch(Exception e) {
      print("An error occurred");
    }
    
    fileString = fileString.replace("Weights between input layer and hidden layer:\n", "");
    fileString = fileString.replace("\nBiases for hidden layer:\n", "spacing");
    fileString = fileString.replace("\nWeights between hidden layer and output layer:\n", "spacing");
    fileString = fileString.replace("\nBiases for output layer:\n", "spacing");
    
    String[] fileStringArray = fileString.split("spacing");
    
    String[] firstWeightsLines = fileStringArray[0].split("\n");
    for(int i = 0;i < brain.firstWeights.length;i++) {
      for(int n = 0;n < brain.firstWeights[i].length;n++) {
        brain.firstWeights[i][n] = Float.valueOf(firstWeightsLines[i].split(" ")[n]);
      }
    }
    
    for(int i = 0;i < brain.firstBiases.length;i++) {
      brain.firstBiases[i] = Float.valueOf(fileStringArray[1].split(" ")[i]);
    }
    
    String[] secondWeightsLines = fileStringArray[2].split("\n");
    for(int i = 0;i < brain.secondWeights.length;i++) {
      for(int n = 0;n < brain.secondWeights[i].length;n++) {
        brain.secondWeights[i][n] = Float.valueOf(secondWeightsLines[i].split(" ")[n]);
      }
    }
    
    for(int i = 0;i < brain.secondBiases.length;i++) {
      brain.secondBiases[i] = Float.valueOf(fileStringArray[3].split(" ")[i]);
    }
    
    return brain;
  }
  
  void downloadBrain(NeuralNetwork brain, String fileName) {
    try {
      File NNFile = new File(filePath+"\\"+fileName);
      boolean newFileCreated = false;
      int fileNo = 0;
      
      while(!newFileCreated) {
        if(NNFile.createNewFile()) {
          print("New file created\n");
          newFileCreated = true;
        }
        else {
          fileNo++;
          String fileNameNo = fileName.split(".txt")[0]+" ("+fileNo+").txt";
          NNFile = new File(filePath+"\\"+fileNameNo);
        }
      }
      
      FileWriter NNFileWriter = new FileWriter(NNFile.getAbsolutePath());
      
      print("Writing in file\n");
      
      NNFileWriter.write("Weights between input layer and hidden layer:\n");
      for(int i = 0;i < brain.firstWeights.length;i++) {
        for(int n = 0;n < brain.firstWeights[i].length;n++) {
          String weight = Float.toString(brain.firstWeights[i][n]);
          NNFileWriter.write(weight+" ");
        }
        NNFileWriter.write("\n");
      }
      
      NNFileWriter.write("\nBiases for hidden layer:\n");
      for(int i = 0;i < brain.firstBiases.length;i++) {
        String bias = Float.toString(brain.firstBiases[i]);
        NNFileWriter.write(bias+" ");
      }
      
      NNFileWriter.write("\n\nWeights between hidden layer and output layer:\n");
      for(int i = 0;i < brain.secondWeights.length;i++) {
        for(int n = 0;n < brain.secondWeights[i].length;n++) {
          String weight = Float.toString(brain.secondWeights[i][n]);
          NNFileWriter.write(weight+" ");
        }
        NNFileWriter.write("\n");
      }
      
      NNFileWriter.write("\nBiases for output layer:\n");
      for(int i = 0;i < brain.secondBiases.length;i++) {
        String bias = Float.toString(brain.secondBiases[i]);
        NNFileWriter.write(bias+" ");
      }
      
      NNFileWriter.close();
    }
    catch(IOException e) {
      print("IOException Error\n");
    }
  }
}
