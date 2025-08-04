[
  import_deps: [:phoenix],
  inputs: ["*.{ex,exs}", "{config,lib,test}/**/*.{ex,exs}"],
  subdirectories: [],
  plugins: [Phoenix.LiveView.HTMLFormatter],
  line_length: 120
]
