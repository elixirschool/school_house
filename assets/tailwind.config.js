module.exports = {
    purge: [
        '../lib/school_house_web/**/*.ex',
        '../lib/school_house_web/**/*.leex',
        '../lib/school_house_web/**/*.eex',
        './js/**/*.js'
    ],
    darkMode: 'class', // or 'media' or 'class'
    theme: {
        extend: {
            backgroundColor: (theme) => ({
                ...theme('colors'),
                'nav': {
                    DEFAULT: theme('colors.brand-light-gray'),
                    dark: theme('colors.dark-gray-200')
                },
                'body': {
                    DEFAULT: theme('colors.brand-white'),
                    dark: theme('colors.dark-gray')
                }
            }),
            colors: {
                'brand-light-gray': '#f4f6f7',
                'brand-gray': '#3c4349',
                'brand-purple': '#7c6f89',
                'brand-light-purple': '#cfbae6',
                'brand-red': '#c0394d',
                // new
                'brand-white': '#fff',
                // dark
                'dark-gray': '#3d4449',
                'dark-gray-200': '#31373b',

                'dark-fg': '#f5f6f7',
                'dark-fg-bold': '#ffffff',
                'dark-fg-light': '#ffffff',
                'dark-border': 'rgba(210,215,217,0.25)',
                'dark-border-bg': 'rgba(230, 235, 237, 0.75)',
                'dark-accent': '#f56a6a'
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
                                color: theme('colors.brand-gray')
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
                },
                // dark: {
                //     css: {
                //         color: theme('colors.dark-brand-fg'),
                //         pre: {
                //             'background-color': '#f4f5f6',
                //             color: '#5a6267'
                //         },
                //         h1: {
                //                 color: theme('colors.brand-gray')
                //         },
                //         h2: {
                //             color: theme('colors.brand-gray'),
                //         },
                //         h3: {
                //             color: theme('colors.brand-gray'),
                //         },
                //         a: {
                //             color: theme('colors.brand-purple'),
                //             '&:hover': {
                //                 'background-color': theme('colors.brand-purple'),
                //                 color: theme('colors.white'),
                //             }
                //         },
                //         'ul li': {
                //             marginTop: '0px',
                //             marginBottom: '0px',
                //         },
                //         'ul ul': {
                //             marginTop: '0px',
                //             marginBottom: '0px',
                //         },
                //     }
                // }
            }),
        },
    },
    variants: {
        // extend: { typography: ["dark"] }
    },
    plugins: [
        require('@tailwindcss/typography'),
        require('@tailwindcss/forms'),
        require('@tailwindcss/aspect-ratio'),
    ],
}
