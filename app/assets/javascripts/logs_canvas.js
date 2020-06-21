$(document).on('turbolinks:load', function(){
  if (document.URL.includes("logs") && (document.URL.includes("new") || document.URL.includes("edit"))){
    var canvas = document.getElementById('map_canvas');
    var cnv = $('#map_canvas')
    var img_previews = $(".imgContainer__previews")

    if (canvas.getContext) {
      var ctx = canvas.getContext('2d');
      ctx.lineWidth = 5
      ctx.strokeStyle = "#ff0000"
      picture_switch = document.getElementById('picture_switch').value;
      var flag = false;  //お絵描き用のフラグ。マウスの押し込み、離しでON/OFF

      // モードの選択
      $('#picture_switch').on('change', function(){
        picture_switch = document.getElementById('picture_switch').value;
      })
      // エントリーポイント
      cnv.on('mousedown', function(e){
        if (picture_switch == 1) {
          var d_entry = new Image();    //新規画像オブジェクト
          $(d_entry).attr({src: "/images/diving_entry.svg"});   //読み込みたい画像のパス
          ctx.drawImage(d_entry, e.offsetX-25, e.offsetY-25, 50, 50)
        }
      });
      // コースの記入:マウスを押してflagを立て、動きに合わせて描写
      cnv.on('mousedown', function(e){
        if (picture_switch == 2) {
          flag = true;
          ctx.beginPath();
          ctx.moveTo(e.offsetX, e.offsetY);
        }
      });
      cnv.on('mouseup mouseout', function(){
        flag = false
      });
      cnv.on('mousemove', function(e){
        if(flag){
          ctx.lineTo(e.offsetX, e.offsetY);
          ctx.stroke();
        }
      });
      // エキジットポイント
      cnv.on('mousedown', function(e){
        if (picture_switch == 3) {
          var d_exit = new Image();    //新規画像オブジェクト
          $(d_exit).attr({src: "/images/diving_exit.svg"}) ;   //読み込みたい画像のパス
          ctx.drawImage(d_exit, e.offsetX-25, e.offsetY-25, 50, 50)
        }
      });

      // 写真の貼り付け:
      img_previews.on('click', '.preview_img', function(){
        if (picture_switch == 4) {
          l_img = new Image();    //新規画像オブジェクト
          l_img.src = this.src;   //読み込みたい画像のパス

          $(this).parent().parent().find('img').css('border', 'none') // 枠消し
          $(this).css('border', 'solid 1px #ff00ff')                  // 選択imgに枠
          l_img_width  = this.width
          l_img_height = this.height
        }
      })

      cnv.on('mousedown', function(e){
        if (picture_switch == 4) {
          ctx.drawImage(l_img, e.offsetX-l_img_width/2, e.offsetY-l_img_height/2, l_img_width, l_img_height)
        }
      })

      // 描いたコースの消去：ボタンで全消し
      $("#btn_clear").on('click', function(){
        ctx.clearRect(0, 0, canvas.width, canvas.height)
      })
    }
  }
})