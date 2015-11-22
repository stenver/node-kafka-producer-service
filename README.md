# Node kafka producer service

This is a really simple service that lets you produce messages to Kafka topics

## Produce from REPL

Simply run the repl in the folder and start sending messages.
```
npm install
npm install -g coffee-script
coffee
coffee> app = require './app'
{ send: [Function] }
coffee> Ready to produce messages
```
And now you are ready to send messages through `#send`
`#send(topic, message)`

example:
```
coffee> app.send('node-email', {to: "lol"})
Sending message { to: 'lol' }
coffee> Produced message:  { 'node-email': { '0': 253 } }
coffee>
```

## Produce from STDIN

To start the service use the following
```
npm install
npm install -g coffee-script
coffee app.coffee --readline
```

You will be asked to give a name to your topic and after that you can start
producting messages to your kafka topic
```
Topic to send payload: node-email
> { to: "test@example.com", subject: "Hello world" }
Produced message:  { 'node-email': { '0': 197 } }
```

## Options

```
--topic topicName # Specify the topic name when starting the service
--readline        # Takes user input from STDIN
```
