$ ->
  $('.table-sortable').sortable
    axis: 'y'
    items: '.item'

    update: (e, ui) ->
      item = ui.item
      item_data = item.data()
      params = { _method: 'put' }
      params[item_data.model_name] = { row_order_position: item.index() }
      $.ajax
        type: 'POST'
        url: item_data.update_url
        dataType: 'json'
        data: params
        console.log(params)

    # ドラッグ幅をテーブルに合わせる
    start: (e, ui) ->
      tableWidth = $(this).width()
      cells = ui.item.children('td')
      widthForEachCell = tableWidth / cells.length + 'px'
      cells.css('width', widthForEachCell)

    # エフェクト付与
    stop: (e, ui) ->
      ui.item.children('td').effect('highlight')