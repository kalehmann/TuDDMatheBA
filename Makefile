OUTPUT_DIRECTORY=_site

PDFLATEX=pdflatex
PDFLATEX_OPTS=-output-directory $(OUTPUT_DIRECTORY)

HTML_FILES = \
	$(OUTPUT_DIRECTORY)/index.html

PDF_FILES = \
	$(OUTPUT_DIRECTORY)/schedule/1-semester.pdf

all: $(OUTPUT_DIRECTORY) $(OUTPUT_DIRECTORY)/.htaccess $(HTML_FILES) $(PDF_FILES)


$(OUTPUT_DIRECTORY):
	mkdir -p $(OUTPUT_DIRECTORY)
	mkdir -p $(OUTPUT_DIRECTORY)/schedule

$(OUTPUT_DIRECTORY)/.htaccess: html/.htaccess
	cp $< $@

$(OUTPUT_DIRECTORY)/%.html: html/%.html
	cp $< $@

$(OUTPUT_DIRECTORY)/%.pdf: latex/%.ltx
	$(PDFLATEX) $<
	cp $$(basename $*.pdf) $(OUTPUT_DIRECTORY)/$*.pdf

clean:
	rm -rf $(OUTPUT_DIRECTORY)

.PHONY: clean
