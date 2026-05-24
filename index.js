// load environment variables
require("dotenv").config();

// init express app
const express = require("express");
const app = express();

// body parser middleware
const bp = require("body-parser");
app.use(bp.json());

// amqp connection
const amqp = require("amqplib");
const amqpServer = process.env.AMQP_URL;
var channel, connection;

// connect to the queue
connectToQueue();

// connect to the queue function
async function connectToQueue() {
  // create connection and channel
  connection = await amqp.connect(amqpServer);
  channel = await connection.createChannel();

  // assert the queue exists
  try {
    const queue = "order";
    await channel.assertQueue(queue);
    console.log("Connected to the queue!");
  } catch (ex) {
    console.error(ex);
  }
}

// create order endpoint
app.post("/order", (req, res) => {
  const { order } = req.body;
  createOrder(order);
  res.send(order);
});

// create order function
const createOrder = async (order) => {
  // send order to the queue
  const queue = "order";
  await channel.sendToQueue(queue, Buffer.from(JSON.stringify(order)));
  console.log("Order succesfully created!");

  // close connection on exit
  process.once("SIGINT", async () => {
    console.log("got sigint, closing connection");
    await channel.close();
    await connection.close();
    process.exit(0);
  });
};

// start the server
app.listen(process.env.PORT, () => {
  console.log(`Server running at ${process.env.PORT}`);
});
