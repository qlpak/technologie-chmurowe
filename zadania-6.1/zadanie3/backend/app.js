const express = require("express");
const mysql = require("mysql2");

const app = express();

function connectWithRetry() {
  const connection = mysql.createConnection({
    host: "database",
    user: "user",
    password: "pass",
    database: "mydb",
  });

  connection.connect((err) => {
    if (err) {
      console.error("DB connection failed, retrying in 5s...");
      setTimeout(connectWithRetry, 5000);
    } else {
      console.log("connected to DB!");
      startServer(connection);
    }
  });
}

function startServer(connection) {
  const app = require("express")();
  app.get("/api", (req, res) => {
    connection.query("SELECT NOW() AS now", (err, results) => {
      if (err) return res.send("DB error: " + err.message);
      res.send("backend is working. DB time: " + results[0].now);
    });
  });
  app.listen(3000, () => console.log("backend running on port 3000"));
}

connectWithRetry();
