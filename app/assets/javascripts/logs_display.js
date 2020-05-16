$(document).on('turbolinks:load', function(){
  //logs#showでmainの表示切り替え
  $(".previews__imgsContainer__img").on("click", function(){
    $(".mapInfo__img").attr({src: this.src})
  })

  if (gon.log_imgs.diving_map.url){
    $("#diving_map").attr({src: gon.log_imgs.diving_map.url})
  }else{
    $("#diving_map").attr({src: '/assets/image-regular.svg'})
  }

})