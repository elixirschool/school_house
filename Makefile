.PHONY: $(MAKECMDGOALS)

setup: content
	mix do deps.get, compile
	npm install --prefix assets

content: 
	git clone --branch content-only-changes --single-branch --depth 1 https://github.com/elixirschool/elixirschool.git content
	ln -s content/images/* assets/static
