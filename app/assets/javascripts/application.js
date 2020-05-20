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
//= require rails-ujs
//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require jquery-ui/effects/effect-highlight
//= require jquery-ui/widgets/sortable
//= require bootstrap-sprockets
//= require jquery.jpostal
//= require highcharts/highcharts
//= require highcharts/highcharts-more
//= require tag-it
//= require moment
//= require fullcalendar
//= require_tree .

// トップへ戻る
$(function () {

  $('#back a').on('click', function () {
    $('body, html').animate({
      scrollTop: 0
    }, 800);
    return false;
  });
});

// 画像アップロード時にプレビュー
$(function () {
  function readURL(input) {
    if (input.files && input.files[0]) {
      var reader = new FileReader();
      reader.onload = function (e) {
        $('.img_prev').attr('src', e.target.result);
      }
      reader.readAsDataURL(input.files[0]);
    }
  }
  $('.img_field').change(function () {
    readURL(this);
  });
});

// カレンダー
$(function () {
  function eventCalendar() {
    return $('#calendar').fullCalendar({});
  };

  function clearCalendar() {
    $('#calendar').html('');
  };

  $('#calendar').fullCalendar({
    events: '/user/events.json',

    //カレンダー上部を年月で表示させる
    titleFormat: 'YYYY年 M月',
    //曜日を日本語表示
    dayNamesShort: ['日', '月', '火', '水', '木', '金', '土'],
    //ボタンのレイアウト
    header: {
      left: '',
      center: 'title',
      right: 'today prev,next'
    },
    //終了時刻がないイベントの表示間隔
    defaultTimedEventDuration: '03:00:00',
    buttonText: {
      prev: '前',
      next: '次',
      prevYear: '前年',
      nextYear: '翌年',
      today: '今日',
      month: '月',
      week: '週',
      day: '日'
    },
    //イベントの時間表示を２４時間に
    timeFormat: "HH:mm",
    //イベントの色を変える
    eventColor: '#63ceef',
    //イベントの文字色を変える
    eventTextColor: '#000000',
  });
});