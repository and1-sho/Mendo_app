document.addEventListener("DOMContentLoaded", () => {
  const buttons = document.querySelectorAll(".js-button");

  const sounds = {
    click: new Audio("/assets/click.mp3"),
    delete: new Audio("/assets/delete.mp3"),
    confirm: new Audio("/assets/confirm.mp3"),
  };

  // 最初に読み込む
  Object.values(sounds).forEach((sound) => {
    sound.preload = "auto";
    sound.load();
  });

  buttons.forEach((button) => {
    button.addEventListener("pointerdown", () => {
      const soundName = button.dataset.sound || "click";

      // 元の音をコピーして再生
      const sound = sounds[soundName].cloneNode();

      sound.play().catch(() => {});
    });
  });
});