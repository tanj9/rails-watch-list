import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    console.log("hello from navbar_controller!")
  };

  updateNavbar() {
    if (window.scrollY >= 300) {
      this.element.classList.add("navbar-lewagon-black")
    } else {
      this.element.classList.remove("navbar-lewagon-black")
    }
  };
}
