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

// トップへスクロール
$(function () {
  $('#go-top').on('click', function () {
    $('body, html').animate({
      scrollTop: 0
    }, 800);
    return false;
  });
});


// 「ジャンルから探す」へスクロール
$(function () {
  let position = $('#genre-search').offset().top;

  $('#go-genre-search').on('click', function () {
    $('body, html').animate({
      scrollTop: position
    }, 800);
    return false;
  });
});


// 「利用シーンから探す」へスクロール
$(function () {
  let position = $('#scene-search').offset().top;

  $('#go-scene-search').on('click', function () {
    $('body, html').animate({
      scrollTop: position
    }, 800);
    return false;
  });
});


// 「都道府県から探す」へスクロール
$(function () {
  let position = $('#prefecture-search').offset().top;

  $('#go-prefecture-search').on('click', function () {
    $('body, html').animate({
      scrollTop: position
    }, 800);
    return false;
  });
});


// 「現在地から探す」へスクロール
$(function () {
  let position = $('#location-search').offset().top;

  $('#go-location-search').on('click', function () {
    $('body, html').animate({
      scrollTop: position
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

    // カレンダー上部を年月で表示させる
    titleFormat: 'YYYY年 M月',

    // 曜日を日本語表示
    dayNamesShort: ['日', '月', '火', '水', '木', '金', '土'],

    // ボタンのレイアウト
    header: {
      left: '',
      center: 'title',
      right: 'today prev,next'
    },

    // 終了時刻がないイベントの表示間隔
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

    // イベントの時間表示を24時間に
    timeFormat: "HH:mm",

    // イベントの色を変える
    eventColor: '#63ceef',

    // イベントの文字色を変える
    eventTextColor: '#000000',
  });
});


// 多階層ジャンルフォーム
$(function () {

  // ジャンルセレクトボックスのオプションを作成
  function appendOption(genre) {
    var html = `<option value="${genre.name}" data-genre="${genre.id}">${genre.name}</option>`;
    return html;
  }

  // 子ジャンルの表示作成
  function appendChidrenBox(insertHTML) {
    var childSelectHtml = '';
    childSelectHtml = `<div id='children_wrapper'>
                        <select id='child_genre' class='form-control'>
                          <option value='---' data-genre='---'>---</option>
                          ${insertHTML}
                        </select>
                        <i class='fas fa-chevron-down'></i>
                      </div>`;
    $('.genre-form').append(childSelectHtml);
  }

  // 孫ジャンルの表示作成
  function appendGrandchidrenBox(insertHTML) {
    var grandchildSelectHtml = '';
    grandchildSelectHtml = `<div id='grandchildren_wrapper'>
                              <select id='grandchild_genre' class='form-control' name='[grandchild_name]'>
                                <option value='---' data-genre='---'>---</option>
                                ${insertHTML}
                              </select>
                              <i class='fas fa-chevron-down'></i>
                            </div>`;
    $('.genre-form').append(grandchildSelectHtml);
  }

  // 親ジャンル選択後のイベント
  $('#parent-genre').on('change', function () {
    var parentGenre = document.getElementById('parent-genre').value; // 選択された親ジャンルの名前を取得
    if (parentGenre != '---') { // 親ジャンルが初期値でないことを確認
      $.ajax({
          url: '/user/get_genre/children',
          type: 'GET',
          data: {
            parent_name: parentGenre
          },
          dataType: 'json'
        })
        .done(function (children) {
          $('#children_wrapper').remove(); // 親が変更された時、子以下を初期値にする
          $('#grandchildren_wrapper').remove();
          var insertHTML = '';
          children.forEach(function (child) {
            insertHTML += appendOption(child);
          });
          appendChidrenBox(insertHTML);
        })
        .fail(function () {
          alert('ジャンル取得に失敗しました');
        })
    } else {
      $('#children_wrapper').remove(); // 親ジャンルが初期値になった時、子以下を削除
      $('#grandchildren_wrapper').remove();
    }
  });

  // 子ジャンル選択後のイベント
  $('.genre-form').on('change', '#child_genre', function () {
    var childId = $('#child_genre option:selected').data('genre'); // 選択された子ジャンルのidを取得
    if (childId != '---') { // 子ジャンルが初期値でないことを確認
      $.ajax({
          url: '/user/get_genre/grandchildren',
          type: 'GET',
          data: {
            child_id: childId
          },
          dataType: 'json'
        })
        .done(function (grandchildren) {
          if (grandchildren.length != 0) {
            $('#grandchildren_wrapper').remove(); // 子が変更された時、孫以下を初期値にする
            var insertHTML = '';
            grandchildren.forEach(function (grandchild) {
              insertHTML += appendOption(grandchild);
            });
            appendGrandchidrenBox(insertHTML);
          }
        })
        .fail(function () {
          alert('ジャンル取得に失敗しました');
        })
    } else {
      $('#grandchildren_wrapper').remove(); // 子ジャンルが初期値になった時、孫以下を削除
    }
  });
});


// 多階層ジャンル検索ウィンドウ
$(function () {

  // 子ジャンルを作成
  function buildChildHTML(child) {
    var html = `<a class="children-genre" id="${child.id}"
                href="/user/tourist_spot/genre/search?genre_search=${child.id}">${child.name}</a>`;
    return html;
  }

  // どの親ジャンルにマウスが乗っているかによって子ジャンルの表示を変更
  $(".parent-genre").on("mouseover", function () {
    var id = this.id
    $(".children-genre").remove();
    $(".grand_children-genre").remove();
    $.ajax({
        type: 'GET',
        url: '/get_genre/new',
        data: {
          parent_id: id
        },
        dataType: 'json'
      })
      .done(function (children) {
        children.forEach(function (child) {
          var html = buildChildHTML(child);
          $(".children-list").append(html);
        })
      });
  });

  // どの子ジャンルにマウスが乗っているかによって孫ジャンルの表示を変える
  function buildGrandChildHTML(child) {
    var html = `<a class="grand_children-genre" id="${child.id}"
                href="/user/tourist_spot/genre/search?genre_search=${child.id}">${child.name}</a>`;
    return html;
  }

  $(document).on("mouseover", ".children-genre", function () {
    var id = this.id
    $.ajax({
      type: 'GET',
      url: '/get_genre/new',
      data: {
        parent_id: id
      },
      dataType: 'json'
    }).done(function (children) {
      children.forEach(function (child) {
        var html = buildGrandChildHTML(child);
        $(".grand_children-list").append(html);
      })
      $(document).on("mouseover", ".children-genre", function () {
        $(".grand_children-genre").remove();
      });
    });
  });
});