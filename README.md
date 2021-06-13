# School House

[![Continuous Integration](https://github.com/elixirschool/school_house/actions/workflows/ci.yml/badge.svg)](https://github.com/elixirschool/school_house/actions/workflows/ci.yml) [![Deploy](https://github.com/elixirschool/school_house/actions/workflows/deploy.yml/badge.svg)](https://github.com/elixirschool/school_house/actions/workflows/deploy.yml)

School House is the new era of [elixirschool.com](https://elixirschool.com) now powered by Elixir and Phoenix :tada:

By leveraging Dashbit's [NimblePublisher](https://github.com/dashbitco/nimble_publisher) and some restructing of the existing lessons we're able to use the lessons so many have contributed to while delivering them in an improved experience!

## Development

At this time there's a little more work to setup for local development.
We'll need to checkout a specific branch from `elixirschool/elixirschool` that's already had some processing done to the lessons to work with NimblePublisher. We'll also need to link the images in the aforementioned branch to our assets folder for Phoenix to pickup.

```shell
$ git clone git@github.com:elixirschool/school_house.git
$ cd school_house
$ git clone git@github.com:elixirschool/elixirschool.git content
$ cd content
$ git fetch --all
$ git checkout lessons-only
$ cd ..
$ ln -s content/images assets/static
```

From here the rest is as you would expect with Phoenix! :tada:
