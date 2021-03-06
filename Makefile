# Requires Docker: no
# Requires Conda: no
# Build bs4_book: yes
# Copy container output to host: no
# Container with R only: NA
# Push to gh-pages: no
#
# bookdown
PUBLISH_DIR = public
ifeq ($(OS), Windows_NT)
    OSFLAG = WINDOWS
else
    UNAME_S := $(shell uname -s)
    ifeq ($(UNAME_S), Linux)
        OSFLAG = LINUX
    endif
    ifeq ($(UNAME_S), Darwin)
        OSFLAG = OSX
    endif
endif



open_book:
ifeq ($(OSFLAG), OSX)
    @open -a firefox  $(PUBLISH_DIR)/index.html
endif
ifeq ($(OSFLAG), LINUX)
	@firefox  $(PUBLISH_DIR)/index.html
endif
ifeq ($(OSFLAG), WINDOWS)
	@"C:\Program Files\Mozilla Firefox\firefox" $(PUBLISH_DIR)/index.html
endif


bs4book_render:
	export RSTUDIO_PANDOC="/usr/lib/rstudio/bin/pandoc";\
	Rscript -e 'bookdown::render_book("index.Rmd", "bookdown::bs4_book")'


bs4_book: bs4book_render open_book



# push main branch and github-pages
git_push:
	git push ;\
	git subtree push --prefix ${PUBLISH_DIR} origin gh-pages


