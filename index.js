// load environment variables
require("dotenv").config();

// init express app
const express = require("express");
const app = express();

// body parser middleware
const bp = require("body-parser");

// amqp connection
const amqp = require("amqplib");
const amqpServer = process.env.AMQP_URL;
var channel, connection;

// connect to the queue
connectToQueue();

// connect to the queue function
async function connectToQueue() {
  try {
    // create connection and channel
    connection = await amqp.connect(amqpServer);
    channel = await connection.createChannel();
    await channel.assertQueue("order");

    // consume messages from the queue
    channel.consume("order", (data) => {
      console.log(`Order received: ${Buffer.from(data.content)}`);
      console.log("** Will be shipped soon! **\n");
      channel.ack(data);
    });
  } catch (ex) {
    console.error(ex);
  }
}

// start the server
app.listen(process.env.PORT, () => {
  console.log(`Server running at ${process.env.PORT}`);
});
