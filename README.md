# Brick-Breaker-Assembly

This project is a classic Brick Breaker game developed in Assembly language. It runs on DOSBox, an x86 emulator with DOS.

## Table of Contents

- [Introduction](#introduction)
- [Features](#features)
- [Installation](#installation)
- [Usage](#usage)
- [To-Do](#to-do)
- [Contributing](#contributing)
- [License](#license)

## Introduction

Brick Breaker is a game where the player controls a paddle to hit a ball towards a wall of bricks. The goal is to destroy all the bricks by bouncing the ball off the paddle and into the bricks. The game ends when all bricks are destroyed or the ball falls below the paddle.

This project is written in Assembly language, which provides a unique challenge and learning experience. It runs on DOSBox, an x86 emulator with DOS, making it accessible on modern operating systems.

## Features

- Paddle movement using keyboard controls.
- Ball movement and collision with walls and paddle.
- Simple graphics rendered in a DOS environment.

## Installation

To run this game, you need DOSBox installed on your computer. Follow these steps to set it up:

1. **Download and Install DOSBox:**
   - [DOSBox Download](https://www.dosbox.com/download.php?main=1)

2. **Clone the Repository:**
    ```sh
    git clone https://github.com/yourusername/Brick-Breaker-Assembly.git
    cd Brick-Breaker-Assembly
    ```

3. **Compile the Assembly Code:**
   - You need an assembler like NASM or MASM to compile the code.
   - For NASM:
     ```
     nasm -f bin brick_breaker.asm -o brick_breaker.com
     ```

4. **Run the Game in DOSBox:**
   - Open DOSBox.
   - Mount the game directory:
     ```sh
     mount c /path/to/Brick-Breaker-Assembly
     c:
     ```
   - Run the game:
     ```sh
     brick_breaker.com
     ```

## Usage

- **Controls:**
  - Use the arrow keys to move the paddle left and right.
  - Press `P` to pause and resume the game.
  - Press `Q` to exit the game.

- **Objective:**
  - The objective of the game is to destroy all the bricks by bouncing the ball off the paddle.

## To-Do

The following features are currently being worked on or are planned for future updates:

- Block collision detection
- Erasing blocks when hit
- Implementing game-winning logic
- Splitting game functions for better code organization
- 

## Contributing

Contributions are welcome! If you'd like to contribute, please follow these steps:

1. Fork the repository.
2. Create a new branch (`git checkout -b feature-branch`).
3. Commit your changes (`git commit -am 'Add new feature'`).
4. Push to the branch (`git push origin feature-branch`).
5. Create a new Pull Request.