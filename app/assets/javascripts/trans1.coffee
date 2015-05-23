window.Trans1 =
  Controllers: {}
  Routers: {}
  Views: {}
  Models: {}
  Collections: {}
  Instances: {}

  addInstance: (variableName, instance) ->
    Trans1.Instances[variableName] = instance

  getInstance: (variableName) ->
    Trans1.Instances[variableName]
