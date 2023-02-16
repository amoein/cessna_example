.PHONY: compile deps format release tar

all: deps compile release

compile:
	rebar3 compile

deps:
	rebar3 get-deps
	
format:
	rebar3 format

release:
	rebar3 release