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
                    DEFAULT: theme('colors.brand-gray-300'),
                    dark: theme('colors.brand-gray-800')
                },
                'body': {
                    DEFAULT: theme('colors.brand-white'),
                    dark: theme('colors.brand-gray-700')
                },
                'purple': {
                    DEFAULT: theme('colors.brand-purple-800'),
                    dark: theme('colors.brand-purple-200')
                },
                'footer': {
                    DEFAULT: theme('colors.brand-gray-200'),
                    dark: theme('colors.brand-gray-800')
                }
            }),
            colors: {
                // purple
                'brand-purple-100': '#cfbae6',
                'brand-purple-200': '#967ab4',
                'brand-purple-800': '#7c6f89',

                // white
                'brand-white': '#fff',
                
                // gray
                'brand-gray-200': '#f5f6f7',
                'brand-gray-300': '#f4f6f7',
                'brand-gray-400': '#A1A1AA',
                'brand-gray-500': '#9fa3a6',
                'brand-gray-600': '#666666',
                'brand-gray-700': '#3d4449',
                'brand-gray-750': '#3c4349',
                'brand-gray-800': '#31373b',

                // red
                'brand-red-300': '#f56a6a',
                'brand-red-500': '#c0394d',
            },
            container: {
                center: true,
            },
            margin: {
                'half-screen': '-50vw',
            },
            textColor: (theme) => ({
                primary : {
                    DEFAULT: theme('colors.brand-gray-750'),
                    dark: theme('colors.brand-gray-200')
                },
                heavy : {
                    DEFAULT: theme('colors.brand-gray-800'),
                    dark: theme('colors.brand-white')
                },
                light: {
                    DEFAULT: theme('colors.brand-gray-600'),
                    dark: theme('colors.brand-gray-300')
                },
                lighter: {
                    DEFAULT: theme('colors.brand-gray-400'),
                    dark: theme('colors.brand-gray-500')
                },
                purple: {
                    DEFAULT: theme('colors.brand-purple-800'),
                    dark: theme('colors.brand-purple-200')
                }
            }),
            transitionProperty: {
                'margin': 'margin'
            },
            typography: (theme) => ({
                DEFAULT: {
                    css: {
                        color: theme('colors.brand-gray-750'),
                        maxWidth: 'inherit',
                        pre: {
                            'background-color': theme('colors.brand-gray-300'),
                            color: theme('colors.brand-gray-700')
                        },
                        h1: {
                            color: theme('colors.brand-gray-750')
                        },
                        h2: {
                            color: theme('colors.brand-gray-750'),
                        },
                        h3: {
                            color: theme('colors.brand-gray-750'),
                        },
                        a: {
                            color: theme('colors.brand-purple-800'),
                            '&:hover': {
                                'background-color': theme('colors.brand-purple-800'),
                                color: theme('colors.brand-white'),
                            }
                        },
                        code: {
                            color: theme('colors.brand-gray-750')
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
                dark: {
                    css: {
                        color: theme('colors.brand-gray-200'),
                        pre: {
                            'background-color': theme('colors.brand-gray-800'),
                        },
                        h1: {
                            color: theme('colors.brand-gray-200')
                        },
                        h2: {
                            color: theme('colors.brand-gray-200'),
                        },
                        h3: {
                            color: theme('colors.brand-gray-200'),
                        },
                        a: {
                            color: theme('colors.brand-purple-200'),
                            '&:hover': {
                                'background-color': theme('colors.brand-purple-200'),
                                color: theme('colors.brand-white'),
                            }
                        },
                        code: {
                            color: theme('colors.brand-gray-300')
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
        extend: { typography: ["dark"] }
    },
    plugins: [
        require('@tailwindcss/typography'),
        require('@tailwindcss/forms'),
        require('@tailwindcss/aspect-ratio'),
    ],
}
