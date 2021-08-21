# Finance demo app

Flutter demo project intended to show some skills in state management, data structure, REST API communication, small server configuration, graph drawing, among others.

## Getting Started

For the app to work correctly, it needs a json server up and running.
First, you need to install it in your local machine:

```
npm install -g json-server
```

The database is located in `<project_dir>\demo_server` directory. Remember to `cd` into the directory to run the following command.
Then you need to start the server:

```bash
json-server db.json
```

Now you are ready to run the app and read server data!
To close the server: `Ctrl+C` in its terminal.

## Overview

Two pages with a bottom navigation bar to move between them.

### Expenses page

- At the top, there is a live graph with current balance based on the expenses added below.
- In the bottom half of the screen, there is a list with all the expenses added
- Each expense entry can be deleted, and edited (it edits to already set values for simplicity).
- There is a "+" button that adds a new expense with an already set title and a random value between -50 and 50.

### Savings page

- Data is predefined.
- Graph is built with an stream.
- Pinch to zoom is enabled and drag to pan when zoomed in.
- Long press to enable a crosshair.
- Tap on the line to see its value.

## State management

Provider architecture with the `Riverpod` package is used for the state management approach.

### Advantages

- Easy to use.
- Does not require lot of boilerplate code.
- Simple to architect.
- Scales well.

### Disadvantages

- Too much freedom to chose between `Provider`, `StateProvider`, `StateNotifierProvider`, `ChangeNotifierProvider`, `StreamProvider`, `FutureProvider` which somentimes can be overwhelming.

## Testing

Some tests have been implemented in order to check network calls and the correct start up of the application

### TDD Demonstration

The requested [document](TDD_Demonstration.pdf) about TDD is inside this repository at `<project_dir>\TDD_Demonstration.pdf`
