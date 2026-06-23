document.addEventListener("DOMContentLoaded", () => {
  const buttons = document.querySelectorAll(".js-button");

  buttons.forEach((button) => {
    button.addEventListener("click", () => {
      // data-sound がなければ click を使う
      const soundName = button.dataset.sound || "click";

      const sound = new Audio(`/assets/${soundName}.mp3`);
      sound.play();
    });
  });
});