// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery3
//= require jquery
//= require jquery-ui

//= require popper
//= require bootstrap-sprockets
//= require moment
//= require fullcalendar
//= require chartkick
//= require Chart.bundle

//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require_tree .
//= require underscore
//= require gmaps/google

// 画面遷移を検知
$(document).on('turbolinks:load', function () {
if ($('#calendar').length) {
  var url = location.pathname

    function Calendar() {
      return $('#calendar').fullCalendar({
      });
    }
    function clearCalendar() {
      $('#calendar').html('');
    }

    $(document).on('turbolinks:load', function () {
      Calendar();
    });
    $(document).on('turbolinks:before-cache', clearCalendar);

    //events: '/events.json', 以下に追加
    $('#calendar').fullCalendar({
      events: `${url}.json`,
    //カレンダー上部を年月で表示させる
      titleFormat: 'YYYY年 M月',
    //曜日を日本語表示
      dayNamesShort: ['日', '月', '火', '水', '木', '金', '土'],
    //ボタンのレイアウト
      header: {
        left: 'month, agendaWeek, agendaDay',
        center: 'title',
        right: 'today prev,next'
      },
      defaultView: 'month',
    //終了時刻がないイベントの表示間隔
      defaultTimedEventDuration: '03:00:00',
      buttonText: {
        prev: '前',
        next: '次',
        today: '今日',
        month: '月',
        week: '週',
        day: '日'
      },
      navLinks: true,
      // Drag & Drop & Resize
      editable: true,
      //イベントの時間表示を２４時間に
      timeFormat: "HH:mm",
      //イベントの色を変える
      eventColor: '#87cefa',
      //イベントの文字色を変える
      eventTextColor: '#000000',

      eventRender: function(event, element) {
        element.css("font-size", "0.8em");
        element.css("padding", "5px");
      },
      eventClick: function(calEvent, jsEvent, view) {
        // 予約情報のモーダルウィンドウ
        let startDate = moment(calEvent.start, "YYYY-MM-DD");
        let endDate = moment(calEvent.end, "YYYY-MM-DD");
　　　　let start_changeDate = startDate.format('YYYY年MM月DD日 HH:mm');
　　　　let end_changeDate = endDate.format('YYYY年MM月DD日 HH:mm');

　　　　if (calEvent.with_friend == true) {
　　　　  $('#modalName').html(`予約者：${calEvent.name}<a href="/users/${calEvent.user}">（マイページへ）</a>`);
　　　　} else {
　　　　  $('#modalName').html(`予約者：${calEvent.name}`);
　　　　}
        $('#modalNumber').html(`参加人数：${calEvent.number}名`);
        $('#modalTime').html(`日時：${start_changeDate}〜${end_changeDate}`);

        if (calEvent.with_friend == true){
          $('#modalFriend').html(`合流可否：一緒に参加可`);
        } else {
          $('#modalFriend').html(`合流可否：参加不可`);
        }

        $('#modalStatus').html(`ステータス：${calEvent.title}`);

        if (calEvent.comment != null) {
          $('#modalComment').html(`コメント：${calEvent.comment}`);
        }

        $('#modalPhone').html(`電話番号：${calEvent.phone_number}`);
        $('#modalEmail').html(`Email：${calEvent.email}`);

        if (calEvent.title == "承認待ち") {
          $('#modalConfirm').html(`<a href="/facilities/${calEvent.facility_id}/reserve_facilities/${calEvent.id}" data-method="patch">予約承認</a>`);
        } else {
          $('#modalConfirm').html(`<a href="/facilities/${calEvent.facility_id}/reserve_facilities/${calEvent.id}" data-method="patch">承認キャンセル</a>`);
        }

        $('#modalDestroy').html(`<a href="/facilities/${calEvent.facility_id}/reserve_facilities/${calEvent.id}" data-method="delete"　data-confirm="【確認】アカウントを削除してもよろしいですか？">削除</a>`);
        $('#calendarModal').modal(); // モーダル着火
      },
    });
  }
});

// チャットモダンウィンドウ
$(function () {
  $('#modan_open').on('click', function () {
    $('.chats--background').addClass('active');
    $('.chats--messages').addClass('active');
  });
  $('#modan_close').on('click', function() {
    $('.chats--background').removeClass('active');
    $('.chats--messages').removeClass('active');
  });
  $('#submit').on('click', function(){
    $('.chats--contents').animate(
      { scrollTop: $('.chats--contents').get(0).scrollHeight },
    );
  });
});

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
            type: "POST",
            data: {id: delete_ID, "_method": "DELETE"},
            dataType: "json"
          })
          .done(function(data){
            delete_item.remove();
            location.reload();
          })
          .fail(function(){
            alert("エラー");
          })
        }
      }
    })
  });

  //任意のタブにURLからリンクするための設定
$(function() {
  $('.game--years__tab a').on('click', function() {
    let parentElm = $(this).parent(); //タブ内のaタグの親要素（li）を取得
			$('.game--years__tab li').removeClass("active"); //タブ内のliについているactiveクラスを取り除き
			$(parentElm).addClass("active"); //リンク元の指定されたURLのハッシュタグとタブ内のリンク名が同じであれば、liにactiveクラスを追加
	})
})

// 上記の動きをページが読み込まれたらすぐに動かす
$(window).on('load', function () {
  $('.game--years__tab li:first-of-type').addClass("active"); //最初のliにactiveクラスを追加
});

$(window).on('load', function () {
  $('.slider').slick({
		autoplay: true,//自動的に動き出すか。初期値はfalse。
		infinite: true,//スライドをループさせるかどうか。初期値はtrue。
		speed: 1500,//スライドのスピード。初期値は300。
		slidesToShow: 3,//スライドを画面に3枚見せる
		slidesToScroll: 1,//1回のスクロールで1枚の写真を移動して見せる
		prevArrow: '<div class="slick-prev"></div>',//矢印部分PreviewのHTMLを変更
		nextArrow: '<div class="slick-next"></div>',//矢印部分NextのHTMLを変更
		centerMode: true,//要素を中央ぞろえにする
		variableWidth: true,//幅の違う画像の高さを揃えて表示
		dots: true,//下部ドットナビゲーションの表示
	});
});

$(window).on('load scroll',function (){
	$('.main-contents--fadein').each(function(){
		//ターゲットの位置を取得
		var target = $(this).offset().top;
		//スクロール量を取得
		var scroll = $(window).scrollTop();
		//ウィンドウの高さを取得
		var height = $(window).height();
		//ターゲットまでスクロールするとフェードインする
		if (scroll > target - height){
			//クラスを付与
			$(this).addClass('active');
		}
	});
});