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
//= require popper
//= require bootstrap-sprockets
//= require moment
//= require fullcalendar

//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require_tree .
//= require underscore
//= require gmaps/google

$(function () {
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
                }
            });
        }
    });
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
