include LT_passwd

LOGINURL := http://librarything.com/signup.php?formusername=$(USERNAME)&formpassword=$(PASSWD)
COVERSURL := http://www.librarything.com/allyourcovers
COOKIES := cookies.txt

.PHONY: login

login:
	wget --save-cookies $(COOKIES) "$(LOGINURL)" --directory-prefix=tmp

%.xhtml: %.html
	html2xhtml $< -o $@ 

covers.html: login
	wget --load-cookies $(COOKIES) "$(COVERSURL)" -O $@
