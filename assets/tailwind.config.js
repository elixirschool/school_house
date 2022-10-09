const colors = require("tailwindcss/colors");

module.exports = {
  content: [
    "../lib/school_house_web/**/*.ex",
    "../lib/school_house_web/**/*.heex",
    "./js/**/*.js",
  ],
  darkMode: "class", // or 'media' or 'class'
  theme: {
    extend: {
      backgroundColor: (theme) => ({
        ...theme("colors"),
        nav: {
          DEFAULT: theme("colors.brand-gray-300"),
          dark: theme("colors.brand-gray-800"),
        },
        body: {
          DEFAULT: colors.white,
          dark: theme("colors.brand-gray-700"),
        },
        purple: {
          DEFAULT: theme("colors.brand-purple-800"),
          dark: theme("colors.brand-purple-100"),
        },
        footer: {
          DEFAULT: theme("colors.brand-gray-200"),
          dark: theme("colors.brand-gray-800"),
        },
      }),
      colors: {
        // purple
        "brand-purple-100": "#caa2f5",
        "brand-purple-200": "#cfbae6",
        "brand-purple-300": "#967ab4",
        "brand-purple-800": "#7c6f89",

        // gray
        "brand-gray-100": "#f9fafb",
        "brand-gray-200": "#f5f6f7",
        "brand-gray-300": "#f4f6f7",
        "brand-gray-400": "#A1A1AA",
        "brand-gray-500": "#9fa3a6",
        "brand-gray-550": "#717171",
        "brand-gray-600": "#666666",
        "brand-gray-650": "#4a4a4a",
        "brand-gray-700": "#3d4449",
        "brand-gray-750": "#3c4349",
        "brand-gray-800": "#31373b",
        "brand-gray-900": "#22272e",

        // red
        "brand-red-300": "#f56a6a",
        "brand-red-500": "#c0394d",
      },
      container: {
        center: true,
      },
      margin: {
        "half-screen": "-50vw",
      },
      textColor: (theme) => ({
        primary: {
          DEFAULT: theme("colors.brand-gray-750"),
          dark: theme("colors.brand-gray-200"),
        },
        heavy: {
          DEFAULT: theme("colors.brand-gray-800"),
          dark: colors.white,
        },
        light: {
          DEFAULT: theme("colors.brand-gray-650"),
          dark: theme("colors.brand-gray-300"),
        },
        lighter: {
          DEFAULT: theme("colors.brand-gray-550"),
          dark: theme("colors.brand-gray-500"),
        },
        purple: {
          DEFAULT: theme("colors.brand-purple-800"),
          dark: theme("colors.brand-purple-100"),
        },
      }),
      transitionProperty: {
        margin: "margin",
      },
      typography: (theme) => ({
        DEFAULT: {
          css: {
            color: theme("colors.brand-gray-750"),
            fontSize: "1.08rem",
            maxWidth: "inherit",
            pre: {
              "background-color": theme("colors.brand-gray-100"),
              color: theme("colors.brand-gray-700"),
            },
            h1: {
              color: theme("colors.brand-gray-750"),
              fontSize: "3.5rem",
              marginTop: "0",
              marginBottom: "0",
              fontWeight: 700,
              lineHeight: 1,
            },
            h2: {
              color: theme("colors.brand-gray-750"),
            },
            h3: {
              color: theme("colors.brand-gray-750"),
            },
            a: {
              color: theme("colors.brand-purple-800"),
              "&:hover": {
                "background-color": theme("colors.brand-purple-800"),
                color: colors.white,
              },
            },
            "code::before": {
              content: '""',
            },
            "code::after": {
              content: '""',
            },
            code: {
              color: theme("colors.brand-gray-750"),
              "background-color": theme("colors.brand-gray-300"),
              "border-radius": "6px",
              display: "inline-block",
              padding: "2px 4px",
              whitespace: "no-wrap",
            },
            "ul li": {
              marginTop: "0px",
              marginBottom: "0px",
            },
            "ul ul": {
              marginTop: "0px",
              marginBottom: "0px",
            },
          },
        },
        dark: {
          css: {
            color: theme("colors.brand-gray-200"),
            pre: {
              "background-color": theme("colors.brand-gray-900"),
            },
            h1: {
              color: theme("colors.brand-gray-200"),
            },
            h2: {
              color: theme("colors.brand-gray-200"),
            },
            h3: {
              color: theme("colors.brand-gray-200"),
            },
            h4: {
              color: theme("colors.brand-gray-200"),
            },
            a: {
              color: theme("colors.brand-purple-100"),
              "&:hover": {
                "background-color": theme("colors.brand-purple-100"),
                color: colors.white,
              },
            },
            "a code": {
              color: theme("colors.brand-gray-750"),
            },
            "code.makeup": {
              "background-color": "transparent",
            },
            strong: {
              color: theme("colors.brand-gray-200"),
            },
            "ul li": {
              marginTop: "0px",
              marginBottom: "0px",
            },
            "ul ul": {
              marginTop: "0px",
              marginBottom: "0px",
            },
            blockquote: {
              color: theme("colors.brand-gray-300"),
            },
            thead: {
              color: theme("colors.brand-gray-300"),
            },
            "pre code": {
              color: colors.white,
            },
          },
        },
      }),
    },
  },
  variants: {
    extend: { typography: ["dark"] },
  },
  plugins: [
    require("@tailwindcss/typography"),
    require("@tailwindcss/forms"),
    require("@tailwindcss/aspect-ratio"),
  ],
};
