importScripts("https://www.gstatic.com/firebasejs/8.6.1/firebase-app.js");
importScripts("https://www.gstatic.com/firebasejs/8.6.1/firebase-messaging.js");



 var firebaseConfig = {
    apiKey: "AIzaSyAk4HFYVBH_meSGGvFypPkuzwNpAy3WG3Y",
    authDomain: "pythagon-c5c27.firebaseapp.com",
    projectId: "pythagon-c5c27",
    storageBucket: "pythagon-c5c27.appspot.com",
    messagingSenderId: "418364324089",
    appId: "1:418364324089:web:20b872b772ef451be00a28",
    measurementId: "G-J4MPEH8FFB"
  };
  // Initialize Firebase
  firebase.initializeApp(firebaseConfig);



  const messaging = firebase.messaging();

  // Optional:
  messaging.onBackgroundMessage((message) => {
    console.log("onBackgroundMessage", message);
  });
