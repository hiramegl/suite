customElements.define(
  "toggles-main",
  class extends HTMLElement {
    static observedAttributes = ["color", "size"];

    constructor() {
      super();
      this.my = {};
      this.my.internals  = this.attachInternals();
      this.my.shadowRoot = this.attachShadow({mode: 'open'});
    }

    connectedCallback() {
      console.log("toggles-main added to page.");
      const el = document.createElement('i');
      el.textContent = 'ASDF';
      this.my.shadowRoot.appendChild(el);

      // event listener in a subcomponent is the SECOND
      // listener invoked
      this.my.user_changed_listener = (e) => this.on_portal_main_user_changed(e);
      window.addEventListener(
        'portal-main:user_changed',
        this.my.user_changed_listener);
    }

    on_portal_main_user_changed_external = function(e) {
      console.log('1) In toggles-main, rx event, user changed:', e);
    }

    on_portal_main_user_changed = function(e) {
      console.log('2) In toggles-main, rx event, user changed:', e);
    }

    disconnectedCallback() {
      console.log("toggles-main removed from page.");
      this.my.shadowRoot.
        querySelector('i').
        removeEventListener(
          'click',
          this.my.user_changed_listener);
    }

    connectedMoveCallback() {
      console.log("toggles-main moved with moveBefore()");
    }

    adoptedCallback() {
      console.log("toggles-main moved to new page.");
    }

    attributeChangedCallback(name, oldValue, newValue) {
      console.log(`toggles-main, Attribute ${name} has changed from ${oldValue} to ${newValue}.`);
    }

    get collapsed() {
      return this.my.internal.states.has("collap");
    }

    set collapsed(flag) {
      if (flag)
        this.my.internal.states.add("collap");
      else
        this.my.internal.states.delete("collap");
    }
  });
