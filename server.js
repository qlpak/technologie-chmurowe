const express = require("express");
const mongoose = require("mongoose");
const app = express();
const PORT = 8080;
const MONGO_URI = process.env.MONGO_URI || "mongodb://root:example@mongo:27017";

mongoose
  .connect(MONGO_URI, {
    useNewUrlParser: true,
    useUnifiedTopology: true,
  })
  .then(() => console.log("Połączono z MongoDB"))
  .catch((err) => console.error("Błąd połączenia z MongoDB", err));

const ItemSchema = new mongoose.Schema({
  name: String,
});
const Item = mongoose.model("Item", ItemSchema);

app.get("/", async (req, res) => {
  const items = await Item.find();
  res.json(items);
});

app.listen(PORT, () => console.log(`Serwer działa na porcie ${PORT}`));
