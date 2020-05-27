$(document).on('turbolinks:load', function () {
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
});