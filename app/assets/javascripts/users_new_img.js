$(document).on('turbolinks:load', function(){
  if(document.URL.includes("users/") && document.URL.includes("/edit") || document.URL.includes("/sign_up")){
    $("#photo_uploader").on("change", function(){
      // preview用のテンプレを用意
      var photoPreview = $('.preview__icon')
      // file読み込み時にデータを取得 => 上記imgタグにセット
      file = this.files[0]
      var reader = new FileReader();
      reader.readAsDataURL(file);
      reader.onload = function(e) {
        photoPreview.attr({src: e.target.result})
      }
    })
  }
})
