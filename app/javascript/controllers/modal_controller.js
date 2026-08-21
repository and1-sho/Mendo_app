import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.beforeCache = () => this.close()
    document.addEventListener("turbo:before-cache", this.beforeCache)
  }

  disconnect() {
    document.removeEventListener("turbo:before-cache", this.beforeCache)
  }

  close() {
    this.element.innerHTML = ""
  }

  backdropClose(event) {
    if (event.target === event.currentTarget) {
      this.close()
    }
  }
}