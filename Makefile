OUTPUT_DIRECTORY=_site

LATEXMK=latexmk
LATEXMK_OPTS=-pdf -quiet

HTML_FILES = \
	$(OUTPUT_DIRECTORY)/index.html

PDF_FILES = \
	$(OUTPUT_DIRECTORY)/pdf/schedule/1-semester.pdf \
	$(OUTPUT_DIRECTORY)/pdf/an10/an10.pdf \
	$(OUTPUT_DIRECTORY)/pdf/an10/ha01.pdf \
	$(OUTPUT_DIRECTORY)/pdf/an10/ha02.pdf \
	$(OUTPUT_DIRECTORY)/pdf/an10/ha03.pdf \
	$(OUTPUT_DIRECTORY)/pdf/an10/uebung.pdf \
	$(OUTPUT_DIRECTORY)/pdf/inf-b-210/inf-b-210.pdf \
	$(OUTPUT_DIRECTORY)/pdf/la10/ha01.pdf \
	$(OUTPUT_DIRECTORY)/pdf/la10/la10.pdf \
	$(OUTPUT_DIRECTORY)/pdf/la10/uebung.pdf \
	$(OUTPUT_DIRECTORY)/pdf/pr10/homework/01.pdf \
	$(OUTPUT_DIRECTORY)/pdf/pr10/homework/02.pdf \
	$(OUTPUT_DIRECTORY)/pdf/pr10/pr10.pdf \
	$(OUTPUT_DIRECTORY)/pdf/pr10/sonderuebung.pdf \
	$(OUTPUT_DIRECTORY)/pdf/pr10/uebung.pdf

OUTPUT_FILES = \
	$(OUTPUT_DIRECTORY) \
	$(OUTPUT_DIRECTORY)/.htaccess \
	$(OUTPUT_DIRECTORY)/pdf/.htaccess \
	$(HTML_FILES) \
	$(PDF_FILES)

all: $(OUTPUT_FILES)


$(OUTPUT_DIRECTORY):
	mkdir -p $(OUTPUT_DIRECTORY)
	mkdir -p $(OUTPUT_DIRECTORY)/pdf/an10
	mkdir -p $(OUTPUT_DIRECTORY)/pdf/inf-b-210
	mkdir -p $(OUTPUT_DIRECTORY)/pdf/la10
	mkdir -p $(OUTPUT_DIRECTORY)/pdf/pr10
	mkdir -p $(OUTPUT_DIRECTORY)/pdf/pr10/homework
	mkdir -p $(OUTPUT_DIRECTORY)/pdf/schedule

$(OUTPUT_DIRECTORY)/.htaccess: html/.htaccess
	cp $< $@

$(OUTPUT_DIRECTORY)/pdf/.htaccess: html/pdf/.htaccess
	cp $< $@

$(OUTPUT_DIRECTORY)/%.html: html/%.html
	cp $< $@

$(OUTPUT_DIRECTORY)/pdf/%.pdf: latex/%.tex
	$(LATEXMK) $(LATEXMK_OPTS) $< || (cat $$(basename $*.log) && exit 1) 
	cp $$(basename $*.pdf) $(OUTPUT_DIRECTORY)/pdf/$*.pdf
	$(LATEXMK) -C $<

$(OUTPUT_DIRECTORY)/pdf/pr10/homework/%.pdf: latex/pr10/homework/%/homework.tex
	$(LATEXMK) $(LATEXMK_OPTS) $<
	cp homework.pdf $(OUTPUT_DIRECTORY)/pdf/pr10/homework/$*.pdf
	$(LATEXMK) -C $<

clean:
	rm -rf $(OUTPUT_DIRECTORY)

.PHONY: clean
