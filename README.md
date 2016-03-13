# cat-bot-server
Web server component to cat-bot: Raspberry Pi Python app for scheduled :smile_cat: cat feeder :smile_cat:

cat-bot-server is a Rails 5 app utilising web-sockets. Get over it.

We accept incoming events from the **cat-bot** hardware and then update the UI with the current status.

![cat-bot](activity-view.png?raw=true "Demo of UI")

## TODO

* Add more events such as feeds
* Implement feed button

(See gh issues)

## Development

1. Clone app
1. Run setup `$ bin/setup`
1. Go. `$ bin/rails s`

## API

```
$ curl -H "Content-Type: application/json" -X POST -d '{"event":{"name":"heartbeat","payload":{"next_feed":"evening","remaining_feeds":1}},"user_email":"api@test.com","user_token":"generated"}' http://localhost:3000/events
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/rob-murray/cat-bot-server. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
