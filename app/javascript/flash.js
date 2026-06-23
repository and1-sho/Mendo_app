// 全画面共通: フラッシュメッセージを3秒後に非表示にする
setTimeout(function () {
  var notice = document.getElementById("flash-notice");
  var alert = document.getElementById("flash-alert");
  if (notice) notice.style.display = "none";
  if (alert) alert.style.display = "none";
}, 3000);
