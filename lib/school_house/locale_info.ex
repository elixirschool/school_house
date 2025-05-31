defmodule SchoolHouse.LocaleInfo do
  @moduledoc """
  Represents metadata for a supported locale.
  """
  @enforce_keys [:code, :title, :original_name, :flag_icon]
  defstruct [:code, :title, :original_name, :flag_icon]

  @doc """
  Returns the default locale.
  """
  def default_locale do
    "en"
  end

  @doc """
  Returns a map of all supported LocaleInfo structs.
  """
  def map do
    %{
      "ar" => %__MODULE__{
        code: "ar",
        title: "Arabic",
        original_name: "العربية",
        flag_icon: "sa"
      },
      "bg" => %__MODULE__{
        code: "bg",
        title: "Bulgarian",
        original_name: "Български",
        flag_icon: "bg"
      },
      "bn" => %__MODULE__{
        code: "bn",
        title: "Bengali",
        original_name: "বাংলা",
        flag_icon: "bd"
      },
      "de" => %__MODULE__{
        code: "de",
        title: "German",
        original_name: "Deutsch",
        flag_icon: "de"
      },
      "el" => %__MODULE__{
        code: "el",
        title: "Greek",
        original_name: "Ελληνικά",
        flag_icon: "gr"
      },
      "en" => %__MODULE__{
        code: "en",
        title: "English",
        original_name: "English",
        flag_icon: "gb"
      },
      "es" => %__MODULE__{
        code: "es",
        title: "Spanish",
        original_name: "Español",
        flag_icon: "es"
      },
      "fa" => %__MODULE__{
        code: "fa",
        title: "Persian",
        original_name: "فارسی",
        flag_icon: "ir"
      },
      "fr" => %__MODULE__{
        code: "fr",
        title: "French",
        original_name: "Français",
        flag_icon: "fr"
      },
      "id" => %__MODULE__{
        code: "id",
        title: "Indonesian",
        original_name: "Bahasa Indonesia",
        flag_icon: "id"
      },
      "it" => %__MODULE__{
        code: "it",
        title: "Italian",
        original_name: "Italiano",
        flag_icon: "it"
      },
      "ja" => %__MODULE__{
        code: "ja",
        title: "Japanese",
        original_name: "日本語",
        flag_icon: "jp"
      },
      "ko" => %__MODULE__{
        code: "ko",
        title: "Korean",
        original_name: "한국어",
        flag_icon: "kr"
      },
      "ms" => %__MODULE__{
        code: "ms",
        title: "Malay",
        original_name: "Bahasa Melayu",
        flag_icon: "my"
      },
      "no" => %__MODULE__{
        code: "no",
        title: "Norwegian",
        original_name: "Norsk",
        flag_icon: "no"
      },
      "pl" => %__MODULE__{
        code: "pl",
        title: "Polish",
        original_name: "Polski",
        flag_icon: "pl"
      },
      "pt" => %__MODULE__{
        code: "pt",
        title: "Portuguese",
        original_name: "Português",
        flag_icon: "pt"
      },
      "ru" => %__MODULE__{
        code: "ru",
        title: "Russian",
        original_name: "Русский",
        flag_icon: "ru"
      },
      "sk" => %__MODULE__{
        code: "sk",
        title: "Slovak",
        original_name: "Slovenčina",
        flag_icon: "sk"
      },
      "ta" => %__MODULE__{
        code: "ta",
        title: "Tamil",
        original_name: "தமிழ்",
        flag_icon: "in"
      },
      "th" => %__MODULE__{
        code: "th",
        title: "Thai",
        original_name: "ไทย",
        flag_icon: "th"
      },
      "tr" => %__MODULE__{
        code: "tr",
        title: "Turkish",
        original_name: "Türkçe",
        flag_icon: "tr"
      },
      "uk" => %__MODULE__{
        code: "uk",
        title: "Ukrainian",
        original_name: "Українською",
        flag_icon: "ua"
      },
      "vi" => %__MODULE__{
        code: "vi",
        title: "Vietnamese",
        original_name: "Tiếng Việt",
        flag_icon: "vn"
      },
      "zh-hans" => %__MODULE__{
        code: "zh-hans",
        title: "Chinese (Simplified)",
        original_name: "简体中文",
        flag_icon: "cn"
      },
      "zh-hant" => %__MODULE__{
        code: "zh-hant",
        title: "Chinese (Traditional)",
        original_name: "繁體中文",
        flag_icon: "tw"
      }
    }
  end

  @doc """
  Returns a list of all supported locale codes.
  """
  def list do
    map()
    |> Map.keys()
  end
end
