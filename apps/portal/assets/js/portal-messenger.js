customElements.define(
  "portal-messenger",
  class extends HTMLElement {
    static observedAttributes = ["message"];

    constructor() {
      super();
    }

    connectedCallback() {
      //console.log("portal-messenger added to the page.")
    }

    disconnectedCallback() {
      //console.log("portal-messenger removed from page.")
    }

    connectedMoveCallback() {
      console.log("portal-messenger moved with moveBefore()");
    }

    adoptedCallback() {
      console.log("portal-messenger moved to new page.");
    }

    attributeChangedCallback(_name, _oldValue, newValue) {
      this.dispatchEvent(
        new CustomEvent(
          "portal-messenger:init", {
            bubbles:    true,
            cancelable: true,
            composed:   true,
            detail: JSON.parse(newValue || "{}")
          }));
    }
  }
)