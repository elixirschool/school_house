# School House

[![Continuous Integration](https://github.com/elixirschool/school_house/actions/workflows/ci.yml/badge.svg)](https://github.com/elixirschool/school_house/actions/workflows/ci.yml) [![Deploy](https://github.com/elixirschool/school_house/actions/workflows/deploy.yml/badge.svg)](https://github.com/elixirschool/school_house/actions/workflows/deploy.yml)

School House is the new era of [elixirschool.com](https://elixirschool.com) now powered by Elixir and Phoenix :tada:

By leveraging Dashbit's [NimblePublisher](https://github.com/dashbitco/nimble_publisher) and some restructing of the existing lessons we're able to use the lessons so many have contributed to while delivering them in an improved experience!

## Development

To get up and running all we need is a single command:

```shell
$ make setup
```

This will fetch dependencies, download lessons and blog posts from the [external repository](https://github.com/elixirschool/elixirschool), and compile the project.

Then start the phoenix server with:

```shell
$ mix phx.server
```
