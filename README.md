# biggestValueinArray

 Author: Godwill Afolabi
 arrayproject.asm

 Creates a function which finds the largest value in an array of integers

 int largest( int* array, int arrayLength) {
    int largest = array[0];
    int index = 1;
    while( index < arrayLength) {
        if( array[index] > largest {
            largest = array[index];
        }
        index++;
    }
    return( largest);
}
