module LogItemsHelper
  def milestone_class(log_item)
    log_item.milestone ? "milestone" : ""
  end
end
