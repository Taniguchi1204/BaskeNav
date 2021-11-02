$(document).on("turbolinks:load", function(){
   //itemを動かすようにする
  $(".posts--contents").sortable({
  });

  // itemがドロップされた時にイベント実施
  $(".user-show--trash-box").droppable({
    accept: ".posts--contents__view",
    activeClass: "move-trash",
    drop: function(e, ui){
      e.preventDefault();
      var delete_message = confirm("削除してもよろしいですか？");
      if(delete_message == true){
        var delete_item = ui.draggable[0];
        //idを取得。
        var delete_ID = ui.draggable.data("post_id");
        var delete_url = "/posts/" + delete_ID;
        $.ajax({
          url: delete_url,
          type: "DELETE",
          data: {id: delete_ID},
          dataType: "json"
        })
        .done(function(data){
          delete_item.remove();
          location.reload();
        })
        .fail(function(){
          alert("削除できませんでした");
        })
      }
    }
  })
});