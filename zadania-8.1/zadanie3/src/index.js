const express = require("express");
const redis = require("redis");
const { Pool } = require("pg");
const app = express();
const port = 3000;

app.use(express.json());

const redisClient = redis.createClient({ url: "redis://redis:6379" });
redisClient.connect().catch(console.error);

const pgPool = new Pool({
  user: "postgres_user",
  host: "postgres",
  database: "postgres_db",
  password: "postgres_pass",
  port: 5432,
});

pgPool
  .connect()
  .then(() => console.log("Connected to PostgreSQL"))
  .catch((err) => console.error("PostgreSQL connection error:", err));

app.post("/message", async (req, res) => {
  const { message } = req.body;
  if (!message) return res.status(400).json({ error: "No message provided" });

  await redisClient.rPush("messages", message);
  res.status(201).json({ status: "Message stored" });
});

app.get("/", (req, res) => {
  res.send("API is working hello!");
});

app.get("/messages", async (req, res) => {
  const messages = await redisClient.lRange("messages", 0, -1);
  res.json({ messages });
});

app.post("/user", async (req, res) => {
  const { name } = req.body;
  if (!name) return res.status(400).json({ error: "No name provided" });

  await pgPool.query(
    "CREATE TABLE IF NOT EXISTS users (id SERIAL PRIMARY KEY, name TEXT)"
  );
  await pgPool.query("INSERT INTO users(name) VALUES($1)", [name]);
  res.status(201).json({ status: "User added" });
});

app.get("/users", async (req, res) => {
  const result = await pgPool.query("SELECT * FROM users");
  res.json({ users: result.rows });
});

app.listen(port, () => {
  console.log(`API running at http://localhost:${port}`);
});
