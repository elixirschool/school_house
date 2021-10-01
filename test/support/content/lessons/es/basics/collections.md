%{
  version: "1.3.1",
  title: "Colecciones",
  excerpt: """
  Listas, tuplas, listas de palabras clave y mapas.
  """
}
---

## Listas

Las listas son simples colecciones de valores, las cuales pueden incluir múltiples tipos de datos; las listas pueden incluir valores no únicos:

```elixir
iex> [3.14, :pie, "Apple"]
[3.14, :pie, "Apple"]
```

## Concatenación de listas

La concatenación de listas usa el operador ++/2:

```elixir
iex> [1, 2] ++ [3, 4, 1]
[1, 2, 3, 4, 1]
```