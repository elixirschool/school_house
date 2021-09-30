.PHONY: $(MAKECMDGOALS)

setup: content
	mix do setup, compile, assets.deploy

content:
	rm -rf content assets/static/images
	git clone --branch master --single-branch --depth 1 https://github.com/elixirschool/elixirschool.git content
	mv content/images assets/static/images

build:
	docker build .
