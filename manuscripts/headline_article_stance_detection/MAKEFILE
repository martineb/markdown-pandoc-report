html:
	pandoc -s --filter=pandoc-citeproc --bibliography=citations.bib --csl=cstyles/nature.csl --mathjax --template=templates/html.template --css=templates/kultiad-serif.css -o test.html test.md
pdf:
	pandoc -s --filter=pandoc-citeproc --bibliography=citations.bib --csl=cstyles/nature.csl --mathjax --template=templates/template.tex -o test.pdf test.md