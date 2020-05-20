$(document).on('turbolinks:load', function(){
  // users#editにおいて、画像読み込み時に表示変更
  if (document.URL.includes("users/") && document.URL.includes("/edit") || document.URL.includes("/sign_up")){
    $("#photo_uploader").on("change", function(){
      var photoPreview = $('.preview__icon')    // preview用のテンプレを用意
      var file = this.files[0]
      var reader = new FileReader();

      reader.readAsDataURL(file);
      reader.onload = function(e) {
        photoPreview.attr({src: e.target.result})
      }
    })
  }
})
