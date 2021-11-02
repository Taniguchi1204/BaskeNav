//インクリメンタルサーチ
$(function() {
  $(".search-input").on("keyup", function() {
    let input = $(".search-input").val();
    $.ajax({
      type: 'GET',
      url: '/search_users',
      data: { keyword: input },
      dataType: 'json'
    })
    .done(function(search_users) {
      $(".search--users").empty();
      if (search_users.length !== 0) {
        search_users.forEach(function(user){
          appendSample(user);
        });
      }
      else {
        appendErrMsgToHTML("一致するユーザーがいません");
      }
    })
  });
});

function appendSample(user) {
  $(".search--users").append(`<div class="search--users__detail">
                                <p class="search--users__name">${user.name}</p>
                                <a href="/users/${user.id}" class="search--users__link">Show</a>
                              </div>`
                            );
}
function appendErrMsgToHTML(msg) {
  $(".search--users").append(`<div class='name'>${ msg }</div>`);
}