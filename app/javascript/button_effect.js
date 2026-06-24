document.addEventListener("DOMContentLoaded", () => {
  const buttons = document.querySelectorAll(".js-button");

  const sounds = {
    click: new Audio("/assets/click.mp3"),
    delete: new Audio("/assets/delete.mp3"),
    confirm: new Audio("/assets/confirm.mp3"),
  };

  buttons.forEach((button) => {
    button.addEventListener("click", () => {
      const soundName = button.dataset.sound || "click";
      const sound = sounds[soundName];

      sound.currentTime = 0;
      sound.play();
    });
  });
});