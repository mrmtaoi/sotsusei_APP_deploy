import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static get targets() {
    return ["input", "results"]
  }

  search(event) {
    const query = event.target.value
    if (query.length < 1) { 
      this.clearResults() 
      return
    }

    fetch(`/boards/autocomplete?query=${encodeURIComponent(query)}`, { 
      headers: { "Accept": "application/json" },
    })
      .then(response => response.json())
      .then(data => this.displayResults(data))
  }

  // 結果を表示
  displayResults(results) {
    this.clearResults()  // 古い結果をクリア

    if (results.length === 0) return

    results.forEach(result => {
      const li = document.createElement("li")
      li.classList.add("list-group-item")
      li.textContent = result
      li.addEventListener("click", () => this.selectResult(result))  // クリックで選択
      this.resultsTarget.appendChild(li)
    })
  }

  // 結果を選択したとき
  selectResult(result) {
    this.inputTarget.value = result  // 入力フィールドに選択された結果をセット
    this.clearResults()  // 結果を消去
  }

  // 結果をクリアする
  clearResults() {
    this.resultsTarget.innerHTML = ""
  }
}
