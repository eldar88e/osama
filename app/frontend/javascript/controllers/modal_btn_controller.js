import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static values = { name: { type: String, default: "modal" } };

  connect() {
    this.modal = document.getElementById(this.nameValue);
    this.body = document.querySelector("body");
  }

  open() {
    if (!this.modal) return;

    setTimeout(() => {
      this.modal.classList.remove("hidden");
      this.modal.removeAttribute("aria-hidden");
      this.modal.removeAttribute("inert");
      this.body.style.overflow = "hidden";
    }, 100);
  }
}
