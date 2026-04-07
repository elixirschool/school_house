# School House

[![Continuous Integration](https://github.com/elixirschool/school_house/actions/workflows/ci.yml/badge.svg)](https://github.com/elixirschool/school_house/actions/workflows/ci.yml) [![Deploy](https://github.com/elixirschool/school_house/actions/workflows/deploy.yml/badge.svg)](https://github.com/elixirschool/school_house/actions/workflows/deploy.yml)

School House powers [elixirschool.com](https://elixirschool.com), built with Elixir, Phoenix, and [NimblePublisher](https://github.com/dashbitco/nimble_publisher). Lessons and blog posts are compiled from Markdown at build time and served as static content with full i18n support across 24 locales.

## Architecture

```
school_house/
├── content/              # Git submodule → elixirschool/elixirschool
│   ├── lessons/          #   Lesson Markdown organized by locale/section
│   ├── posts/            #   Blog post Markdown
│   └── images/           #   Copied to assets/static/images at build
├── lib/
│   ├── school_house/     # Content layer (NimblePublisher, Lessons, Posts)
│   └── school_house_web/ # Phoenix web layer
│       ├── controllers/
│       ├── live/          # LiveView pages (conferences)
│       ├── templates/     # HEEx templates
│       └── views/
├── assets/
│   ├── css/app.css       # Design system (CSS custom properties + Tailwind)
│   └── js/app.js         # Alpine.js for interactive components
└── priv/gettext/         # Translations for 24 locales
```

**Key concepts:**

- **Content is compiled at build time** via NimblePublisher. Lesson and blog Markdown files in the `content/` submodule are parsed, processed (syntax highlighting, heading anchors, table of contents), and embedded into the application at compile time. Changing content or templates that process content requires `mix clean` to see updates.
- **Content lives in a separate repo.** The [`elixirschool/elixirschool`](https://github.com/elixirschool/elixirschool) repository contains all lesson and blog Markdown. It's included here as a git submodule at `content/`. To contribute lessons or translations, open PRs against that repo.
- **Dark mode** uses a `[data-theme="dark"]` selector with CSS custom properties that swap all color tokens. No duplicate Tailwind classes needed.

## Prerequisites

- Elixir ~> 1.18
- Erlang/OTP 27+
- Node.js (for asset compilation)

Version management is handled via `.tool-versions` (asdf) or `mise.toml` (mise).

## Getting Started

Clone the repo with the content submodule:

```shell
git clone --recursive https://github.com/elixirschool/school_house.git
cd school_house
```

If you've already cloned without `--recursive`, initialize the submodule:

```shell
git submodule update --init --depth 1
```

Then set up dependencies and assets:

```shell
make setup
```

Start the Phoenix server:

```shell
mix phx.server
```

Visit [`localhost:4000`](http://localhost:4000) in your browser.

## Design System

The UI is built on a token-based design system using CSS custom properties mapped to Tailwind utility classes. All color values are defined in `assets/css/app.css` and consumed via Tailwind in `assets/tailwind.config.js`.

### Semantic Tokens

| Token | Tailwind Class | Usage |
|---|---|---|
| `--bg-primary` | `bg-surface` | Page backgrounds |
| `--bg-secondary` | `bg-surface-secondary` | Section backgrounds, code blocks |
| `--bg-card` | `bg-surface-card` | Cards, dropdowns |
| `--text-primary` | `text-on-surface` | Primary text |
| `--text-secondary` | `text-on-surface-secondary` | Secondary text |
| `--text-muted` | `text-on-surface-muted` | Muted/placeholder text |
| `--purple-500` | `text-brand-500` | Brand color, links, accents |
| `--border-light` | `border-border-subtle` | Subtle borders |

### Typography

- **Headings:** Outfit (`font-heading`)
- **Body:** DM Sans (`font-body`)
- **Code:** JetBrains Mono (`font-mono`)

### Other Conventions

- Border radii: `rounded-design-sm` through `rounded-design-xl`
- Shadows: `shadow-design-sm` through `shadow-design-xl`
- Interactive components (dropdowns, mobile nav) use [Alpine.js](https://alpinejs.dev/) with `x-data`, `x-show`, `x-bind:aria-expanded`

## Updating Content

To pull the latest lessons and blog posts:

```shell
cd content
git pull origin main
cd ..
make content
```

Commit the updated submodule pointer when you're ready to ship:

```shell
git add content
git commit -m "chore: update content submodule"
```

## Running Tests

```shell
mix test
```

CI runs four additional checks on every PR:

| Check | Command |
|---|---|
| Tests | `mix test` |
| Formatting | `mix format --check-formatted` |
| Credo | `mix credo` |
| Dialyzer | `mix dialyzer` |
| Docker build | `docker build .` |

Run them all locally before opening a PR:

```shell
mix format --check-formatted && mix credo && mix test
```

## Contributing

### Lessons and translations

Lesson content lives in [`elixirschool/elixirschool`](https://github.com/elixirschool/elixirschool). To contribute a new lesson, fix a typo, or add a translation, open a PR there.

### Code changes

1. Fork this repo and create a branch
2. Make your changes
3. Run `mix test`, `mix format`, and `mix credo`
4. Open a PR against `main`

When touching templates, use the semantic Tailwind classes from the design system table above rather than raw color values. All templates support dark mode automatically through the CSS custom property layer.

## Docker

```shell
make build
```

## License

This project is licensed under the MIT License. See [LICENSE](LICENSE) for details.
