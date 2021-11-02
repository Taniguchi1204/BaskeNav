// 画面遷移を検知
$(document).on('turbolinks:load', function () {
if ($('#calendar').length) {
  var url = location.pathname.split("/");
　var facility_id = url[url.length, 2];

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
      events: `/facilities/${facility_id}.json`,
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
          $('#modalFriend').html(`参加可否：一緒に参加可`);
        } else {
          $('#modalFriend').html(`参加可否：参加不可`);
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