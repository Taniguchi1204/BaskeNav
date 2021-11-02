// チャットモ-ダルウィンドウ
$(document).on('turbolinks:load', function () {
  $(document).on('click','#modan_open', function () {
    $('.chats--background').addClass('active');
    $('.chats--messages').addClass('active');
  });
  $(document).on('click','#modan_close', function() {
    $('.chats--background').removeClass('active');
    $('.chats--messages').removeClass('active');
  });
  $(document).on('click','#submit', function(){
    $('.chats--contents').animate(
      { scrollTop: $('.chats--contents').get(0).scrollHeight },
    );
  });
});

$(function() {
  $(document).on('click','#following_modan_open', function(){
    $('.user-show--following').fadeIn();
    return false;
  });
  $(document).on('click', '.modan_close1', function(){
    $('.user-show--following').fadeOut();
    return false;
  });
  $(document).on('click','#follower_modan_open', function(){
    $('.user-show--follower').fadeIn();
    return false;
  });
  $(document).on('click','.modan_close2', function(){
    $('.user-show--follower').fadeOut();
    return false;
  });
  $(document).on('click','#search_modan_open', function(){
    $('.search').fadeIn();
    return false;
  });
  $(document).on('click','.modan_close3', function(){
    $('.search').fadeOut();
    return false;
  });

  $(document).on('click','.posts--contents__photo', function(){
    let id = $(this).attr("id");
    $(`#posts--image__background-${id}`).fadeIn();
    return false;
  });

  $(document).on('click',`.posts--image__background`, function(){
    let id = $(this).attr("id");
    $(`#${id}`).fadeOut();
    return false;
  });
})