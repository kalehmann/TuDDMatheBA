OUTPUT_DIRECTORY=_site

PDFLATEX=pdflatex
PDFLATEX_OPTS=-output-directory $(OUTPUT_DIRECTORY)

HTML_FILES = \
	$(OUTPUT_DIRECTORY)/index.html

PDF_FILES = \
	$(OUTPUT_DIRECTORY)/pdfs/schedule/1-semester.pdf

OUTPUT_FILES = \
	$(OUTPUT_DIRECTORY) \
	$(OUTPUT_DIRECTORY)/.htacces \
	$(OUTPUT_DIRECTORY)/pdfs/.htacces \
	$(HTML_FILES) \
	$(PDF_FILES)

all: $(OUTPUT_FILES)


$(OUTPUT_DIRECTORY):
	mkdir -p $(OUTPUT_DIRECTORY)
	mkdir -p $(OUTPUT_DIRECTORY)/pdfs/schedule

$(OUTPUT_DIRECTORY)/.htaccess: html/.htaccess
	cp $< $@

$(OUTPUT_DIRECTORY)/pdfs/.htaccess: html/pdfs/.htaccess
	echo $< $@

$(OUTPUT_DIRECTORY)/%.html: html/%.html
	cp $< $@

$(OUTPUT_DIRECTORY)/%.pdf: latex/%.ltx
	$(PDFLATEX) $<
	cp $$(basename $*.pdf) $(OUTPUT_DIRECTORY)/$*.pdf

clean:
	rm -rf $(OUTPUT_DIRECTORY)

.PHONY: clean
