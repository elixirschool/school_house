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
                'brand-gray-500': '#9fa3a6',
                'brand-gray-700': '#3d4449',
                'brand-gray-750': '#3c4349',
                'brand-gray-800': '#31373b',

                // red
                'brand-red-300': '#f56a6a',
                'brand-red-500': '#c0394d',

                'dark-border': 'rgba(210,215,217,0.25)',
                'dark-border-bg': 'rgba(230, 235, 237, 0.75)',

                // old
                // 'brand-light-gray': '#f4f6f7',
                // 'brand-gray': '#3c4349',
                // 'brand-purple': '#7c6f89',
                // 'brand-light-purple': '#cfbae6',
                // 'brand-dark-purple': '#967ab4',
                // 'brand-white': '#fff',
                // 'dark-gray': '#3d4449',
                // // 'dark-gray-200': '#31373b',

                // 'dark-fg': '#f5f6f7',
                // 'light-light-fg': '#9fa3a6',
                // 'dark-light-fg': '#f5f6f7',
                // 'dark-fg-light': '#ffffff',
                // 'dark-accent': '#f56a6a'
            },
            container: {
                center: true,
            },
            margin: {
                'half-screen': '-50vw',
            },
            textColor: (theme) => ({
                primary : {
                    DEFAULT: theme('colors.brand-gray-700'),
                    dark: theme('colors.brand-gray-200')
                },
                bold: {
                    DEFAULT: theme('colors.brand-gray-700'),
                    dark: theme('colors.brand-white')
                },
                light: {
                    DEFAULT: theme('colors.brand-gray-700'),
                    dark: theme('colors.brand-gray-200')
                },
                purple: {
                    DEFAULT: theme('colors.brand-purple-800'),
                    dark: theme('colors.brand-purple-200')
                }
            }),
            typography: (theme) => ({
                DEFAULT: {
                    css: {
                        color: theme('colors.brand-gray-750'),
                        maxWidth: 'inherit',
                        pre: {
                            'background-color': '#f4f5f6',
                            color: '#5a6267'
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
                            color: theme('colors.brand-purple-100'),
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
