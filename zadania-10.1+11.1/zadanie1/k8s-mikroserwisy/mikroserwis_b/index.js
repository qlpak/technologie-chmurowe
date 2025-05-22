const express = require("express");
const app = express();
const PORT = 3001;

app.get("/hello", (req, res) => {
  res.send("Hello from mikroserwis_b!");
});

app.listen(PORT, () => {
  console.log(`mikroserwis_b listening on port ${PORT}`);
});
