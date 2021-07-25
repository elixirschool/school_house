.PHONY: $(MAKECMDGOALS)

setup: content
	mix do deps.get, compile
	npm install --prefix assets

content:
	rm -rf content assets/static/images
	git clone --branch content-only-changes --single-branch --depth 1 https://github.com/elixirschool/elixirschool.git content
	mv content/images assets/static/images
	mv content/lessons/gr content/lessons/el

build:
	docker build .
