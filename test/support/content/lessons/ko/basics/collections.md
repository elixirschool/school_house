%{
  version: "1.3.1",
  title: "컬렉션",
  excerpt: """
  리스트, 튜플, 키워드 리스트, 맵.
  """
}
---

## 리스트

리스트(list)는 값들의 간단한 컬렉션입니다. 리스트는 여러 타입을 포함할 수 있으며 중복된 값들도 포함할 수 있습니다.

```elixir
iex> [3.14, :pie, "Apple"]
[3.14, :pie, "Apple"]
```

Elixir는 연결 리스트로서 리스트 컬렉션을 구현합니다.
따라서 리스트의 길이를 구하는 것은 선형의 시간`O(n)`이 걸리며,
이러한 이유로 리스트의 앞에 값을 추가하는 것이 뒤에 추가하는 것보다 보통 빠릅니다.

```elixir
iex> list = [3.14, :pie, "Apple"]
[3.14, :pie, "Apple"]
# 앞에 추가(빠름)
iex> ["π" | list]
["π", 3.14, :pie, "Apple"]
# 뒤에 추가(느림)
iex> list ++ ["Cherry"]
[3.14, :pie, "Apple", "Cherry"]
```
