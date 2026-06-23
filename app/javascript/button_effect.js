document.addEventListener("DOMContentLoaded", () => {
  const buttons = document.querySelectorAll(".js-button");
  const clickSound = new Audio("/assets/click.mp3");

  buttons.forEach((button) => {
    button.addEventListener("click", () => {
      clickSound.currentTime = 0;
      clickSound.play();
    });
  });
});