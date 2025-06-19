customElements.define(
  "aku-main",
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
      script.src = "/aku/assets/app.js"
      script.type = "text/javascript"
      script.async = true
      script.onload = () => console.log("aku script loaded")
      script.onerror = () => console.error("aku script failed to load")
      this.parentNode.appendChild(script)
    }

    connectedCallback() {
      console.log("aku-main connected")
      fetch("/aku/").
        then(x => x.text()).
        then(x => {
          this.my.shadowRoot.innerHTML = x
          this.reloadScript()
        });
    }

    disconnectedCallback() {
      console.log("aku-main removed from page.")
      if (this.my.liveSocket != null) {
        console.log("aku-main livesocket disconnecting ...")
        this.my.liveSocket.disconnect()
        this.my.liveSocket = null
      }
    }

    connectedMoveCallback() {
      console.log("aku-main moved with moveBefore()")
    }

    adoptedCallback() {
      console.log("aku-main moved to new page.")
    }

    attributeChangedCallback(name, oldValue, newValue) {
      console.log(`aku-main, Attribute ${name} has changed from ${oldValue} to ${newValue}.`)
    }

    setLiveSocket(liveSocket) {
      this.my.liveSocket = liveSocket
    }
  });