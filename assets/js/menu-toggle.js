const menuToggleButton = document.getElementById("menu-toggle-button");

menuToggleButton.addEventListener('click', function(ev) {
    const nav = document.getElementById('nav');
    nav.classList.toggle('-ml-64');
})