const express = require("express");
const { MongoClient } = require("mongodb");

const app = express();
const port = 3003;
const mongoUrl = "mongodb://db:27017";

app.get("/users", async (req, res) => {
  try {
    const client = await MongoClient.connect(mongoUrl);
    const db = client.db("test");
    const users = await db.collection("users").find().toArray();
    res.json(users);
    client.close();
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

app.listen(port, () => {
  console.log(`API server listening on port ${port}`);
});
