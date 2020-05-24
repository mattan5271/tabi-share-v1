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
    // イベントの時間表示を２４時間に
    timeFormat: "HH:mm",
    // イベントの色を変える
    eventColor: '#63ceef',
    // イベントの文字色を変える
    eventTextColor: '#000000',
  });
});

// 多階層ジャンルフォーム
$(function () {
  $(".toppage__footer-nav-category").hover(function () {
    $("ul.category1").toggle();
  });
  $(".toppage__footer-nav-category li ul").hide();
  $(".toppage__footer-nav-category li").hover(function () {
    $(">ul:not(:animated)", this).stop(true, true).slideDown("fast");
    $(">a", this).addClass("active");
  }, function () {
    $(">ul:not(:animated)", this).stop(true, true).slideUp("fast");
    $(">a", this).removeClass("active");
  });
});

$(function () {
  // カテゴリーセレクトボックスのオプションを作成
  function appendOption(category) {
    var html = `<option value="${category.name}" data-category="${category.id}">${category.name}</option>`;
    return html;
  }
  // 子カテゴリーの表示作成
  function appendChidrenBox(insertHTML) {
    var childSelectHtml = '';
    childSelectHtml = `<div class='listing-select-wrapper__added' id='children_wrapper'>
                        <div class='listing-select-wrapper__box'>
                          <select class="listing-select-wrapper__box--select form-control" id="child_category" name="[child_name]">
                            <option value="---" data-category="---">---</option>
                            ${insertHTML}
                          </select>
                          <i class='fas fa-chevron-down listing-select-wrapper__box--arrow-down'></i>
                        </div>
                      </div>`;
    $('.listing-product-detail__category').append(childSelectHtml);
  }
  // 孫カテゴリーの表示作成
  function appendGrandchidrenBox(insertHTML) {
    var grandchildSelectHtml = '';
    grandchildSelectHtml = `<div class='listing-select-wrapper__added' id='grandchildren_wrapper'>
                              <div div class='listing-select-wrapper__box'>
                                <select select class="listing-select-wrapper__box--select form-control" id="grandchild_category" name="[grandchild_name]">
                                  <option value="---" data-category="---">---</option>
                                  ${insertHTML}
                                </select>
                                <i class='fas fa-chevron-down listing-select-wrapper__box--arrow-down'></i>
                              </div>
                            </div>`;
    $('.listing-product-detail__category').append(grandchildSelectHtml);
  }
  // 親カテゴリー選択後のイベント
  $('#parent_category').on('change', function () {
    var parentCategory = document.getElementById('parent_category').value; //選択された親カテゴリーの名前を取得
    console.log(parentCategory)
    if (parentCategory != "---") { //親カテゴリーが初期値でないことを確認
      $.ajax({
          url: 'get_category_children',
          type: 'GET',
          data: {
            parent_name: parentCategory
          },
          dataType: 'json'
        })
        .done(function (children) {
          $('#children_wrapper').remove(); //親が変更された時、子以下を削除するする
          $('#grandchildren_wrapper').remove();
          $('#size_wrapper').remove();
          $('#brand_wrapper').remove();
          var insertHTML = '';
          children.forEach(function (child) {
            insertHTML += appendOption(child);
          });
          appendChidrenBox(insertHTML);
        })
        .fail(function () {
          alert('カテゴリー取得に失敗しました');
        })
    } else {
      $('#children_wrapper').remove(); //親カテゴリーが初期値になった時、子以下を削除するする
      $('#grandchildren_wrapper').remove();
      $('#size_wrapper').remove();
      $('#brand_wrapper').remove();
    }
  });
  // 子カテゴリー選択後のイベント
  $('.listing-product-detail__category').on('change', '#child_category', function () {
    var childId = $('#child_category option:selected').data('category'); //選択された子カテゴリーのidを取得
    if (childId != "---") { //子カテゴリーが初期値でないことを確認
      $.ajax({
          url: 'get_category_grandchildren',
          type: 'GET',
          data: {
            child_id: childId
          },
          dataType: 'json'
        })
        .done(function (grandchildren) {
          if (grandchildren.length != 0) {
            $('#grandchildren_wrapper').remove(); //子が変更された時、孫以下を削除するする
            $('#size_wrapper').remove();
            $('#brand_wrapper').remove();
            var insertHTML = '';
            grandchildren.forEach(function (grandchild) {
              insertHTML += appendOption(grandchild);
            });
            appendGrandchidrenBox(insertHTML);
          }
        })
        .fail(function () {
          alert('カテゴリー取得に失敗しました');
        })
    } else {
      $('#grandchildren_wrapper').remove(); //子カテゴリーが初期値になった時、孫以下を削除する
      $('#size_wrapper').remove();
      $('#brand_wrapper').remove();
    }
  });
});

// 多階層ジャンル検索ウィンドウ
$(function () {
  // 子カテゴリーを追加するための処理です。
  function buildChildHTML(child) {
    var html = `<a class="child_category" id="${child.id}"
                href="/user/tourist_spot/genre/search?genre_search=${child.id}">${child.name}</a>`;
    return html;
  }

  $(".parent_category").on("mouseover", function () {
    var id = this.id //どのリンクにマウスが乗ってるのか取得します
    $(".child_category").remove(); //一旦出ている子カテゴリ消します！
    $(".grand_child_category").remove(); //孫、てめえもだ！
    $.ajax({
      type: 'GET',
      url: '/category/new', //とりあえずここでは、newアクションに飛ばしてます
      data: {
        parent_id: id
      }, //どの親の要素かを送ります。params[:parent_id]で送られる
      dataType: 'json'
    }).done(function (children) {
      children.forEach(function (child) { //帰ってきた子カテゴリー（配列）
        var html = buildChildHTML(child); //HTMLにして
        $(".children_list").append(html); //リストに追加します
      })
    });
  });

  // 孫カテゴリを追加する処理です。基本的に子要素と同じです！
  function buildGrandChildHTML(child) {
    var html = `<a class="grand_child_category" id="${child.id}"
                href="/user/tourist_spot/genre/search?genre_search=${child.id}">${child.name}</a>`;
    return html;
  }

  $(document).on("mouseover", ".child_category", function () { //子カテゴリーのリストは動的に追加されたHTMLのため
    var id = this.id
    $.ajax({
      type: 'GET',
      url: '/category/new',
      data: {
        parent_id: id
      },
      dataType: 'json'
    }).done(function (children) {
      children.forEach(function (child) {
        var html = buildGrandChildHTML(child);
        $(".grand_children_list").append(html);
      })
      $(document).on("mouseover", ".child_category", function () {
        $(".grand_child_category").remove();
      });
    });
  });
});