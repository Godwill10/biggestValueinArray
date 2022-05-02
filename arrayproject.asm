
# Author: Godwill Afolabi
# arrayproject.asm
#
# Creates a function which finds the largest value in an array of integers
#
# int largest( int* array, int arrayLength) {
#    int largest = array[0];
#    int index = 1;
#    while( index < arrayLength) {
#        if( array[index] > largest {
#            largest = array[index];
#        }
#        index++;
#    }
#    return( largest);
#}
#

.data
  array1:  .word   10, 49, -3, 52, 187, 88
  array2:  .word   -45, 65, 285, 2, 108, 93
  asize:   .word   6
  biggest:  .word   0
  largest:  .asciiz   "The largest number is "
  endst:  .asciiz   ".\n"


.text
main:
  # push the ra register to the stack
  addi $sp,  $sp,  -4
  sw   $ra,  0($sp)

  # Call the function by first putting the address of the array into $a0
  la   $a0,  array1
  lw   $a1,  asize
  jal  arrayLargest
  sw   $v0,  biggest          # Puts the answer out in main memory

  # Print out the answer
  la   $a0,  largest          # The address of the first letter of the string 'The sum is '
  addi $v0,  $zero, 4       # 4 prints a string
  syscall
  lw   $a0,  biggest          # put the value of interest into $a0
  addi $v0,  $zero, 1       # prepare to print an int
  syscall
  la   $a0,  endst          # The address of the first letter of the string
  addi $v0,  $zero, 4       # 4 prints a string
  syscall

  # restore the ra register to the stack
  lw   $ra,  0($sp)
  addi $sp,  $sp,  4
  jr   $ra

#Finds the largest values in the array
arrayLargest:
  # push registers to the stack
  addi $sp,  $sp,  -20
  sw   $ra,  0($sp)
  sw   $s0,  4($sp)
  sw   $s1,  8($sp)
  sw   $s2,  12($sp)
  sw   $s3,  16($sp)

  # put arguments into s registers
  addi $s0,  $a0,   0      # base address of array
  addi $s1,  $a1,   0      # size of array

  # initialize counter and sum to zero
  add  $s2,  $zero, $zero   # biggest
  add  $s3,  $zero, $zero   # index (counter)

  # loop to find the largest value
top:
  beq  $s1,  $s3,  exit     # exit if counter = size
  sll  $t0,  $s3,  2        # counter * 4 -> offset
  add  $t1,  $s0,  $t0      # t1 has base + offset
  lw   $t2,  0($t1)         # value from array into t2
  slt  $t3,  $s2, $t2       # checks if s2 is less than t2. t3=1 if true or t3=0 if false
  beq  $t3, 1, newLargest   # Goes to newLargest if t3 is equal to 1
  addi $s3, $s3, 1          # increment counter by 1
  j     top
newLargest:                 # setting a new biggest value if $s2 is less than $t2
  addi $s2,  $t2, 0
  j    top

exit:
  addi $v0,  $s2,  0        # sum into return register v0

# restore registers from the stack
lw   $ra,  0($sp)
lw   $s0,  4($sp)
lw   $s1,  8($sp)
lw   $s2,  12($sp)
lw   $s3,  16($sp)
addi $sp,  $sp,  20

jr   $ra                   # return to caller
