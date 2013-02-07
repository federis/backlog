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

    $("a.edit-log-item").click ()->
      $log_item = $(@).parents(".log-item")

      $modal = $("#add_item_form").clone()
      $modal.find(".modal-header h3").html("Edit Item")
      
      $form = $("form", $modal)
      $form.attr("action", $log_item.data('update-url'))
      $form.attr("class", "edit_log_item")
      $form.attr("id", "edit_log_item")
      $form.find("#log_item_content").val($log_item.data("content"))
      $form.find("#log_item_desc").val($log_item.data("desc"))
      $form.append("<input name='_method' type='hidden' value='put'>")

      $modal.modal()

      false

    $("a.delete-log-item").click ()->
      $log_item = $(@).parents(".log-item")

      $("#confirm_delete").modal()
      $("#confirm_delete .confirm-delete-button").click ()->
        $.ajax
          url: $log_item.data("update-url")
          type: "POST"
          data: { "_method" : "DELETE" }
        .done ()->
          $("#confirm_delete").modal("hide")
          $log_item.remove()

        false

      false
