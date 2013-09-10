module LogItemsHelper
  def milestone_class(log_item)
    log_item.milestone ? "milestone" : ""
  end

  def complete_button_text(item)
    item.complete? ? "Mark Incomplete" : "Mark Complete"
  end

  def log_item_complete_button(item, button_opts = {})
    form_for [item.log, item], html: { class: "item-complete-form" } do |f|
      f.hidden_field(:complete, value: !item.complete?) + f.submit(complete_button_text(item), button_opts)
    end
  end
end
