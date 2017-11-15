function shakeThrough() {
  var breakthrough = document.getElementById("breakThrough");
  //Restart breakthrough animaton

  var newBreakthrough = breakthrough.cloneNode(true);
  newBreakthrough.classList.add("shake");

  breakthrough.parentNode.replaceChild(newBreakthrough, breakthrough);
}
