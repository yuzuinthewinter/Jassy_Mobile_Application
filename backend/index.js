const express = require("express");
const mongoose = require("mongoose");
const cors = require("cors");
const bodyParser = require("body-parser");

require("dotenv").config();

const { PORT, MONGODB_URI, NODE_ENV, ORIGIN } = require("./config");
const { API_ENDPOINT_NOT_FOUND_ERR, SERVER_ERR } = require("./errors");

// routes
const authRoutes = require("./routes/auth.route");

// init express app
const app = express();

// middlewares
app.use(express.json());
app.use(
  cors({
    credentials: true,
    origin: ORIGIN,
    optionsSuccessStatus: 200,
  })
);

// log in development environment
if (NODE_ENV === "development") {
  const morgan = require("morgan");
  app.use(morgan("dev"));
}

// index route
app.get("/", authRoutes);

// routes middlewares
app.use("/api/auth", authRoutes);

// global error handling middleware
app.use((err, req, res, next) => {
  console.log(err);
  const status = err.status || 500;
  const message = err.message || SERVER_ERR;
  const data = err.data || null;
  res.status(status).json({
    type: "error",
    message,
    data,
  });
});

mongoose.connect(
  MONGODB_URI,
  async(err)=>{
      if(err) throw err;
      console.log("conncted to db")
  }
);

console.log("database connected");

app.listen(PORT, () => console.log(`Server listening on port ${PORT}`));
