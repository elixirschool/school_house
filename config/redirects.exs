use Mix.Config

config :school_house,
  redirects: %{
    ~r/^\/$/ => "/en",
    ~r/^([\w-]+)\/lessons\/advanced\/nerves/ => "/\\1/lessons/specifics/nerves",
    ~r/^\/cb/ => "/zh-hans",
    ~r/^\/tw/ => "/zh-hant",
    ~r/^\/my/ => "/me",
    ~r/^\/jp/ => "/ja"
  }
