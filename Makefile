# - Adam Koprowski 28/05/2010

include LT_passwd
include Makefile.XSLT

######################################################################################################

LOGIN_URL := http://librarything.com/signup.php?formusername=$(USERNAME)&formpassword=$(PASSWD)
COVERS_URL := http://www.librarything.com/allyourcovers
BOOKS_URL := http://www.librarything.com/export-tab

COOKIES := cookies.txt

######################################################################################################

.PHONY: login clean

all: books.xml

login:
	wget --save-cookies $(COOKIES) "$(LOGIN_URL)" --directory-prefix=/tmp

%.xhtml: %.html
	html2xhtml -t strict $< -o $@ 

covers.html: login
	wget --load-cookies $(COOKIES) "$(COVERS_URL)" -O $@

covers.csv: covers.xhtml covers.xsl
	$(RUN_XSLT) -o $@ $< covers.xsl

books.xls: login
	wget --load-cookies $(COOKIES) "$(BOOKS_URL)" -O $@.tmp
	iconv -f UTF-16 -o $@ $@.tmp
	sed -i 's/\t/|/g' $@
	sed -i 's/\& /\&amp; /g' $@
	rm $@.tmp

books.xml: books.xls covers.csv xls2xml.fferc
	ffe -o $@ -c xls2xml.fferc -s xls2xml -l $<
	$(RUN_XSLT) -o $@ $@ normalizeData.xsl

clean:
	rm -f covers.html covers.csv books.xls books.xml covers.xhtml cookies.txt
