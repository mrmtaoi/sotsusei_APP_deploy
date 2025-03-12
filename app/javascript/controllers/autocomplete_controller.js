import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["input", "results"];

  search() {
    const query = this.inputTarget.value.trim();
    if (query.length < 2) { // 2文字以上で検索
      this.resultsTarget.innerHTML = "";
      return;
    }

    fetch(`/boards/autocomplete?query=${encodeURIComponent(query)}`)
      .then(response => response.json())
      .then(data => {
        this.resultsTarget.innerHTML = "";
        data.forEach((item) => {
          const li = document.createElement("li");
          li.textContent = item;
          li.classList.add("list-group-item", "autocomplete-item");
          li.dataset.action = "click->autocomplete#select";
          this.resultsTarget.appendChild(li);
        });
      });
  }

  select(event) {
    this.inputTarget.value = event.target.textContent;
    this.resultsTarget.innerHTML = "";
  }
}
