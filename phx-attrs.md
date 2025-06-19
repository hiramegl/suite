Here’s a **Phoenix LiveView `phx-` Attributes Cheat Sheet** — a concise, categorized reference for quick lookups.

---

### 🔁 **Event Handling**

| Attribute            | Trigger           | Description                               | Example                            |
| -------------------- | ----------------- | ----------------------------------------- | ---------------------------------- |
| `phx-click`          | Click             | Triggers an event on click                | `<button phx-click="save">`        |
| `phx-change`         | Input change      | Triggers when input changes               | `<form phx-change="validate">`     |
| `phx-submit`         | Form submit       | Triggers on form submit                   | `<form phx-submit="save">`         |
| `phx-blur`           | Blur (lose focus) | Triggers when an element loses focus      | `<input phx-blur="on_blur">`       |
| `phx-focus`          | Focus             | Triggers when an element gains focus      | `<input phx-focus="on_focus">`     |
| `phx-keydown`        | Key down          | Triggers on key press                     | `<input phx-keydown="event">`      |
| `phx-keyup`          | Key up            | Triggers when key is released             | `<input phx-keyup="event">`        |
| `phx-window-keydown` | Key down          | Global key press handler (window-level)   | `<div phx-window-keydown="event">` |
| `phx-window-keyup`   | Key up            | Global key release handler (window-level) | `<div phx-window-keyup="event">`   |

---

### 🕒 **Timing Modifiers**

| Attribute      | Description                                          | Example                      |
| -------------- | ---------------------------------------------------- | ---------------------------- |
| `phx-debounce` | Waits X ms after input stops before triggering event | `<input phx-debounce="300">` |
| `phx-throttle` | Ensures event fires at most every X ms               | `<input phx-throttle="500">` |

---

### ⚙️ **DOM Update Control**

| Attribute    | Purpose                        | Values                                   | Example                     |
| ------------ | ------------------------------ | ---------------------------------------- | --------------------------- |
| `phx-update` | Controls DOM patching behavior | `replace`, `ignore`, `append`, `prepend` | `<div phx-update="append">` |

---

### 🧷 **Data Binding & Custom Payloads**

| Attribute     | Purpose                          | Example                                       | Sent to server as |
| ------------- | -------------------------------- | --------------------------------------------- | ----------------- |
| `phx-value-*` | Pass extra data to the event     | `<button phx-click="vote" phx-value-id="42">` | `%{"id" => "42"}` |
| `phx-key`     | Specify which key triggers event | `<input phx-keyup="submit" phx-key="Enter">`  |                   |

---

### 🧩 **JavaScript Integration**

| Attribute  | Purpose                            | Example                      |
| ---------- | ---------------------------------- | ---------------------------- |
| `phx-hook` | Binds a JS hook to the DOM element | `<div phx-hook="ChartHook">` |

---

### 💾 **Static Asset Tracking**

| Attribute          | Purpose                                | Example                                          |
| ------------------ | -------------------------------------- | ------------------------------------------------ |
| `phx-track-static` | Detects asset changes for live reloads | `<link phx-track-static href="/assets/app.css">` |

---

### 🚀 **Client-Triggered Submissions**

| Attribute            | Purpose                                        | Example                            |
| -------------------- | ---------------------------------------------- | ---------------------------------- |
| `phx-trigger-action` | Auto-submits a form when triggered from server | `<form phx-trigger-action="true">` |

---

### 💡 Bonus

| Attribute           | Purpose                                  | Example                       |
| ------------------- | ---------------------------------------- | ----------------------------- |
| `phx-capture-click` | Intercept clicks before default behavior | `<a phx-capture-click="nav">` |

---

Would you like this in a downloadable PDF or printable format?
