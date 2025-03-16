import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static get targets() {
    return ["input", "results"]
  }

  // 入力が変更されたときに検索を行う
  search(event) {
    const query = event.target.value
    if (query.length < 2) { 
      this.clearResults()  // 検索文字列が2文字未満の場合は結果をクリア
      return
    }

    fetch(`/boards/autocomplete?query=${encodeURIComponent(query)}`, { 
      headers: { "Accept": "application/json" },
    })
      .then(response => response.json())
      .then(data => this.displayResults(data))
  }

  // 結果を表示する
  displayResults(results) {
    this.clearResults()  // 古い結果をクリア

    if (results.length === 0) return

    results.forEach(result => {
      const li = document.createElement("li")
      li.classList.add("list-group-item")
      li.textContent = result
      li.addEventListener("click", () => this.selectResult(result))
      this.resultsTarget.appendChild(li)
    })
  }

  // 結果を選択したとき
  selectResult(result) {
    this.inputTarget.value = result
    this.clearResults()  // 結果を消去
  }

  // 結果をクリアする
  clearResults() {
    this.resultsTarget.innerHTML = ""
  }
}
