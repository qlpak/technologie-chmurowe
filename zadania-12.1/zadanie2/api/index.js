const express = require("express");
const app = express();
const port = 3000;

app.get("/", (req, res) => {
  res.json({ message: "hello from arm64 node.js api is here" });
});

app.listen(port, () => {
  console.log(`API listening on port ${port}`);
});
