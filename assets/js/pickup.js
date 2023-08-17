const msg = document.querySelector("#pick-up")
const btn = msg.querySelector("a")
const closeBtn = msg.querySelector("button")

const pickupFrom = JSON.parse(localStorage.getItem("pick-up"))

const urlParams = new URLSearchParams(window.location.search);

closeBtn.onclick = () => {
  msg.classList.add("hidden")
}

function updateMessage() {
  if (pickupFrom && !window.location.pathname.includes("/lessons")) {
    msg.classList.remove("hidden")
    btn.href = pickupFrom.from+"?pickup=true"
  } else if (pickupFrom && window.location.pathname === pickupFrom.from && urlParams.get("pickup") == "true") {
    window.scrollTo(0, pickupFrom.scroll)
  } else {
    localStorage.setItem("pick-up", JSON.stringify({ from: window.location.pathname, scroll: window.scrollY }))
  }
}

window.onload = updateMessage

if (window.location.pathname.includes("/lessons")) {
  window.addEventListener("scroll", () => {
    localStorage.setItem("pick-up", JSON.stringify({ from: window.location.pathname, scroll: window.scrollY }))
  })
}
