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

LOGINURL := http://librarything.com/signup.php?formusername=$(USERNAME)&formpassword=$(PASSWD)
COVERSURL := http://www.librarything.com/allyourcovers
COOKIES := cookies.txt

######################################################################################################

.PHONY: login

login:
	wget --save-cookies $(COOKIES) "$(LOGINURL)" --directory-prefix=tmp

%.xhtml: %.html
	html2xhtml -t strict $< -o $@ 

covers.html: login
	wget --load-cookies $(COOKIES) "$(COVERSURL)" -O $@

covers.xml: covers.xhtml
	$(RUN_XSLT) -o $@ $< covers.xsl
