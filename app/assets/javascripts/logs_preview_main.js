$(document).on('turbolinks:load', function(){
  //logs#showでmainの表示切り替え
  $(".previews__imgsContainer__img").on("click", function(){
    $(".mapInfo__img").attr({src: this.src})
  })
})