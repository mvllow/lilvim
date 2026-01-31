.PHONY: all
all: docs clean

.PHONY: docs
docs:
	@echo "Generating documentation..."
	@nvim --headless --noplugin -u ./script/minimal-init.lua -c "luafile script/minidoc.lua" -c "qa!"
	@echo

.PHONY: clean
clean:
	@echo "Removing temporary directories..."
	@rm -rf "/tmp/nvim/site/pack/test/start/mini.doc"
	@echo "Done"
