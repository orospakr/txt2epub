# Txt2Epub

My first Haskell app.

The goal is to transform certain flavours of preformatted TXT files
into reflowable EPUB, and learn a bit of FP while doing it.

It works at line granularity

## Install

    cabal install --enable-tests --only-dependencies
    cabal configure --enable-tests
    cabal build
    # run tests
    ./dist/build/test-txt2epub/test-txt2epub

## Usage

The app accepts the input text on `stdin`, and currently emits partial
HTML (hacked) on `stdout`.

    ./dist/build/txt2epub/txt2epub < ./mytestfile.txt > ./mytestfile.html

## TODO

Actual output of EPUB, more knobs for more input preformat variants.
