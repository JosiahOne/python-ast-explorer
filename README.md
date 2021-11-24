# python-ast-explorer - a simple AST visualizer

A fork of the illustrous code behind [python-ast-explorer.com](https://python-ast-explorer.com).

## Building
```
docker build . --tag past_explorer:latest
```

## Running with Docker
```
docker run -it -p 4361:4361 past_explorer
```

Then open `http://0.0.0.0:4361` in your web browser.
