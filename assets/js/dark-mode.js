const darkModeToggle = document.getElementById('dark-mode-toggle')

function setDarkMode(on) {
    if (on) {
        document.documentElement.setAttribute('data-theme', 'dark')
        document.getElementById('sun-icon').classList.add('hidden')
        document.getElementById('moon-icon').classList.remove('hidden')
    } else {
        document.documentElement.removeAttribute('data-theme')
        document.getElementById('moon-icon').classList.add('hidden')
        document.getElementById('sun-icon').classList.remove('hidden')
    }
    if (darkModeToggle) {
        darkModeToggle.setAttribute('aria-pressed', String(on))
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
    document.documentElement.hasAttribute('data-theme')
) {
    setDarkMode(true)
} else {
    setDarkMode(false)
}

if (darkModeToggle) {
    darkModeToggle.addEventListener('click', function () {
        const isDark = document.documentElement.hasAttribute('data-theme')
        if (isDark) {
            localStorage.theme = 'light'
            setDarkMode(false)
        } else {
            localStorage.theme = 'dark'
            setDarkMode(true)
        }
    })
}

// Remove preload class after the page loads so the styles
// will transition smoothly when switching between dark and
// light mode. Without the preload class, the transition will
// happen on page load if dark mode is enabled.
window.addEventListener('load', () => {
    document.body.classList.remove('preload')
})
