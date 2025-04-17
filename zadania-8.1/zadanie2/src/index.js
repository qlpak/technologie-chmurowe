const express = require("express");
const redis = require("redis");
const app = express();
const port = 3000;

app.use(express.json());

const client = redis.createClient({
  url: "redis://redis:6379",
});

client.connect().catch(console.error);

app.post("/message", async (req, res) => {
  const { message } = req.body;
  if (!message) return res.status(400).json({ error: "No message provided" });

  await client.rPush("messages", message);
  res.status(201).json({ status: "Message stored" });
});

app.get("/messages", async (req, res) => {
  const messages = await client.lRange("messages", 0, -1);
  res.json({ messages });
});

app.listen(port, () => {
  console.log(`API running at http://localhost:${port}`);
});
