import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["video", "loading"]

  connect() {
    console.log("Barcode controller connected")

    this.beforeCache = this.stopCamera.bind(this)
    document.addEventListener("turbo:before-cache", this.beforeCache)

    this.startCamera()
  }

  disconnect() {
    document.removeEventListener("turbo:before-cache", this.beforeCache)
    this.stopCamera()
  }

  stopCamera() {
    if (!this.stream) return

    this.stream.getTracks().forEach(track => track.stop())

    this.videoTarget.pause()
    this.videoTarget.srcObject = null

    this.stream = null
  }

  async startCamera() {
    try {
      this.stream = await navigator.mediaDevices.getUserMedia({
        video: {
          facingMode: "environment"
        },
        audio: false
      })

      this.videoTarget.srcObject = this.stream

      this.videoTarget.onloadedmetadata = () => {
        this.loadingTarget.classList.add("hidden")
      }

    } catch (error) {
      console.error("カメラ起動失敗:", error)
    }
  }
}
