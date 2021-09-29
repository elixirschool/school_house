import "phoenix_html"
import { Socket } from "phoenix"
import topbar from "topbar"
import { LiveSocket } from "phoenix_live_view"
import Alpine from "alpinejs";

window.Alpine = Alpine;
Alpine.start();

let csrfToken = document.querySelector("meta[name='csrf-token']").getAttribute("content")
let liveSocket = new LiveSocket("/live", Socket, {
  params: {
    _csrf_token: csrfToken
  },
  dom: {
    onBeforeElUpdated(from, to) {
      if (from._x_dataStack) {
        window.Alpine.clone(from, to);
      }
    },
  }, })

// Show progress bar on live navigation and form submits
topbar.config({
  barColors: {
    '0': "rgba(237, 233, 254)",
    '0.5': "rgba(167, 139, 250)",
    '1.0': "rgba(76, 29, 149)"
  },
  shadowColor: "rgba(76, 29, 149, 0.3)"
})
window.addEventListener("phx:page-loading-start", info => topbar.show())
window.addEventListener("phx:page-loading-stop", info => topbar.hide())

// connect if there are any LiveViews on the page
liveSocket.connect()

// expose liveSocket on window for web console debug logs and latency simulation:
// >> liveSocket.enableDebug()
// >> liveSocket.enableLatencySim(1000)
window.liveSocket = liveSocket

import "./dark-mode"
import "./menu-toggle"
