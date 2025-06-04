module.exports = {
  plugins: {
    'postcss-import': {},
    'postcss-nested': {},
    tailwindcss: {},
    autoprefixer: {},
    'postcss-url': {
        url: 'copy',
        assetsPath: 'flags',
      },
  }
}
