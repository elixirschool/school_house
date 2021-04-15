%{
  version: "1.3.1",
  title: "Collections",
  excerpt: """
  Lists, tuples, keyword lists, and maps.
  """
}
---

## Lists

Lists are simple collections of values which may include multiple types; lists may also include non-unique values:

```elixir
iex> [3.14, :pie, "Apple"]
[3.14, :pie, "Apple"]
```

Elixir implements list collections as linked lists.
This means that accessing the list length is an operation that will run in linear time (`O(n)`).
For this reason, it is typically faster to prepend than to append:
