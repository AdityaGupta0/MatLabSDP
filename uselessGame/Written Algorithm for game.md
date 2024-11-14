# algorithm for game

Start program at welcome screen
wait until the user clicks the screen, once user clicks the screen change screen to level select screen
wait until user clicks on a level square
change screen to level background and overlay the level contents corresponding to the level square that was clicked
wait for user clicks
if the user clicks on a code block, add the code block to the below the lowest currently place code block in the editor and then go back to line 7
if the user clicks on the quit button, change screen to the level select screen and return to line 5
if the user clicks on the play button, run the program using the interpreter (jump to line 20)
if the user clicks the pause button, and if the program is running, stop the program and return to line 7
if the user clicks the reset button, reset the viewport and if the program is running stop the program and return to line 7
if user clicks the backspace button, delete the last block in the editor and its associated destination if applicable and return to line 7
if the user clicks on a jump, sub, add, or copy block that is in the editor section, wait for keyboard input 
if the user types 1, set register of block to ARG and go back to line 7
if user types 2, set register of the block to THIS and go back to line 7
if user types 3, set register of block to THAT and go back to line 7
if user types 4, set register of block to LOCAL and go back to line 7

# algorithm for interpreter
set the line incrementor to 1
got to the code block at the line = to line incrementor
if the code block is "inbox", put the topmost inbox value in the local register and remove that value from the inbox 
if the code block is "outbox", put the value in the local register into the lowest empty spot in the outbox and remove the value from the local register. 
if the code block is "copyto", if the local register is empty or there is not desitnation block, display program failed and jump to line 7. Otherwise copy the value in the local register to the destination 
if the code block is "copyfrom", if the destination block is not empty and the destination register has a value, copy the value from the desitnation register too the local register
if the code block is "Add", and if the desitnation register is not empty, replace the value in the destination register with a value that is 1 integer greater, unless the value is 25, in which case display program failed and jump to line 7
if the code block is "Sub", and if the desitnation register is not empty, replace the value in the destination register with a value that is 1 integer less, unless the value is -25, in which case display program failed and jump to line 7 
if the code block is "Jump", and if the destination register is not empty, set the line incrementor to the desitnation value subtracted by 1
if the code block is "Jump if neg", and if the value in the ARG register is negative, and if the destination register is not empty, set the line incrementor to the desitnation value subtracted by 1
if the code block is "Jump if zero", and if the value in the ARG register is zero, and if the destination register is not empty, set the line incrementor to the desitnation value subtracted by 1
go back to step 22 and add one to the line intrementor for the next code block unless the next block is null
check if inbox is empty, if not, go to line 29
check if all the outbox values match the expected outbox values, if so display level complete, if not display invalid outbox
return to line 7
