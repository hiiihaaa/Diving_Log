$(document).on('turbolinks:load', function(){
  var img_previews = $(".imgContainer__previews")
  var flag_map = false
  var arr_previews = []       //preview用タグの配列
  var arr_new_imgs = []       //imgファイルの配列
  var arr_current_imgs = []   //img_dataの配列

  // divindmapのプレビュー表示------------------------------------
  $("#map_uploader").on("change", function(){
    flag_map = true
    file = this.files[0]
    var reader = new FileReader();
    reader.readAsDataURL(file);
    reader.onload = function(e) {
      $(".mapContainer__previewBox__preview__img").attr({src: e.target.result})
    }
  })

  // 関数：preview用のタグの配列を作成・表示--------------------------------
  function show_previews(URL, data_no){
    var html_preview = $(`
    <div class = "imgContainer__previews__previewBox">
      <img class = "imgContainer__previews__previewBox__img preview_img" data-no ="">
      <div class = "imgContainer__previews__previewBox__delete_btn delete_btn">削除</div>
    </div>
    `)
    html_preview.find('img').attr({src: URL})
    html_preview.find('img').attr('data-no', data_no)
    arr_previews.push(html_preview)
    img_previews.append(html_preview)
  }

  // <logs#edit>既存img_dataの配列を作成-----------------------------------------
  if (document.URL.includes("logs") && document.URL.includes("edit")){
    $.each(gon.current_imgs, function(i, img_data){
      var URL = decodeURI(img_data.l_img_file.url)
      if (!URL.includes("diving-map")){
        show_previews(URL, i)
        img_data.l_img_file.url = URL
        arr_current_imgs.push(img_data)
      }
    })
  }

  // new_imgの追加-------------------------------------------------------------
  $(".imgContainer").on("change", "#img_uploader", function(){
    arr_new_imgs.push(this.files[0])       //追加ファイルを配列に加える
    var reader = new FileReader();
    file = this.files[0]
    reader.readAsDataURL(file);
    reader.onload = function(e) {
      var URL = e.target.result
      var data_no = arr_previews.length
      show_previews(URL, data_no)
    }
  })

  // imgの削除-------------------------------------------------------------------
  $('.imgContainer').on('click', '.delete_btn', function(){
    var targetBox = $(this).parent()
    var data_no = targetBox.find('img').data('no')

    targetBox.remove()                                // 指定したimgの表示を消す
    arr_previews.splice(data_no, 1)                   // preview用のタグの配列から消去
    if (data_no < arr_current_imgs.length) {
      arr_current_imgs.splice(data_no, 1)
    } else {
      arr_new_imgs.splice(data_no - arr_current_imgs.length, 1)
    }
    $.each(arr_previews, function(i, html_preview){
      html_preview.find('img').attr('data-no', i)    // arr_previewsと他の配列の整合性を合わせるナンバリング
    })
  })
  

  // formの送信-------------------------------------------------------------
  $("#logs_form").on("submit", function(e){
    e.preventDefault();
    var diving_map = $('.mapContainer__previewBox')
    var formData = new FormData($("#logs_form").get(0));
    var url = $(this).attr('action')
    var action

    if (document.URL.includes("new")){
      action = 'POST'
    }else if(document.URL.includes("edit")){
      action = 'PATCH'
    }
    if (flag_map){
      $(window).scrollTop(0)
      $(window).scrollLeft(0)
      html2canvas(diving_map.get(0)).then(function(snapshot) {
        var base64 = snapshot.toDataURL('image/jpeg')  //画像をスナップショット(base64)

        var bin = atob(base64.replace(/^.*,/, ''));    //base64のデータ部デコード
        var buffer = new Uint8Array(bin.length);
        for (var i = 0; i < bin.length; i++) {
          buffer[i] = bin.charCodeAt(i);
        }
        var map_img = new File([buffer.buffer], "diving-map.jpeg", {type: "image/jpeg"}) // ファイルオブジェクト生成
        formData.append("log[new_map]", map_img)

        send_formData(formData, url, action)

      })
    } else{
      send_formData(formData, url, action)
    }

    // 関数：送信
    function send_formData(formData, url, action){
      arr_current_imgs.forEach(function(data) {
        formData.append("log[arr_remaining_ids][]", data.id)
      })
      arr_new_imgs.forEach(function(file){
        formData.append("log[arr_new_imgs][]", file)
      })
  
      $.ajax({
        url: url,
        type: action,
        data: formData,
        processData: false,
        contentType: false,
        dataType: 'json'
      })
      .done(function(){
        window.location.href = '/'
      });
    }
  });
})