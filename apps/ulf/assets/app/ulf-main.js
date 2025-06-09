customElements.define(
  "ulf-main",
  class extends HTMLElement {
    constructor() {
      super();
      this.my = {};
      this.my.internals  = this.attachInternals();
      this.my.shadowRoot = this.attachShadow({mode: 'open'});
    }

    connectedCallback() {
      fetch("/ulf/").
        then(x => x.text()).
        then(x => {
          this.my.shadowRoot.innerHTML = x;
          this.dispatchEvent(
            new CustomEvent(
              "ulf-main:loaded", {
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
      console.log("ulf-main removed from page.");
    }

    connectedMoveCallback() {
      console.log("ulf-main moved with moveBefore()");
    }

    adoptedCallback() {
      console.log("ulf-main moved to new page.");
    }

    attributeChangedCallback(name, oldValue, newValue) {
      console.log(`ulf-main, Attribute ${name} has changed from ${oldValue} to ${newValue}.`);
    }
  });
