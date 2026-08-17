const body = document.body;

const sounds = {
  click: new Audio(body.dataset.clickSound),
  delete: new Audio(body.dataset.deleteSound),
  confirm: new Audio(body.dataset.confirmSound),
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