import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ["categorySelect", "extraFields"];

  toggleExtraInput(event) {
    console.log("カテゴリが変更されました:", event.target.value);

    const selectedCategory = event.target.value;
    const extraFields = document.querySelectorAll(".extra-field");

    // すべての追加情報フィールドを隠す
    extraFields.forEach(field => field.classList.add("hidden"));

    // 選択されたカテゴリーに応じて表示する
    if (selectedCategory === "食料") {
      console.log("食料選択されました");
      document.getElementById("food-field").classList.remove("hidden");
    } else if (selectedCategory === "飲料") {
      console.log("飲料選択されました");
      document.getElementById("drink-field").classList.remove("hidden");
    } else if (selectedCategory === "電気機器") {
      console.log("電気機器選択されました");
      document.getElementById("electronics-field").classList.remove("hidden");
    } else if (selectedCategory === "衣類") {
      console.log("衣類選択されました");
      document.getElementById("clothing-field").classList.remove("hidden");
    } else if (selectedCategory === "乾電池") {
      console.log("乾電池選択されました");
      document.getElementById("battery-field").classList.remove("hidden");
    } else if (selectedCategory === "医療・衛生") {
      console.log("医療・衛生選択されました");
      document.getElementById("medical-field").classList.remove("hidden");
    }
  }
}
