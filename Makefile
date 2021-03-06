# Targets:
#
#   all:          Builds the code locally after testing
#
#   fmt:          Formats the source files
#   build:        Builds the code locally
#   vet:          Vets the code
#   lint:         Runs lint over the code (you do not need to fix everything)
#   test:         Runs the tests
#   clean:        Deletes the built file (if it exists)
#
#   install:      Builds, tests and installs the code locally

.PHONY: all fmt build vet lint test clean install

# Sub-directories containing cod to be vetted or linted
CODE = export

# The first target is always the default action if `make` is called without args
all: clean fmt vet test install

fmt:
	@gofmt -w ./$*

build: export GOOS=linux
build: GOARCH=amd64
build: clean
	@go build

vet:
	@go tool vet $(CODE)

lint:
	@golint $(CODE) main.go

test:
	@go test -v -cover ./...

clean:
	@find $(GOPATH)/bin -name export-vbulletin -delete
	@find . -name export-vbulletin -delete

install: clean
	@go install
