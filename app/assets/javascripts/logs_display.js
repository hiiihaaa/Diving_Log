$(document).on('turbolinks:load', function(){

  // logs#showでmainの表示切り替え
  $(".logsshowWrap").on("click", ".logBox__previews__imgsContainer__img", function(){
    $("#diving_map").attr({src: this.src})
  })

})