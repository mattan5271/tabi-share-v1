$('.table-sortable').sortable({
  axis: 'y',
  items: '.item',
  update: function (e, ui) {
    var item, item_data, params;
    item = ui.item;
    item_data = item.data();
    params = {
      _method: 'put'
    };
    params[item_data.model_name] = {
      row_order_position: item.index()
    };
    return $.ajax({
      type: 'POST',
      url: item_data.update_url,
      dataType: 'json',
      data: params
    });
  },

  // ドラッグ幅をテーブルに合わせる
  start: function (e, ui) {
    var cells, tableWidth, widthForEachCell;
    tableWidth = $(this).width();
    cells = ui.item.children('td');
    widthForEachCell = tableWidth / cells.length + 'px';
    return cells.css('width', widthForEachCell);
  },

  // エフェクト付与
  stop: function (e, ui) {
    return ui.item.children('td').effect('highlight');
  }
});