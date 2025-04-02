const express = require("express");
const mysql = require("mysql2");

const app = express();

const connection = mysql.createConnection({
  host: "db",
  user: "testuser",
  password: "testpass",
  database: "testdb",
});

app.get("/", (req, res) => {
  connection.query("SELECT NOW() as now", (err, results) => {
    if (err) {
      res.send("error connecting to the db: " + err.message);
    } else {
      res.send("database connected. db time: " + results[0].now);
    }
  });
});

app.listen(3000, () => {
  console.log("app working on port 3000");
});
