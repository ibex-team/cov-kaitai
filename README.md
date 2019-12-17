# Kaitai Struct description file for IBEX covering files

## What is this

This repository contains the file `cov.ksy`, a [Kaitai Struct](https://kaitai.io) description file of binary IBEX covering files produced by the solver `ibexsolve` from the [IBEX library](https://github.com/ibex-team/ibex-lib).

Kaitai Struct is a binary file parser generation library.

## How to use

Please refer to the [Kaitai README](https://github.com/kaitai-io/kaitai_struct#using-ks-in-your-project) and the [Kaitai website](https://kaitai.io) for all informations, but in short:

* Download `kaitai-struct-compiler`,
* Execute `kaitai-struct-compiler cov.ksy -t <target-language>`,
* Get the runtime for the target language,
* Include it in you project and use the Kaitai API.