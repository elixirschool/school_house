const darkModeToggle = document.getElementById("dark-mode-toggle")

// set up dark mode toggle
function setDarkMode(on) {
    if (on) {
        darkModeToggle.checked = true
        document.documentElement.classList.add('dark')
        localStorage.theme = 'dark'
        document.getElementById('sun-icon').classList.add('hidden')
        document.getElementById('moon-icon').classList.remove('hidden')
    } else {
        darkModeToggle.checked = false
        document.documentElement.classList.remove('dark')
        localStorage.theme = 'light'
        document.getElementById('moon-icon').classList.add('hidden')
        document.getElementById('sun-icon').classList.remove('hidden')
    }
}

if (localStorage.theme === 'dark' || (!('theme' in localStorage) && window.matchMedia('(prefers-color-scheme: dark)').matches)) {
    setDarkMode(true)
} else {
    setDarkMode(false)
}

darkModeToggle.addEventListener('click', function (ev) {
    if (ev.target.checked) {
        setDarkMode(true)
    } else {
        setDarkMode(false)
    }
})

// remove preload class after the page laods so the styles
// will transition smoothly when switching between dark and
// light mode. Without the preload class, the transition will
// happen on page load if dark mode is enabled
setTimeout(() => {
    document.body.classList.remove('preload')
}, 200)