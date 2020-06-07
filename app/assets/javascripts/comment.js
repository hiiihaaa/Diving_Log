$(document).on('turbolinks:load', function(){
  function comment_inputbox(logid){
    $(".post").empty()
    var html =$(`
    <form action='/comments' method='post' accept-charset='UTF-8'>
      <textarea name='come_text' rows='1' cols='50' placeholder='コメント' class='post__textarea'></textarea>
    </form>
    `)
    $("#post_log" + logid).append(html)
  }

  // -------------new------------------
  $(".input__comment").on("click", function(){
    var logid = $(this).data("logid")
    comment_inputbox(logid)
  })

  // ------------create-------------------
  $('.post').on('keypress', function(e){
    if (e.keyCode == 13){
      if (e.shiftKey){
        $.noop()
      } else {
        var come = {come_text: $(".post__textarea").get(0).value, log_id: $(this).data("logid")}
        $.ajax({
          url: '/comments',
          type: 'POST',
          data: come,
          dataType: 'json'
        })
        .done(function(comment){
          var html = $(`
          <div class='comment__Box'>
            <div class='comment__Box__main'>
              <div class='userIcon'>
                <img src=${comment.user_photo} alt='photo' class='userIcon__photo'>
                <div class='userIcon__nickname'>${comment.user_nickname}</div>
              </div>

              <div class='comment__Box__text'>${comment.comment_text}</div>
            </div>

            <div class='comment__Box__option'>
              <form action='/comments' method='delete' accept-charset='UTF-8'>
                <input type='hidden' name='id' value=${comment.id}>
                <input type='submit' class='btn_come_delete' value='削除'>
              </form>
            </div>
          </div>

          `)
          $(`#post_log${comment.log_id}`).empty()
          $(`#comment_log${comment.log_id}`).prepend(html)
        });
      }
    } else{
      $.noop()
    }
  })

  // -------------edit--------------------------
  $('.btn_come_edit').on('click', function(){
    var logid =$(this).parent().parent().data("logid")
    var commentid = $(this).data("commentid")
    comment_inputbox(logid)
    console.log($(`#comment${commentid}`).get(0).innerHTML)
    test = $(`#comment${commentid}`).get(0).innerHTML
    $('.post__textarea').get(0).value = test
  })

})