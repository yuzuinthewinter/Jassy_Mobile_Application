const { model, Schema } = require("mongoose");

const userSchema = new Schema(
  {
    phoneNumber: {
      type: String,
      required: true,
      trim: true,
      unique: true,
    },

    password: {
      type: String,
      required: true,
      trim: true,
      unique: true,
    },

    role: {
      type: String,
      enum: ["ADMIN", "USER", "USER_PREMIUM"],
      default: "USER",
    },

    phoneOtp: String,

    info: {
      name: {
        firstname: { type: String },
        lastname: { type: String },
      },
      birthDate: { type: Date },
      genre: {
        type: String,
        enum: ["male", "female", "lgbt"],
        default: "male",
      },
      country: { type: String },
      defaultLanguage: { type: String },
      levelDefaultLanguage: { type: String, enum: [""], default: "" },
      interestedLanguage: { type: String },
      levelInterestedLanguage: { type: String, enum: [""], default: "" },
    },
  },
  { timestamps: true }
);

module.exports = model("User", userSchema);
