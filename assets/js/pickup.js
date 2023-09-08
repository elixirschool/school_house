const msg = document.querySelector("#pick-up")
const msgPhone = document.querySelector("#pick-up-phone")

const btn = msg.querySelector("a")
const btnPhone = msgPhone.querySelector("a")

const closeBtn = msg.querySelector("button")
const closePhone = msgPhone.querySelector("button")

const overlay = document.querySelector("#pick-up-overlay")

const pickupFrom = JSON.parse(localStorage.getItem("pick-up"))

const urlParams = new URLSearchParams(window.location.search);

let isOn = false;

function close() {
	isOn = false;

  msg.classList.add("md:hidden")

	msgPhone.classList.remove("is-visible")
	overlay.classList.remove("is-on")

	disableScroll()
}

function disableScroll() {
	
	document.body.style["overflow-y"] = window.innerWidth < MIN_WIDTH_OF_PHONES && isOn ? "hidden" : "auto"

}

closeBtn.onclick = close
closePhone.onclick = close
overlay.onclick = close

const MIN_WIDTH_OF_PHONES = 768; // px

function updateMessage() {
  if (pickupFrom && !window.location.pathname.includes("/lessons")) {

		isOn = true

    msg.classList.remove("md:hidden")
    btn.href = pickupFrom.from+"?pickup=true"
		btnPhone.href = pickupFrom.from + "?pickup=true"

		overlay.classList.add("is-on")
		msgPhone.classList.add("is-visible")

		disableScroll()
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

window.addEventListener("resize", disableScroll)
