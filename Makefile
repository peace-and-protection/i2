# This Makefile is used to generate the releases.
# it is tested to make it work on GNU/Linux for generating releases.
# It needs the «dos2unix» and «awk» commands installed.
#
# To create a release, use «make release».


VERSION=$(shell awk 'NR==5' I2.TXT |dos2unix|cut -f3 -d ' ')

all: release

release:
	git archive --format=zip -o i2-$(VERSION).zip HEAD
