.PHONY: $(MAKECMDGOALS)

setup: content
	mix do deps.get, compile
	npm install --prefix assets

content:
	rm -rf content assets/static/images
	git clone --branch fix-post-image-links --single-branch --depth 1 https://github.com/elixirschool/elixirschool.git content
	mv content/images assets/static/images

build:
	docker build .
