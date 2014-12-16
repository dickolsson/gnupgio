NAME=gnupgio
VERSION=0.0.1

PREFIX?=/usr/local

DIRS=bin lib/gnupgio
INSTALL_DIRS=`find $(DIRS) -type d 2>/dev/null`
INSTALL_FILES=`find $(DIRS) -type f 2>/dev/null`

BUILD_DIR=build
BUILD_NAME=$(NAME)-$(VERSION)
BUILD_FILE=$(BUILD_DIR)/$(BUILD_NAME).tar.gz
SIG_FILE=$(BUILD_DIR)/$(BUILD_NAME).asc

DOC_DIR=$(PREFIX)/share/doc/$(BUILD_NAME)
DOC_FILES=*.md *.txt

$(BUILD_FILE):
	mkdir -p $(BUILD_DIR)
	git archive --output=$(BUILD_FILE) --prefix=$(BUILD_NAME)/ HEAD

build: $(BUILD_FILE)

$(SIG_FILE): $(BUILD_FILE)
	gpg --sign --detach-sign --armor --output $(SIG_FILE) $(BUILD_FILE)

sign: $(SIG_FILE)

clean:
	rm -f $(BUILD_FILE) $(SIG_FILE)

all: $(BUILD_FILE) $(SIG_FILE)

tag:
	git tag $(VERSION)
	git push --tags

release: $(BUILD_FILE) $(SIG_FILE) tag

install:
	for dir in $(INSTALL_DIRS); do mkdir -p $(PREFIX)/$$dir; done
	for file in $(INSTALL_FILES); do cp $$file $(PREFIX)/$$file; done
	mkdir -p $(DOC_DIR)
	cp -r $(DOC_FILES) $(DOC_DIR)/

uninstall:
	for file in $(INSTALL_FILES); do rm -f $(PREFIX)/$$file; done
	rm -rf $(DOC_DIR)

.PHONY: build sign clean tag release install uninstall all
