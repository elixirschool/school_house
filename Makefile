.PHONY: $(MAKECMDGOALS) content

setup: content
	mix do setup, compile, assets.deploy

content:
	rm -rf assets/static/images

	# Clone from live repo
	rm -rf content && git clone --branch master --single-branch --depth 1 https://github.com/elixirschool/elixirschool.git content

	# If you are testing Elixir School guides, you can comment the line above and uncoment the one bellow, updating PATH_TO_YOUR_LOCAL_REPO
	# rsync -av /PATH_TO_YOUR_LOCAL_REPO/elixirschool/ ./content --exclude .git

	mv content/images assets/static/images

build:
	docker build .
