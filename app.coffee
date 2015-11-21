#!/usr/bin/env coffee

commandLineArgs = require('command-line-args')
readline = require('readline')
kafka = require('kafka-node')
HighLevelProducer = kafka.HighLevelProducer
client = new kafka.Client()
producer = new HighLevelProducer(client)

cli = commandLineArgs([
  { name: 'topic', alias: 't', type: String },
  { name: 'readline', alias: 'r', type: Boolean }
])
parsedCli = cli.parse()

buildReadLine = ->
  readline.createInterface({input: process.stdin, output: process.stdout})

produceMessage = (topic, message, callback) ->
  payloads = [{ topic: topic, messages: message }]
  producer.send payloads, (err, data) ->
    if err
      console.log("Got error", err)
    else
      console.log("Produced message: ", data)

    if callback
      callback()

queryMessage = (topic) ->
  rl = buildReadLine()
  rl.prompt()
  rl.on 'line', (line) ->
    rl.close()
    produceMessage topic, line, ->
      queryMessage(topic)

queryTopic = ->
  rl = buildReadLine()
  rl.question 'Topic to send payload: ', (topic) ->
    rl.close()
    queryMessage(topic)

queryProducerMessage = (topic) ->
  if topic
    queryMessage(options.topic)
  else
    queryTopic()

producer.on 'ready', ->
  console.log("Ready to produce messages")
  if parsedCli.readline
    queryProducerMessage(parsedCli.topic)

exports.send = (topic, message) ->
  console.log("Sending message", message)
  produceMessage(topic, JSON.stringify(message))

