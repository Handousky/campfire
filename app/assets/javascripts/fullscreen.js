function FShandler() {
  if (
    (document.fullscreenElement !== undefined) || (document.webkitFullscreenElement !== null) ||
    (document.mozFullScreenElement !== undefined) || (document.msFullscreenElement !== undefined)
  ) {
    document.getElementById("btn-fs").style.display = "none";
    document.getElementById("btn-edit").style.display = "none";
  } else {
    document.getElementById("btn-fs").style.display = "inline-flex";
    document.getElementById("btn-edit").style.display = "inline-flex";
  }
}

window.addEventListener("fullscreenchange", FShandler);
window.addEventListener("webkitfullscreenchange", FShandler);
window.addEventListener("mozfullscreenchange", FShandler);
window.addEventListener("MSFullscreenChange", FShandler);
