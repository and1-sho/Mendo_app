import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["video", "loading"]

  connect() {
    const body = document.body

    console.log("Barcode controller connected")
    console.log("ZXingBrowser:", window.ZXingBrowser)

    this.reader = new ZXingBrowser.BrowserMultiFormatReader()
    this.scanSound = new Audio(body.dataset.scanSound)

    this.scanned = false
    this.controls = null
    this.scanning = false

    this.beforeCache = this.stopCamera.bind(this)
    document.addEventListener("turbo:before-cache", this.beforeCache)

    this.visibilityChange = this.handleVisibilityChange.bind(this)
    document.addEventListener("visibilitychange", this.visibilityChange)

    this.startCamera()
    this.startScanning()
  }

  disconnect() {
    document.removeEventListener("turbo:before-cache", this.beforeCache)
    document.removeEventListener("visibilitychange", this.visibilityChange)

    this.stopScanning()
    this.stopCamera()
  }

  handleVisibilityChange() {
    if (document.hidden) {
      console.log("別タブへ移動：カメラ停止")

      this.stopScanning()
      this.stopCamera()
    } else {
      console.log("スキャンページへ復帰：カメラ再起動")

      if (!this.scanned) {
        this.startCamera()
        this.startScanning()
      }
    }
  }

  async startScanning() {
    if (this.scanning) return

    this.scanning = true

    try {
      const controls = await this.reader.decodeFromVideoElement(
        this.videoTarget,
        (result, error) => {
          if (result && !this.scanned) {
            this.scanned = true

            this.scanSound.play()

            const barcodeInput = document.getElementById("barcode-input")
            barcodeInput.value = result.getText()

            console.log("バーコード読み取り:", result.getText())

            this.stopScanning()
            this.stopCamera()

            document.getElementById("scan-form").requestSubmit()
          }
        }
      )

      if (!this.scanning) {
        controls.stop()
        return
      }

      this.controls = controls

    } catch (error) {
      console.error("バーコード読み取り開始失敗:", error)
      this.scanning = false
    }
  }

  stopScanning() {
    this.scanning = false

    if (!this.controls) return

    this.controls.stop()
    this.controls = null
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
      const stream = await navigator.mediaDevices.getUserMedia({
        video: {
          facingMode: "environment"
        },
        audio: false
      })

      // カメラ起動中に別タブへ移動していた場合
      if (document.hidden) {
        stream.getTracks().forEach(track => track.stop())
        return
      }

      this.stream = stream
      this.videoTarget.srcObject = this.stream

      this.videoTarget.onloadedmetadata = () => {
        this.loadingTarget.classList.add("hidden")
      }

    } catch (error) {
      console.error("カメラ起動失敗:", error)
    }
  }
}