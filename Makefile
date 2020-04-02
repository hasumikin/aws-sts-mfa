install:
	cp --no-clobber config.yml.sample config.yml
	sudo ln -s $(CURDIR)/main.rb /usr/local/bin/aws-sts-mfa

uninstall:
	sudo rm -f /usr/local/bin/aws-sts-mfa
