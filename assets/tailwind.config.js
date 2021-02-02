module.exports = {
  purge: [
    '../lib/ground_control_web/**/*.ex',
    '../lib/ground_control_web/**/*.leex',
    '../lib/ground_control_web/**/*.eex',
    './js/**/*.js'
  ],
  darkMode: false, // or 'media' or 'class'
  theme: {
    extend: {
      colors: {
        'light-gray': '#f4f6f7',
        gray: '#3c4349',
        purple: '#7c6f89',
        red: '#c0394d',
      },
      container: {
        center: true,
      },
      typography: (theme) => ({
        DEFAULT: {
          css: {
            color: theme('colors.gray'),
            maxWidth: 'inherit',
            pre: {
              'background-color': '#f4f5f6',
              color: '#5a6267'
            },
            h1: {
              color: theme('colors.gray'),
            },
            h2: {
              color: theme('colors.gray'),
            },
            h3: {
              color: theme('colors.gray'),
            },
            a: {
              color: theme('colors.purple'),
              '&:hover': {
                'background-color': theme('colors.purple'),
                color: theme('colors.white'),
              }
            },
            'ul li': {
              marginTop: '0px',
              marginBottom: '0px',
            },
            'ul ul': {
              marginTop: '0px',
              marginBottom: '0px',
            },
          }
        }
      }),
    },
  },
  variants: {
    extend: {},
  },
  plugins: [
    require('@tailwindcss/typography')
  ],
}
