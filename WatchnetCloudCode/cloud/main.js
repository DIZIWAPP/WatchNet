
// Use Parse.Cloud.define to define as many cloud functions as you want.
// For example:
Parse.Cloud.define("hello", function(request, response) {
  response.success("Hello world!");
});

// Include the Twilio Cloud Module and initialize it
var twilio = require("twilio");
twilio.initialize("myAccountSid","myAuthToken");
 
// Create the Cloud Function
Parse.Cloud.define("inviteWithTwilio", function(request, response) {
  // Use the Twilio Cloud Module to send an SMS
  twilio.sendSMS({
    From: "myTwilioPhoneNumber",
    To: request.params.number,
    Body: "Start using Parse and Twilio!"
  }, {
    success: function(httpResponse) { response.success("SMS sent!"); },
    error: function(httpResponse) { response.error("Uh oh, something went wrong"); }
  });
});
