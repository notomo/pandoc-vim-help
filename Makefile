# for require
export LUA_PATH=./lua/?.lua;;

start: example/1_output.txt
.PHONY: start

example/1_output.txt:
	pandoc \
 --from commonmark \
 --to lua/pandoc_vim_help/writer/init.lua \
 --output $@ \
 --metadata=textwidth:78 \
 --metadata=tabstop:8 \
 --metadata=tag_prefix:example1 \
 --lua-filter lua/pandoc_vim_help/filter/relative_to_absolute_link/init.lua \
 --metadata=link_target_prefix:sample_prefix/ \
 example/1_input.md
	cat $@
.PHONY: example/1_output.txt

# TODO
# test:
# 	busted --shuffle
# .PHONY: test

# TODO: luarocks publish
