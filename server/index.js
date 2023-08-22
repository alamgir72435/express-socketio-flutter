
const express = require("express");

const app = express();
const SOCKETIO = require('socket.io');

const server = app.listen(5000, () => {
  console.log(`Running on 5000`);
});

const io = SOCKETIO(server); // Use http server instance


// Middleware to attach Socket.IO instance to the request object
app.use((req, res, next) => {
  req.io = io; // Attach the io instance to the req object
  next();
});


app.get('/', (req, res) => {

  const { io } = req;
  io.emit('test-ev', `${new Date().getTime()}`);

  return res.json({});
});





io.on('connection', socket => {
  console.log('User Connected', socket.id);
})