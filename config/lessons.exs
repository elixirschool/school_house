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
      :iex_helpers
    ],
    intermediate: [
      :mix_tasks,
      :erlang,
      :error_handling,
      :escripts,
      :concurrency
    ],
    advanced: [
      :otp_concurrency,
      :otp_supervisors,
      :otp_distribution,
      :metaprogramming,
      :umbrella_projects,
      :typespec,
      :behaviours,
      :gen_stage,
      :protocols
    ],
    testing: [
      :basics,
      :doctests,
      :bypass,
      :mox,
      :stream_data
    ],
    data_processing: [
      :genstage,
      :flow,
      :broadway
    ],
    ecto: [
      :basics,
      :changesets,
      :associations,
      :query_basics,
      :query_advanced
    ],
    storage: [
      :ets,
      :mnesia,
      :cachex,
      :redix
    ],
    misc: [
      :plug,
      :eex,
      :debugging,
      :nerves,
      :guardian,
      :poolboy,
      :distillery,
      :nimble_publisher
    ]
  ]
