App.activity = App.cable.subscriptions.create "ActivityChannel",
  connected: ->
    #

  disconnected: ->
    #

  received: (data) ->
    console.log("ActivityChannel.received: "+JSON.stringify(data))

    switch data.event_type
      when "heartbeat"
        $heart = $("#heart")
        $heart.addClass "beat"
        setTimeout (->
          $heart.removeClass "beat"
          return
        ), 2000
