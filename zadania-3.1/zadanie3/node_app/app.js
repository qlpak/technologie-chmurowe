const express = require("express");
const app = express();

app.get("/", (req, res) => {
  res.send("siema");
});

const PORT = 3000;
app.listen(PORT, () => {
  console.log(`server is running on http://localhost:${PORT}`);
});
