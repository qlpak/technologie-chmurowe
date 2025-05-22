const express = require("express");
const axios = require("axios");

const app = express();
const PORT = 3000;

app.get("/", async (req, res) => {
  try {
    const response = await axios.get("http://mikroserwis-b-service:3001/hello");
    res.send(`Response from mikroserwis_b: ${response.data}`);
  } catch (error) {
    res.status(500).send("Error contacting mikroserwis_b");
  }
});

app.listen(PORT, () => {
  console.log(`mikroserwis_a listening on port ${PORT}`);
});
