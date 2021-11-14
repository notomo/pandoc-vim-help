# for require
export LUA_PATH=./lua/?.lua;;

start:
	${MAKE} -B $(wildcard example/*_output.*)
.PHONY: start

FROM:= commonmark
OUTPUT:= example/test_gen.txt
INPUT:= example/test_gen.md
TAG_PREFIX:= example
LINK_TARGET_PREFIX:= https://example.com/
EXTRA_ARGS:=
gen:
	pandoc \
 --from ${FROM} \
 --to lua/pandoc_vim_help/writer/init.lua \
 --output ${OUTPUT} \
 --metadata=textwidth:78 \
 --metadata=tag_prefix:${TAG_PREFIX} \
 --lua-filter lua/pandoc_vim_help/filter/relative_to_absolute_link/init.lua \
 --metadata=link_target_prefix:${LINK_TARGET_PREFIX} \
 ${EXTRA_ARGS} \
 ${INPUT}
	cat ${OUTPUT}
.PHONY: gen

example/1_output.txt:
	${MAKE} gen \
 INPUT=example/1_input.md \
 OUTPUT=$@ \
 EXTRA_ARGS='--metadata=header_text:"my plugin"'

example/2_output.txt:
	${MAKE} gen \
 INPUT=example/2_input.md \
 OUTPUT=$@ \
 EXTRA_ARGS=--metadata=tag_level_max:2

example/3_output.txt:
	${MAKE} gen \
 INPUT=example/3_input.html \
 FROM=html \
 OUTPUT=$@

example/4_output.txt:
	${MAKE} gen \
 INPUT=example/4_input.html \
 FROM=html \
 OUTPUT=$@

INPUT_URL:= https://example.com/
gen_by_url:
	${MAKE} gen \
 FROM=html \
 INPUT=${INPUT_URL} \
 OUTPUT=example/test_gen_by_url.txt \
 LINK_TARGET_PREFIX=${LINK_TARGET_PREFIX}
.PHONY: gen_by_url

# TODO
# test:
# 	busted --shuffle
# .PHONY: test

# TODO: luarocks publish
