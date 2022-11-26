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
        wget \
	&& rm -rf /var/lib/apt/lists/*

RUN wget -qO- https://github.com/CloudCannon/pagefind/releases/download/v0.10.2/pagefind-v0.10.2-x86_64-unknown-linux-musl.tar.gz | tar xvz -C /usr/local/bin/
