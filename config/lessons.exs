use Mix.Config

config :school_house,
  lessons: [
    basics: [
      :basics,
      :collections,
      :enum,
      :pattern_matching,
      :control_structures,
      :functions,
      :pipe_operator,
      :modules,
      :mix,
      :sigils,
      :documentation,
      :testing,
      :comprehensions,
      :strings,
      :date_time,
      :mix_tasks,
      :iex_helpers
    ],
    advanced: [
      :erlang,
      :error_handling,
      :escripts,
      :concurrency,
      :otp_concurrency,
      :otp_supervisors,
      :otp_distribution,
      :metaprogramming,
      :umbrella_projects,
      :typespec,
      :behaviours,
      :gen_stage,
      :protocols
    ]
  ]
