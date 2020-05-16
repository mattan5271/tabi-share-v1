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
//= require activestorage
//= require jquery
//= require bootstrap-sprockets
//= require jquery.jpostal
//= require bxslider
//= require highcharts/highcharts
//= require highcharts/highcharts-more
//= require jquery_ujs
//= require jquery-ui
//= require tag-it
//= require_tree .

// スライドショー
$(document).ready(function () {
  $('.bxslider').bxSlider({
    auto: true, // 自動スライド
    speed: 1000, // スライドするスピード
    moveSlides: 1, // 移動するスライド数
    pause: 3000, // 自動スライドの待ち時間
    maxSlides: 10, // 一度に表示させる最大数
    slideWidth: 250, // 各スライドの幅
    randomStart: true, // 最初に表示するスライドをランダムに設定
    autoHover: true // ホバー時に自動スライドを停止
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
  $("#img_field").change(function () {
    readURL(this);
  });
});

// トップへ戻る
$(function () {

  $('#back a').on('click', function () {
    $('body, html').animate({
      scrollTop: 0
    }, 800);
    return false;
  });
});