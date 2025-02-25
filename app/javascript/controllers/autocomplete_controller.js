import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["input", "results"];

  search() {
    const query = this.inputTarget.value.trim();
    if (query.length < 2) {
      this.resultsTarget.innerHTML = "";
      return;
    }

    fetch(`/boards/autocomplete?query=${encodeURIComponent(query)}`)
      .then(response => response.json())
      .then(data => {
        this.resultsTarget.innerHTML = data.map(item => 
          `<li class="autocomplete-item" data-id="${item.id}">
            <strong>${item.title}</strong><br>
            <small>${item.description}</small><br>
            <span class="text-muted">${item.items.join(", ")}</span>
          </li>`
        ).join("");
      });
  }

  select(event) {
    if (event.target.closest(".autocomplete-item")) {
      const selectedText = event.target.closest(".autocomplete-item").querySelector("strong").textContent;
      this.inputTarget.value = selectedText;
      this.resultsTarget.innerHTML = "";
    }
  }
}
