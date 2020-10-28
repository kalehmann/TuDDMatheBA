OUTPUT_DIRECTORY=_site

PDFLATEX=pdflatex
PDFLATEX_OPTS=-output-directory $(OUTPUT_DIRECTORY)

HTML_FILES = \
	$(OUTPUT_DIRECTORY)/index.html

PDF_FILES = \
	$(OUTPUT_DIRECTORY)/pdf/schedule/1-semester.pdf \
	$(OUTPUT_DIRECTORY)/pdf/pr10/pr10.pdf

OUTPUT_FILES = \
	$(OUTPUT_DIRECTORY) \
	$(OUTPUT_DIRECTORY)/.htaccess \
	$(OUTPUT_DIRECTORY)/pdf/.htaccess \
	$(HTML_FILES) \
	$(PDF_FILES)

all: $(OUTPUT_FILES)


$(OUTPUT_DIRECTORY):
	mkdir -p $(OUTPUT_DIRECTORY)
	mkdir -p $(OUTPUT_DIRECTORY)/pdf/pr10
	mkdir -p $(OUTPUT_DIRECTORY)/pdf/schedule

$(OUTPUT_DIRECTORY)/.htaccess: html/.htaccess
	cp $< $@

$(OUTPUT_DIRECTORY)/pdf/.htaccess: html/pdf/.htaccess
	cp $< $@

$(OUTPUT_DIRECTORY)/%.html: html/%.html
	cp $< $@

$(OUTPUT_DIRECTORY)/pdf/%.pdf: latex/%.tex
	$(PDFLATEX) $<
	cp $$(basename $*.pdf) $(OUTPUT_DIRECTORY)/pdf/$*.pdf

clean:
	rm -rf $(OUTPUT_DIRECTORY)

.PHONY: clean
