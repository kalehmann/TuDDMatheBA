OUTPUT_DIRECTORY=_site

PDFLATEX=pdflatex
PDFLATEX_OPTS=-output-directory $(OUTPUT_DIRECTORY)

HTML_FILES = \
	$(OUTPUT_DIRECTORY)/index.html

PDF_FILES = \
	$(OUTPUT_DIRECTORY)/schedule/1-semester.pdf

all: $(OUTPUT_DIRECTORY) $(HTML_FILES) $(PDF_FILES)


$(OUTPUT_DIRECTORY):
	mkdir -p $(OUTPUT_DIRECTORY)
	mkdir -p $(OUTPUT_DIRECTORY)/schedule

$(OUTPUT_DIRECTORY)/%.html: html/%.html
	cp $< $@

$(OUTPUT_DIRECTORY)/%.pdf: latex/%.ltx
	$(PDFLATEX) $(PDFLATEX_OPTS) $<

clean:
	rm -rf $(OUTPUT_DIRECTORY)

.PHONY: clean
