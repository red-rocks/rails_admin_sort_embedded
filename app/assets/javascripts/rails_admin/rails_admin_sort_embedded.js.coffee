#= require rails_admin/jquery.mjs.nestedSortable

show_flash = (data)->
  $flash = $('<div>')
    .addClass('nestable-flash alert')
    .append($('<button>').addClass('close').data('dismiss', 'alert').html('&times;'))
    .append($('<span>').addClass('body').html(data))
  $('#rails_admin_nestable').append($flash)
  $flash.fadeIn(200).delay(2000).fadeOut 200, -> $(this).remove()

js_tree_toggle = (e)->
  e.preventDefault()
  e.stopPropagation()
  $t = $(this)
  $t.html "<i class=\"fa fa-spinner fa-spin\"></i>"
  $.ajax
    type: "POST"
    url: $t.attr("href")
    data:
      ajax: true
    success: (r) ->
      $t.attr "href", r.href
      $t.attr "class", r.class + ' js-tree-toggle'
      $t.text r.text
      $t.parent().attr "title", r.text
      return
    error: (e) ->
      alert e.responseText
      return

init = ->
  $('.rails_admin_sort_embedded').each ->
    $t = $(this)
    tree_config = $t.data('config')
    $t.nestedSortable
      handle: '.dd-handle',
      items: ".dd-item"
      maxLevels: 1 #tree_config["max_depth"]
      placeholder: "dd-placeholder"
      tolerance: 'pointer',
      toleranceElement: '> div',

      update: (event, ui) ->

        ids_array = []
        ui.item.closest("ol").find("li").each ->
          ids_array.pop $(this).data("id")

        $.ajax
          type: "POST"
          dataType: "html"
          url: tree_config["update_url"]
          data:
            #item_id: ui.item.data("id")
            embedded_model: tree_config["embedded_model"]
            embedded_field: tree_config["embedded_field"]
            #parent_id: ui.item.parent().parent().data("id")
            #prev_id: ui.item.prev().data("id")
            #next_id: ui.item.next().data("id")
            ids_array: ids_array.join(" ")

          error: (xhr, status, error) ->
            show_flash('Nested Set: fatal error')

          success: (data) ->
            show_flash(data)

$(document).off('pjax:end.rails_admin_sort_embedded').on('pjax:end.rails_admin_sort_embedded', init)
$(document).off('ready.rails_admin_sort_embedded').on('ready.rails_admin_sort_embedded', init)
$(document).on('click', '.js-tree-toggle', js_tree_toggle)

