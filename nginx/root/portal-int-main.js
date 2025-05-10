customElements.define(
  "portal-int-main",
  class extends HTMLElement {
    static observedAttributes = ["color", "size"];

    constructor() {
      super();
      this.my = {};
      this.my.internals  = this.attachInternals();
      this.my.shadowRoot = this.attachShadow({mode: 'open'});
    }

    connectedCallback() {
      console.log("portal-int-main added to page.");
      const el = document.createElement('html');
      el.innerHTML = '<head><title>asdf</title></head><body>Quack<button>TRIGGER</button></body>';
      this.my.shadowRoot.appendChild(el);

      this.my.click_listener = (e) => this.on_button_click(e);
      this.my.shadowRoot.
        querySelector("button").
        addEventListener(
          "click",
          this.my.click_listener)
    }

    // bubbles:    A boolean value indicating whether the event bubbles.
    //             The default is false.
    // cancelable: A boolean value indicating whether the event can be cancelled.
    //             The default is false.
    // composed:   A boolean value indicating whether the event will trigger
    //             listeners outside of a shadow root. The default is false.
    //             https://developer.mozilla.org/en-US/docs/Web/API/Event/composed
    on_button_click = function(e) {
      console.log('0) In portal-int-main, rx poiner event, button clicked:', e);
      this.dispatchEvent(
        new CustomEvent(
          "portal-int-main:user_changed", {
            bubbles:    true,
            cancelable: true,
            composed:   true,
            detail: {
              userId: "1234",
              userName: "Maka Paka",
            }
          }));
    }

    disconnectedCallback() {
      console.log("portal-int-main removed from page.");
      this.my.shadowRoot.
        querySelector('button').
        removeEventListener(
          'click',
          this.my.click_listener);
    }

    connectedMoveCallback() {
      console.log("portal-int-main moved with moveBefore()");
    }

    adoptedCallback() {
      console.log("portal-int-main moved to new page.");
    }

    attributeChangedCallback(name, oldValue, newValue) {
      console.log(`portal-int-main, Attribute ${name} has changed from ${oldValue} to ${newValue}.`);
    }

    get wicked() {
      return this.my.internal.states.has("wicked");
    }

    set wicked(flag) {
      if (flag)
        this.my.internal.states.add("wicked");
      else
        this.my.internal.states.delete("wicked");
    }
  });
