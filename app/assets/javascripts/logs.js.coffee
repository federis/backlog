class Backlog.Logs
  initShow: ()->
    $(".log").sortable(
        axis: "y"
        update: (e, ui)->
          $el = ui.item
          $.ajax
            url: $el.data('update-url')+"/position"
            type: "POST"
            data: { "position": ui.item.index(), "_method": "PUT" }
    );