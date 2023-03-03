.PHONY: compile deps format release tar

all: deps compile release

compile:
	rebar3 compile

deps:
	rebar3 get-deps
	
format:
	rebar3 fmt

release:
	rebar3 release

run:
	_build/default/rel/cessna_example/bin/cessna_example console	