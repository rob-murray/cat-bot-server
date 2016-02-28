App.activity = App.cable.subscriptions.create "ActivityChannel",
  connected: ->
    #

  disconnected: ->
    #

  received: (data) ->
    console.log("received")
    switch data.event_type
      when "heartbeat"
        console.log("heartbeat")
        $("#current-state").html data.content


