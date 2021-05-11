module.exports = {
    purge: [
        '../lib/school_house_web/**/*.ex',
        '../lib/school_house_web/**/*.leex',
        '../lib/school_house_web/**/*.eex',
        './js/**/*.js'
    ],
    darkMode: false, // or 'media' or 'class'
    theme: {
        extend: {
            colors: {
                'brand-light-gray': '#f4f6f7',
                'brand-gray': '#3c4349',
                'brand-purple': '#7c6f89',
                'brand-light-purple': '#cfbae6',
                'brand-red': '#c0394d',
            },
            container: {
                center: true,
            },
            margin: {
            'half-screen': '-50vw',
            },
            typography: (theme) => ({
                DEFAULT: {
                    css: {
                        color: theme('colors.brand-gray'),
                        maxWidth: 'inherit',
                        pre: {
                            'background-color': '#f4f5f6',
                            color: '#5a6267'
                        },
                        h1: {
                            color: theme('colors.brand-gray'),
                        },
                        h2: {
                            color: theme('colors.brand-gray'),
                        },
                        h3: {
                            color: theme('colors.brand-gray'),
                        },
                        a: {
                            color: theme('colors.brand-purple'),
                            '&:hover': {
                                'background-color': theme('colors.brand-purple'),
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
        require('@tailwindcss/typography'),
        require('@tailwindcss/forms'),
        require('@tailwindcss/aspect-ratio'),
    ],
}
