const express = require("express");
const router = express.Router();

// const checkAuth = require("../middlewares/checkAuth");
// const checkAdmin = require("../middlewares/checkAdmin");
const {
  registerWithPhoneNumber,
  registerWithFacebook,
  registerWithGoogle,
  loginWithPhoneNumber,
  loginWithFacebook,
  loginWithGoogle,
  setupUserInfo,
  setupPassword,
  verifyPhoneOtp,
} = require("../controllers/auth.controller");

router.get("/", (req, res) => {
  res.send("Hello World");
});

router.get("/registerWithPhoneNumber", (req, res) => {
  res.send("call register with phone number");
});

router.post("/registerWithPhoneNumber", registerWithPhoneNumber);

router.post("/registerWithFacebook", registerWithFacebook);

router.post("/registerWithGoogle", registerWithGoogle);

router.post("/setupPassword", setupPassword);

router.post("/setupUserInfo", setupUserInfo);

router.get("/loginWithPhoneNumber", loginWithPhoneNumber);

router.get("/loginWithFacebook", loginWithFacebook);

router.get("/loginWithGoogle", loginWithGoogle);

router.post("/verifyOtp", verifyPhoneOtp);

// router.get("/checkUser", checkAuth, fetchCurrentUser);

module.exports = router;
