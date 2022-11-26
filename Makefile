OUTPUT_DIRECTORY=_site

EMACS=emacs
EMACS_ORG_EXPORT_FLAGS= \
    -l ini.el \
    -f org-html-export-to-html
LATEXMK=latexmk
LATEXMK_OPTS=-pdf -quiet
PAGEFIND=pagefind
PAGEFIND_FLAGS=--source $(OUTPUT_DIRECTORY)/  --glob 'org/*.html' --bundle-dir org/_bundle

CSS_FILES = \
	$(OUTPUT_DIRECTORY)/dir_index.css

ORG_FILES = \
	$(shell find org -type f -name '*.org')

HTML_FILES = \
	$(OUTPUT_DIRECTORY)/index.html \
	$(OUTPUT_DIRECTORY)/dir_footer.html \
	$(patsubst %.org,_site/%.html,$(ORG_FILES))

PAGE_FIND_BUNDLE = $(OUTPUT_DIRECTORY)/org/_bundle

TEX_FILES = \
	$(shell find . -type f -name '*.tex' -printf '_site/%P\n')

PDF_FILES = \
	$(patsubst %.tex,%.pdf,$(TEX_FILES))

OUTPUT_FILES = \
	$(OUTPUT_DIRECTORY) \
	$(CSS_FILES) \
	$(HTML_FILES) \
	$(PAGE_FIND_BUNDLE) \
	$(PDF_FILES) \
	$(OUTPUT_DIRECTORY)/.htaccess \
	$(OUTPUT_DIRECTORY)/courses/.htaccess \
	$(OUTPUT_DIRECTORY)/org/.htaccess \

all: $(OUTPUT_FILES)

$(OUTPUT_DIRECTORY):
	mkdir -p $(OUTPUT_DIRECTORY)

$(OUTPUT_DIRECTORY)/%htaccess: html/%htaccess
	cp $< $@

$(OUTPUT_DIRECTORY)/org/%.html: org/%.org
	mkdir -p $(@D)
	$(EMACS) --batch $< $(EMACS_ORG_EXPORT_FLAGS)
	cp $(subst .org,.html,$<) $@

$(OUTPUT_DIRECTORY)/%.html: html/%.html
	cp $< $@

$(OUTPUT_DIRECTORY)/%.css: html/%.css
	cp $< $@

$(OUTPUT_DIRECTORY)/%.pdf: %.tex
	mkdir -p $(@D)
	$(LATEXMK) $(LATEXMK_OPTS) $< || (cat $$(basename $*.log) && exit 1) 
	cp $$(basename $*.pdf) $(OUTPUT_DIRECTORY)/$*.pdf
	$(LATEXMK) -C $<

$(PAGE_FIND_BUNDLE): $(ORG_FILES)
	$(PAGEFIND) $(PAGEFIND_FLAGS)

clean:
	rm -rf $(OUTPUT_DIRECTORY)

.PHONY: clean
