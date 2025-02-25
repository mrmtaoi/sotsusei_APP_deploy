import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["input", "results"];

  search() {
    const query = this.inputTarget.value.trim();
    if (query.length < 2) {
      this.resultsTarget.innerHTML = "";
      return;
    }

    fetch(`/boards/autocomplete?query=${query}`)
      .then(response => response.json())
      .then(data => {
        this.resultsTarget.innerHTML = data
          .map(keyword => `<li class="autocomplete-item" data-action="click->autocomplete#select">${keyword}</li>`)
          .join("");
      })
      .catch(error => {
        console.error("Autocomplete error:", error);
        this.resultsTarget.innerHTML = "<li>エラーが発生しました</li>";  // エラーメッセージを表示
      });
  }

  select(event) {
    this.inputTarget.value = event.target.innerText;
    this.resultsTarget.innerHTML = "";
  }
}
