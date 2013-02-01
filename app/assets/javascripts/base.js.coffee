$ ()->
  controller = $("body").data("controller")
  action = $("body").data("action")
  
  if Backlog[controller]?
    instance = new Backlog[controller]()
    instance["init"]() if typeof(instance["init"]) == "function"
    instance["init#{action}"]() if typeof(instance["init#{action}"]) == "function"
  