// We need to import the CSS so that webpack will load it.
// The MiniCssExtractPlugin is used to separate it out into
// its own CSS file.
import "../css/app.scss"

// webpack automatically bundles all modules in your
// entry points. Those entry points can be configured
// in "webpack.config.js".
//
// Import deps with the dep name or local files with a relative path, for example:
//
//     import {Socket} from "phoenix"
//     import socket from "./socket"
//
import "phoenix_html"
import socket from "./socket"

let channel = socket.channel("room:lobby", {});

channel.join()
  .receive("ok", resp => { console.log("Joined successfully", resp) })
  .receive("error", resp => { console.log("Unable to join", resp) });

let messageInput = document.getElementById("messageInput");
let messageOutput = document.getElementById("messageOutput");

messageInput.onkeydown = (event) => {
  if (event.keyCode === 13) {
    channel.push("shout", { message: event.target.value });
    messageInput.value = "";
  }
}

channel.on("shout", (data) => {
  var messageElement = document.createElement("p");
  var textNode = document.createTextNode(data.message);
  messageElement.classList.add("message");
  messageElement.appendChild(textNode);
  messageOutput.appendChild(messageElement);
});
