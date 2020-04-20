$(document).on('turbolinks:load', function(){
  img_previews = $(".imgContainer__previews")
  img_uploaders = $(".imgContainer__uploaderBox")
  arr_previews=[]

  $(".imgContainer").on("change", "#img_uploader", function(){
    var preview = $(`
    <div class = "imgContainer__previews__previewBox">
      <img class = "imgContainer__previews__previewBox__img preview_img">
      <div class = "imgContainer__previews__previewBox__delete_btn delete_btn">削除</div>
    </div>
    `)
    
    var uploader = $(`
    <input multiple= "true" name= "imgs[]" id="img_uploader" type="file">
    `)

    file = this.files[0]
    var reader = new FileReader();
    reader.readAsDataURL(file);
    reader.onload = function(e) {
      preview.find('img').attr({src: e.target.result})
    }
    // プレビューの表示
    arr_previews.push(preview)
    $.each(arr_previews, function(i, p){
      p.attr('data-no', i)
      uploader.attr('data-no', i+1)
      img_previews.append(p)
      img_uploaders.prepend(uploader)
    })
  })
  // プレビューの削除---------------------------
  $('.imgContainer').on('click', '.delete_btn', function(){
    targetBox = $(this).parent()
    inputNo = targetBox.data('no')
    targetBox.remove()                       // プレビュー配列から消去
    arr_previews.splice(inputNo, 1)          // プレビュー配列から消去
    $(`input[data-no=${inputNo}]`).remove()  // インプットタグ消去
    num = img_uploaders.children('input').length

    $.each(img_uploaders.children('input'), function(i, input) {
      $(input).attr('data-no', num - i - 1)
    })

    $.each(arr_previews, function(i, p){
      p.attr('data-no', i)
    })
  })
})