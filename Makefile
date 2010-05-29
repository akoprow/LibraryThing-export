# - Adam Koprowski 28/05/2010

include LT_passwd

######################################################################################################

SHOW := @echo
HIDE := @

SAXON_JAR ?= ../tools/saxon/saxon9.jar
RESOLVER_JAR ?= ../tools/saxon/resolver.jar
SAXON := java -cp $(SAXON_JAR):$(RESOLVER_JAR) -Dxml.catalog.files=../tools/saxon/dtds/catalog.xml \
	-Dxml.catalog.verbosity=1 net.sf.saxon.Transform \
    -r org.apache.xml.resolver.tools.CatalogResolver \
    -x org.apache.xml.resolver.tools.ResolvingXMLReader \
    -y org.apache.xml.resolver.tools.ResolvingXMLReader

RUN_XSLT := $(SAXON)

######################################################################################################

LOGIN_URL := http://librarything.com/signup.php?formusername=$(USERNAME)&formpassword=$(PASSWD)
COVERS_URL := http://www.librarything.com/allyourcovers
BOOKS_URL := http://www.librarything.com/export-tab

COOKIES := cookies.txt

######################################################################################################

.PHONY: login

login:
	wget --save-cookies $(COOKIES) "$(LOGIN_URL)" --directory-prefix=tmp

%.xhtml: %.html
	html2xhtml -t strict $< -o $@ 

covers.html: login
	wget --load-cookies $(COOKIES) "$(COVERS_URL)" -O $@

covers.xml: covers.xhtml
	$(RUN_XSLT) -o $@ $< covers.xsl

books-UTF16.xls: login
	wget --load-cookies $(COOKIES) "$(BOOKS_URL)" -O $@

books.xls: books-UTF16.xls
	iconv -f UTF-16 -o $@ $<

books.xml: books.csv
	ffe -o $@ -c csv2xml.fferc -s csv2xml $<

clean:
	rm books.xml books.xls books-UTF16.xls covers.xml covers.html cookies.txt
