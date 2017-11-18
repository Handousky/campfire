var i = document.getElementById("fullscreen");

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

if (
  document.fullscreenEnabled || document.webkitFullscreenEnabled ||
  document.mozFullScreenEnabled || document.msFullscreenEnabled
) {
  document.getElementById("btn-fs").addEventListener("click", function(event) {
    // go full-screen
    if (i.requestFullscreen) {

      i.requestFullscreen();
    } else if (i.webkitRequestFullscreen) {
      i.webkitRequestFullscreen();
    } else if (i.mozRequestFullScreen) {
      i.mozRequestFullScreen();
    } else if (i.msRequestFullscreen) {
      i.msRequestFullscreen();
    }
  });
} else {
  document.getElementById("btn-fs").style.display = "none";
}

window.addEventListener("fullscreenchange", FShandler);
window.addEventListener("webkitfullscreenchange", FShandler);
window.addEventListener("mozfullscreenchange", FShandler);
window.addEventListener("MSFullscreenChange", FShandler);
