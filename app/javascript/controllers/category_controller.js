import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["categorySelect"]

  toggleExtraInput(event) {
    const selectedCategory = event.target.value
    const extraFields = document.querySelectorAll(".extra-field")

    // すべての追加情報フィールドを隠す
    extraFields.forEach(field => field.classList.add("hidden"))

    // 選択されたカテゴリーに応じて表示する
    if (selectedCategory === "食料") {
      document.getElementById("food-field").classList.remove("hidden")
    } else if (selectedCategory === "飲料") {
      document.getElementById("drink-field").classList.remove("hidden")
    } else if (selectedCategory === "電気機器") {
      document.getElementById("electronics-field").classList.remove("hidden")
    } else if (selectedCategory === "衣類") {
      document.getElementById("clothing-field").classList.remove("hidden")
    } else if (selectedCategory === "乾電池") {
      document.getElementById("battery-field").classList.remove("hidden")
    } else if (selectedCategory === "医療・衛生") {
      document.getElementById("medical-field").classList.remove("hidden")
    }
  }
}
