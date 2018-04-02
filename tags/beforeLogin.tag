
<beforeLogin>
  
  <div class="main">
    <div class="login">
      <p>
        Sign In With Google Account
      </p>
      <button class="signIn" onclick={signIn}>SIGN IN</button>
    </div>
  </div>

  <script>
    that = this;

    firebase.auth().onAuthStateChanged(function(userObj) {
      that.parent.user = firebase.auth().currentUser;
      console.log(that.parent.user)
    })

    signIn() {
      console.log('hah');
      var provider = new firebase.auth.GoogleAuthProvider();
      firebase.auth().signInWithPopup(provider).then(function (result) {
        console.log('sucess')
      }).catch(function (error) {
        // Handle Errors here.
        var errorCode = error.code;
        var errorMessage = error.message;
        // The email of the user's account used.
        var email = error.email;
        // The firebase.auth.AuthCredential type that was used.
        var credential = error.credential;
        // ...
      });

    }

  </script>

<style>
    :scope p {
      color: #000;
    }
    .main {
      position: fixed;
      top: 0;
      left: 0;
      bottom: 0;
      right: 0;
      background: url("./../bg.jpg");
      background-position: center;
      background-repeat: no-repeat;
      background-size: cover;
    }

    .main > .login {
      width: 380px;
      height: 640px;
      /* position: fixed; */
      top: 0;
      bottom: 0;
      left: 0;
      right: 0;
      background-color: #FFFFFF;
      border-radius: 3px;
      box-shadow: 2px 4px 8px 1px rgba(0, 0, 0, 0.2);
      margin: auto;
    }
  </style>
</beforeLogin>
