$(document).on('turbolinks:load', function(){

  // logs#showでmainの表示切り替え
  $(".logBox__previews__imgsContainer__img_s").on("click", function(){
    $("#diving_map").attr({src: this.src})
  })

})