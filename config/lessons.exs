import Config

config :school_house,
  future_lessons: [
    :doctests,
    :flow,
    :broadway,
    :querying_advanced
  ]

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
      :querying_basics,
      :querying_advanced
    ],
    storage: [
      :cachex,
      :ets,
      :mnesia,
      :redix
    ],
    misc: [
      :benchee,
      :debugging,
      :eex,
      :guardian,
      :lua,
      :nerves,
      :nimble_publisher,
      :plug,
      :poolboy
    ]
  ]
