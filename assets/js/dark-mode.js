const darkModeToggleContainer = document.getElementById(
    'dark-mode-toggle-container'
)
const darkModeToggleInput = document.getElementById('dark-mode-toggle')

// set up dark mode toggle
function setDarkMode(on) {
    if (on) {
        darkModeToggleInput.checked = true
        document.documentElement.classList.add('dark')
        document.getElementById('sun-icon').classList.add('hidden')
        document.getElementById('moon-icon').classList.remove('hidden')
    } else {
        darkModeToggleInput.checked = false
        document.documentElement.classList.remove('dark')
        document.getElementById('moon-icon').classList.add('hidden')
        document.getElementById('sun-icon').classList.remove('hidden')
    }
}

// Will prefer dark mode, if the user has set it on their device.
const userPrefersDarkMode =
    window.matchMedia &&
    window.matchMedia('(prefers-color-scheme: dark)').matches

// If the user has taken an active choice to set mode, which is stored
// in local storage, use that. Otherwise, prefer user device preference.
if (localStorage.theme) {
    setDarkMode(localStorage.theme === 'dark')
} else if (
    userPrefersDarkMode ||
    document.documentElement.classList.contains('dark')
) {
    setDarkMode(true)
} else {
    setDarkMode(false)
}

darkModeToggleContainer.addEventListener('click', function () {
    if (darkModeToggleInput.checked) {
        localStorage.theme = 'light'
        setDarkMode(false)
    } else {
        localStorage.theme = 'dark'
        setDarkMode(true)
    }
})

// remove preload class after the page laods so the styles
// will transition smoothly when switching between dark and
// light mode. Without the preload class, the transition will
// happen on page load if dark mode is enabled
setTimeout(() => {
    document.body.classList.remove('preload')
}, 200)
