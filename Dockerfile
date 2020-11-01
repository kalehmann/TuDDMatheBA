FROM debian

RUN apt-get update \
        && apt-get upgrade -y \
        && apt-get install --no-install-recommends --yes \
        ca-certificates \
        lftp \
	make \
        texlive \
	texlive-fonts-extra \
	texlive-latex-extra \
	texlive-pictures \
	texlive-science  \
	&& rm -rf /var/lib/apt/lists/*
