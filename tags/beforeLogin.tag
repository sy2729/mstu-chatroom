
<beforeLogin>
  
  <div class="main">
    
    
    <div class="login">
      <figure class="logPic">
        <img src="http://via.placeholder.com/235x235" alt="">
      </figure>

      <p class="title">
        Sign In With Google Account
      </p>
      <button class="signIn" onclick={signIn}>SIGN IN</button>
    </div>
  </div>

  <script>
    that = this;
    // that.parent.user = true;
    // that.parent.update();

    //user authentication




      signIn() {
        console.log('hah');
        var provider = new firebase.auth.GoogleAuthProvider();
        firebase.auth().signInWithPopup(provider).then(function (result) {

          var token = result.credential.accessToken;
          // The signed-in user info.
          var user = result.user;
          // ...
          that.parent.user = user;
          console.log('sucess');
          console.log(!!that.parent.user)
          that.parent.update();
        }).catch(function (error) {
          // Handle Errors here.
          var errorCode = error.code;
          var errorMessage = error.message;
          // The email of the user's account used.
          var email = error.email;
          // The firebase.auth.AuthCredential type that was used.
          var credential = error.credential;
          // ...

          console.log(error.code + error.message + error.email)
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
      position: fixed;
      top: 0;
      bottom: 0;
      left: 0;
      right: 0;
      background-color: #FFFFFF;
      border-radius: 3px;
      box-shadow: 2px 4px 8px 1px rgba(0, 0, 0, 0.2);
      margin: auto;
      box-sizing: border-box;
    }

    .main > .login > .logPic {
      width: 235px;
      height: 235px;
      margin: 57.5px auto 10px;
    }

    .main > .login > .title {
      text-align: center;

    }
  </style>
</beforeLogin>
