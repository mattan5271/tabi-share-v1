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

// ドラッグ&ドロップ
$(function () {
  $('.item').sortable({
    update: function (e, ui) {
      var item = ui.item;
      var item_data = item.data();
      var params = {
        _method: 'put'
      };
      params[item_data.modelName] = {
        row_order_position: item.index()
      }

      $.ajax({
        type: 'POST',
        url: item_data.updateUrl,
        dataType: 'json',
        data: params
      });
    }
  });
});