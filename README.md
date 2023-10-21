# ft_ality :robot:

## Overview
`ft_ality` is a Haskell-based automaton designed to simulate the moves and combos typically found in fighting games like Mortal Kombat. It not only recognizes key combinations but also trains itself at runtime using grammar files.

## Features
- Built in Haskell, adhering strictly to functional programming paradigms
- Dynamic training using grammar files
- Real-time move and combo recognition
- Tail-recursive functions for optimal performance
- Modular design to separate concerns

## Requirements
- Haskell

## Getting Started

### Clone the Repository
```bash
git clone https://github.com/vvaucoul/ft_ality.git
cd ft_ality
```

### Build the Project
Make sure you have `Haskell` and `make` installed, then run:

```bash
make
```

### Run the Project
To train and run the automaton:

```bash
./ft_ality path/to/grammar.gmr
```

## Usage
After running, the program will display the key mappings on the screen. Press the mapped keys to perform moves and combos. The corresponding move names will be displayed in real-time.

License
This project is licensed under the MIT License - see the LICENSE.md file for details.

