# REA Robot Exercise

A small application that simulates of a toy robot moving on a square tabletop.

See [PROBLEM.md](PROBLEM.md) for more details about the expected behaviour of the simulation.

## Usage

A small executable has been provided (`bin/rea-robot`) so that the simulator can be run from the command line.

Input can be provided via STDIN.

To ensure that the correct gems are loaded, this executable can be run via Rake using Bundler:

    bundle exec rake run

## Commands

The simulator supports the following commands, as described in [PROBLEM.md](PROBLEM.md):

* `PLACE <x>, <y>, <direction>`
* `MOVE`
* `LEFT`
* `RIGHT`
* `REPORT`

The `MOVE`, `LEFT`, `RIGHT` and `REPORT` commands will be ignored if a valid `PLACE` command has not been performed.

## Tests

The simulator test suite can be run using:

    bundle exec rake spec

or just:

    bundle exec rake
    
Code coverage information is written to the `coverage` directory.

