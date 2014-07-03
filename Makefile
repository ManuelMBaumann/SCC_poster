poster.pdf: poster.tex
	lualatex poster.tex
	lualatex poster.tex

.PHONY: clean
clean:
	rm poster.aux poster.log poster.pdf
