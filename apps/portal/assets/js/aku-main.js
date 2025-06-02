customElements.define(
  "aku-main",
  class extends HTMLElement {
    constructor() {
      super();
      this.my = {};
      this.my.internals  = this.attachInternals();
      this.my.shadowRoot = this.attachShadow({mode: 'open'});
    }

    connectedCallback() {
      fetch("/aku/").
        then(x => x.text()).
        then(x => {
          this.my.shadowRoot.innerHTML = x;
          this.dispatchEvent(
            new CustomEvent(
              "aku-main:loaded", {
                bubbles:    true,
                cancelable: false,
                composed:   true,
                detail: {
                  name: "loaded",
                }
              }));
        });
    }

    disconnectedCallback() {
      console.log("aku-main removed from page.");
    }

    connectedMoveCallback() {
      console.log("aku-main moved with moveBefore()");
    }

    adoptedCallback() {
      console.log("aku-main moved to new page.");
    }

    attributeChangedCallback(name, oldValue, newValue) {
      console.log(`aku-main, Attribute ${name} has changed from ${oldValue} to ${newValue}.`);
    }
  });