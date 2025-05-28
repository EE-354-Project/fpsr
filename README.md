# First Person, Second Row

## Game Description

**First Person, Second Row** is a game in which you play as a student attending a lecture in a crowded classroom, led by a professor. Your objective is to complete all assigned tasks (represented as mini-games) or endure half the lecture duration to leave the room and win. However, you must leave the classroom before the lecture ends with at least 1 life remaining to win.

Throughout the game, the professor may randomly call on you with a question. If you fail to answer correctly within the allotted time, or if you're caught moving out of your seat when called upon, you lose one of your three lives.

## FPGA Board Integration (Xilinx Artix-7)

### Seven-Segment Displays (SSDs)

All 8 SSDs on the board are actively used:

| SSD Position  | Function                                                                                                                |
| ------------- | ----------------------------------------------------------------------------------------------------------------------- |
| Leftmost 3    | Game completion indicators. Each one lights up when a game is completed, acting like checkmarks.                        |
| 4th from left | Displays the number of games completed.                                                                                 |
| 5th from left | Displays the number of quizzes completed.                                                                               |
| 6th from left | Displays remaining lives (out of 3).                                                                                    |
| Rightmost 2   | Show elapsed class time in hexadecimal. The time increments approximately every 2.6 seconds (modifiable via `DIV_CLK`). |

### LEDs

LEDs indicate current game state and provide visual debugging support:

| LED  | Purpose                                                                          |
| ---- | -------------------------------------------------------------------------------- |
| Ld0  | Lights up when the player is in the IDLE state or during the first quiz.         |
| Ld1  | On when the player is in GAME1 or answering Quiz 2.                              |
| Ld2  | On during GAME2 or Quiz 3.                                                       |
| Ld3  | On during GAME3.                                                                 |
| Ld4  | Indicates progress in Stage 1 of any game.                                       |
| Ld5  | Indicates progress in Stage 2 of any game.                                       |
| Ld6  | Indicates progress in Stage 3 (final step) of any game.                          |
| Ld7  | Lights up in any QUIZ state (Quiz, Quiz1, Quiz2, or Quiz3).                      |
| Ld14 | Turns on when the MOVE state is active or the seat sensor (`seat`) is triggered. |

### Buttons

Directional buttons are used to move the character around the screen in search of another seat. The center button (`BtnC`) serves multiple purposes, including resetting the game, acknowledging events, and submitting answers.

### Switches

Switches are used in combination with buttons to answer quiz questions. One switch also controls movement, which becomes available only after either:

- All three games are completed, or
- Half the class time has elapsed.

### VGA Display

Sprites and their pixel data are stored in dedicated Verilog ROM files. The game controller processes the positional and state data for all sprites, which is then rendered by the VGA modules to display the classroom environment and gameplay on the screen.

---

This FPGA-based project combines digital design, state machines, and visual outputs to simulate an immersive and reactive lecture hall scenario. It integrates real-time inputs and challenges through mini-games and timed quizzes, rewarding attentiveness and task completion.
