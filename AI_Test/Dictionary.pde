class Dictionary {
  int[] keys = new int[0];
  Boolean[] values = new Boolean[0];
  
  int[] intArrayAdd(int[] array, int newElement) {
    int[] newArray = new int[array.length+1];
    
    for(int i = 0;i < array.length;i++) {
      newArray[i] = array[i];
    }
    
    newArray[array.length] = newElement;
    return newArray;
  }
  
  Boolean[] booleanArrayAdd(Boolean[] array, Boolean newElement) {
    Boolean[] newArray = new Boolean[array.length+1];
    
    for(int i = 0;i < array.length;i++) {
      newArray[i] = array[i];
    }
    
    newArray[array.length] = newElement;
    return newArray;
  }
  
  void add(int key, Boolean value) {
    keys = intArrayAdd(keys, key);
    values = booleanArrayAdd(values, value);
  }
  
  void set(int key, Boolean newValue) {
    int keyIndex;
    keyIndex = -1;
    
    for(int i = 0;i < keys.length;i++) {
      if(keys[i] == key) {
        keyIndex = i;
      }
    }
    
    if(keyIndex == -1) {
      keys = intArrayAdd(keys, key);
      values = booleanArrayAdd(values, newValue);
      return;
    }
    
    values[keyIndex] = newValue;
  }
  
  Boolean getValue(int key) {
    int keyIndex;
    keyIndex = -1;
    
    for(int i = 0;i < keys.length;i++) {
      if(keys[i] == key) {
        keyIndex = i;
      }
    }
    
    if(keyIndex == -1) {
      print(key + " is not in dictionary.");
    }
    
    return values[keyIndex];
  }
}
