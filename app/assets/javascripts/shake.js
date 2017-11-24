function shakeThrough1() {
  var breakthrough = document.getElementById("breakThrough1");
  //Restart breakthrough animaton

  var newBreakthrough = breakthrough.cloneNode(true);
  newBreakthrough.classList.add("shake");

  breakthrough.parentNode.replaceChild(newBreakthrough, breakthrough);
}

function shakeThrough2() {
  var breakthrough = document.getElementById("breakThrough2");
  //Restart breakthrough animaton

  var newBreakthrough = breakthrough.cloneNode(true);
  newBreakthrough.classList.add("shake");

  breakthrough.parentNode.replaceChild(newBreakthrough, breakthrough);
}
