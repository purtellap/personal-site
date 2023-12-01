const functions = require("firebase-functions");
const nodemailer = require("nodemailer");

const gmailEmail = functions.config().gmail.email;
const gmailPassword = functions.config().gmail.password;

const mailTransport = nodemailer.createTransport({
  service: "gmail",
  auth: {
    user: gmailEmail,
    pass: gmailPassword,
  },
});

exports.sendEmail = functions.firestore
    .document("messages/{docId}")
    .onCreate((snap, context) => {
      const data = snap.data();

      const mailOptions = {
        from: gmailEmail,
        replyTo: data.email,
        to: "purtellap@gmail.com",
        subject: `PS message from ${data.name}`,
        text: `${data.message}\n\n[From ${data.email}]`,
      };

      return mailTransport.sendMail(mailOptions);
    });
