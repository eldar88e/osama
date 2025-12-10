import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static values = { name: { type: String, default: "modal" } };

  connect() {
    this.modal = this.element;
    // this.element.addEventListener("click", (event) => {
    //   if (event.target === this.element) {
    //     this.close();
    //   }
    // });
    this.body = document.querySelector("body");
  }

  close() {
    this.modal.classList.add("hidden");
    this.modal.setAttribute("aria-hidden", "true");
    this.modal.setAttribute("inert", "");
    this.body.style.overflow = "auto";
  }

  closeBackground(event) {
    if (event.target === this.modal) this.close();
  }
}
