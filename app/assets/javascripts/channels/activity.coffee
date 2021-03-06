App.activity = App.cable.subscriptions.create "ActivityChannel",
  connected: ->
    $status = $("#connection-status")
    $status.removeClass("not-connected")
    $status.addClass("connected")

  disconnected: ->
    $status = $("#connection-status")
    $status.removeClass("connected")
    $status.addClass("not-connected")

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

        $("#feed_status").html(data.feed_status_content)
        $("#events tbody").prepend(data.event_row)
