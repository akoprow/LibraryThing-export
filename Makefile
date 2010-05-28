include LT_passwd

LOGINURL := http://librarything.com/signup.php?formusername=$(USERNAME)&formpassword=$(PASSWD)

.PHONY: login

login:
	wget --save-cookies cookies.txt "$(LOGINURL)" --directory-prefix=tmp
