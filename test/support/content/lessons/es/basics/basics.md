%{
  version: "1.2.1",
  title: "Básico",
  excerpt: """
  Preparar el entorno, tipos y operaciones básicas.
  """
}
---

## Preparar el entorno

### Instalar Elixir

Las instrucciones de instalación para cada sistema operativo pueden ser encontradas en [Elixir-lang.org](http://elixir-lang.org) en la guía [Installing Elixir](http://elixir-lang.org/install.html)(en inglés).

Después de que Elixir haya sido instalado, puedes confirmar la versión instalada fácilmente.

    % elixir -v
    Erlang/OTP {{ site.erlang.OTP }} [erts-{{ site.erlang.erts }}] [source] [64-bit] [smp:4:4] [ds:4:4:10] [async-threads:10] [hipe] [kernel-poll:false] [dtrace]

    Elixir {{ site.elixir.version }}
