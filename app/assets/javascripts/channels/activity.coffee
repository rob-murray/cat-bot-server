App.activity = App.cable.subscriptions.create "ActivityChannel",
  connected: ->
    #

  disconnected: ->
    #

  received: (data) ->
    console.log("received")
    console.log(data)


