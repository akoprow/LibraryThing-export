# - Adam Koprowski 28/05/2010

include .LT_passwd
include Makefile-XSLT

######################################################################################################

LOGIN_URL := http://librarything.com/signup.php?formusername=$(USERNAME)&formpassword=$(PASSWD)
COVERS_URL := http://www.librarything.com/allyourcovers
BOOKS_URL := http://www.librarything.com/export-tab

COOKIES := cookies.txt

######################################################################################################

.PHONY: login clean

all: books.xml

login:
	$(SHOW) Logging in to LibraryThing...
	$(HIDE) wget --save-cookies $(COOKIES) "$(LOGIN_URL)" --directory-prefix=/tmp -o /dev/null

%.xhtml: %.html
	$(SHOW) Generating: [$@]
	$(HIDE) html2xhtml -t strict $< -o $@

covers.html: login
	$(SHOW) Generating: [$@]
	$(HIDE) wget --load-cookies $(COOKIES) "$(COVERS_URL)" -O $@ -o /dev/null

covers.csv: covers.xhtml covers.xsl
	$(SHOW) Generating: [$@]
	$(HIDE) $(RUN_XSLT) -o $@ $< covers.xsl

books.xls: login
	$(SHOW) Generating: [$@]
	$(HIDE) wget --load-cookies $(COOKIES) "$(BOOKS_URL)" -O $@.tmp -o /dev/null
	$(HIDE) iconv -f UTF-16 -o $@ $@.tmp
	$(HIDE) sed -i 's/\t/|/g' $@
	$(HIDE) sed -i 's/\& /\&amp; /g' $@
	$(HIDE) rm $@.tmp

books.xml: books.xls covers.csv xls2xml.fferc
	$(SHOW) Generating: [$@]
	$(HIDE) ffe -o $@ -c xls2xml.fferc -s xls2xml -l $< 2> /dev/null
	$(HIDE) $(RUN_XSLT) -o $@ $@ normalizeData.xsl

clean:
	$(SHOW) Cleaning...
	$(HIDE) rm -f covers.html covers.csv books.xls books.xml covers.xhtml $(COOKIES)
