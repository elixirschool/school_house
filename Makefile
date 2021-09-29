.PHONY: $(MAKECMDGOALS)

setup: content
	mix do deps.get, compile, assets.deploy

content:
	rm -rf content priv/static/images
	git clone --branch master --single-branch --depth 1 https://github.com/elixirschool/elixirschool.git content
	mkdir -p priv/static
	mv content/images priv/static/images

build:
	docker build .
