$(document).on('turbolinks:load', function(){
  //ファイルの読み込みで発火
  $(".mapContainer").on("change", "#map_uploader", function(){
    // preview用のテンプレを用意
    var mapPreview = $(`
      <img class="mapContainer__previewBox__preview__img">
    `)
    // file読み込み時にデータを取得 => 上記imgタグにセット
    file = this.files[0]
    var reader = new FileReader();
    reader.readAsDataURL(file);
    reader.onload = function(e) {
      mapPreview.attr({src: e.target.result})
    }
    $(".mapContainer__previewBox__preview").empty()
    $(".mapContainer__previewBox__preview").append(mapPreview)
  })
})