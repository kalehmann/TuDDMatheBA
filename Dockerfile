FROM debian

RUN apt-get update \
        && apt-get upgrade -y \
        && apt-get install --no-install-recommends --yes \
        ca-certificates \
        emacs \
        git-restore-mtime \
	latexmk \
	make \
        texlive \
	texlive-fonts-extra \
	texlive-lang-german \
	texlive-latex-extra \
	texlive-pictures \
	texlive-science  \
	&& rm -rf /var/lib/apt/lists/*
