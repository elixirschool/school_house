# School House

Detailed explanation to come.

## Development

At this time there's a little more work to setup for local development.
To start we need to checkout a branch from `elixirschool/elixirschool` that's already had some processing done to the lessons to work with NimblePublisher.
After that is complete we need to create a symbolic link (for now) to that project and rename it to `lessons`:

```shell
$ git clone git@github.com:elixirschool/elixirschool.git
$ cd elixirschool
$ git fetch --all
$ git checkout lessons-only
$ cd ..
$ git clone git@github.com:elixirschool/school_house.git
$ cd school_house
$ ln ../elixirschool ./
$ mv -T elixirschool content
```

From here the rest is as you would expect with Phoenix! :tada:
