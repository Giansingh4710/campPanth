var $cont = document.querySelector(".cont");
var $elsArr = [].slice.call(document.querySelectorAll(".el"));
var $closeBtnsArr = [].slice.call(document.querySelectorAll(".el__close-btn"));

setTimeout(function () {
  $cont.classList.remove("s--inactive");
}, 200);

$elsArr.forEach(function ($el) {
  $el.addEventListener("click", function () {
    if (this.classList.contains("s--active")) return;
    $cont.classList.add("s--el-active");
    this.classList.add("s--active");
  });
});

$closeBtnsArr.forEach(function ($btn) {
  $btn.addEventListener("click", function (e) {
    e.stopPropagation();
    $cont.classList.remove("s--el-active");
    document.querySelector(".el.s--active").classList.remove("s--active");
  });
});

// const ball = document.getElementById("ball");
// ball.addEventListener("click", function (event) {
//   alert("You have pressed the ball");
// });

// const bird = document.getElementById("bird");
// bird.addEventListener("click", function (event) {
//   alert("You have pressed the bird");
// });
