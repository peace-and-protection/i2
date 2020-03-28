# This Makefile is used to generate the releases and the archive with only the files changed since previous release.
# it is tested to make it work on GNU/Linux for generating releases.
# It needs the «dos2unix» and «awk» commands installed.
#
# To create a release, use «make release && make diff» BEFORE tagging the release, or the diff will not be created properly.


VERSION=$(shell awk 'NR==5' I2.TXT |dos2unix|cut -f3 -d ' ')

all: release

release:
	git archive --format=zip -o i2-$(VERSION).zip HEAD
