%{
  version: "1.0.2",
  title: "Erlang Interoperability",
  excerpt: """
  One of the added benefits to building on top of the Erlang VM (BEAM) is the plethora of existing libraries available to us.
  Interoperability allows us to leverage those libraries and the Erlang standard lib from our Elixir code.
  In this lesson we'll look at how to access functionality in the standard lib along with third-party Erlang packages.
  """
}
---

## Standard Library

Erlang's extensive standard library can be accessed from any Elixir code in our application.
Erlang modules are represented by lowercase atoms such as `:os` and `:timer`.

Let's use `:timer.tc` to time execution of a given function: