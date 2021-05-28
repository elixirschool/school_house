// We need to import the CSS so that webpack will load it.
// The MiniCssExtractPlugin is used to separate it out into
// its own CSS file.
import "../css/app.css"

// webpack automatically bundles all modules in your
// entry points. Those entry points can be configured
// in "webpack.config.js".
//
// Import deps with the dep name or local files with a relative path, for example:
//
//     import {Socket} from "phoenix"
//     import socket from "./socket"
//
import "phoenix_html"
import { Socket } from "phoenix"
import NProgress from "nprogress"
import { LiveSocket } from "phoenix_live_view"
import 'alpinejs'

let csrfToken = document.querySelector("meta[name='csrf-token']").getAttribute("content")
let liveSocket = new LiveSocket("/live", Socket, { params: { _csrf_token: csrfToken } })

// Show progress bar on live navigation and form submits
window.addEventListener("phx:page-loading-start", info => NProgress.start())
window.addEventListener("phx:page-loading-stop", info => NProgress.done())

// connect if there are any LiveViews on the page
liveSocket.connect()

// expose liveSocket on window for web console debug logs and latency simulation:
// >> liveSocket.enableDebug()
// >> liveSocket.enableLatencySim(1000)
window.liveSocket = liveSocket

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

const darkModeToggle = document.getElementById("dark-mode-toggle")

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