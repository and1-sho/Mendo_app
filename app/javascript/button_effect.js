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

document.addEventListener("pointerdown", (event) => {
  const button = event.target.closest(".js-button");
  if (!button) return;

  const soundName = button.dataset.sound || "click";
  const sound = sounds[soundName].cloneNode();

  sound.play().catch(() => {});
});