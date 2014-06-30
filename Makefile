
POSTER=poster.pdf

.PHONY: clean

poster: $(POSTER)

clean:
	rm *.aux *.log *.dvi *.ps

%.pdf: %.ps
	ps2pdf $<

%.ps: %.dvi
	dvips -t a4 $<

%.dvi: %.tex matheon-poster.cls
	latex $<

