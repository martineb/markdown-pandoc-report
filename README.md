# Using Markdown to write a generic scientific report

You will find in this repository a simple example to generate scientific reports from a Markdown file using:

- [pandoc](http://pandoc.org)
- [pandoc-citeproc](https://github.com/jgm/pandoc-citeproc)
- `pdflatex` and associated packages
- `html` and `latex` templates
- citation style `csl` files

On OS X with Homebrew installed, just run the following:

    brew cask install basictex
    brew install pandoc
    brew install pandoc-citeproc

Then compile the example test.md in either `html` or `pdf` formats:

    make html
    make pdf