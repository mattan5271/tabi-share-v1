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