customElements.define(
  "ulf-main",
  class extends HTMLElement {
    constructor() {
      super()
      this.my = {} // used in order to separate from the other native attributes
      this.my.internals  = this.attachInternals()
      this.my.shadowRoot = this.attachShadow({mode: 'open'})
    }

    reloadScript() {
      const oldScript = document.getElementById("main-script")
      if (oldScript != null)
        oldScript.remove()

      const script = document.createElement("script")
      script.id = "main-script"
      script.src = "/ulf/assets/app.js"
      script.type = "text/javascript"
      script.async = true
      script.onload = () => console.log("ulf script loaded")
      script.onerror = () => console.error("ulf script failed to load")
      this.parentNode.appendChild(script)
    }

    connectedCallback() {
      console.log("ulf-main connected ...")
      fetch("/ulf/").
        then(x => x.text()).
        then(x => {
          this.my.shadowRoot.innerHTML = x
          this.reloadScript()
        });
    }

    disconnectedCallback() {
      console.log("ulf-main removed from page.")
      if (this.my.liveSocket != null) {
        console.log("ulf-main livesocket disconnecting ...")
        this.my.liveSocket.disconnect()
        this.my.liveSocket = null
      }
    }

    connectedMoveCallback() {
      console.log("ulf-main moved with moveBefore()")
    }

    adoptedCallback() {
      console.log("ulf-main moved to new page.")
    }

    attributeChangedCallback(name, oldValue, newValue) {
      console.log(`ulf-main, Attribute ${name} has changed from ${oldValue} to ${newValue}.`)
    }

    setLiveSocket(liveSocket) {
      this.my.liveSocket = liveSocket
    }
  });