
<beforeLogin>
  
  <div class="main">
    
    
    <div class="login">
      <figure class="logPic">
        <img src="../wechat.png" alt="">
      </figure>

      <p class="title">
        Sign In With Google Account
      </p>
      <button class="signIn" onclick={signIn} ref="loginBtn">SIGN IN</button>
      <p class="help">Any problem with log in? <span class="help-click" click = {retry}>Retry</span></p>
    </div>
  </div>

  <script>
    that = this;
    // that.parent.user = true;
    // that.parent.update();

    //user authentication




      signIn() {
        this.refs.loginBtn.classList.add('loading');
        var provider = new firebase.auth.GoogleAuthProvider();
        firebase.auth().signInWithPopup(provider).then(function (result) {

          var token = result.credential.accessToken;
          // The signed-in user info.
          var user = result.user;
          // ...
          that.parent.user = user;
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

      retry() {
        this.refs.loginBtn.classList.remove('loading');
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
      text-align: center;
    }

    .main > .login > .logPic {
      width: 235px;
      height: 235px;
      margin: 57.5px auto 10px;
    }

    .main > .login > .title {
      text-align: center;
      font-size: 20px;
      color: #353535;
    }
    
    .main > .login > .signIn {
      display: inline;
      border-radius: 5px;
      border: 1px solid #ddd;
      position: relative;
      box-sizing: border-box;
      padding: 10px 30px 10px 20px;
      margin-top: 20px;
      transition: all .4s ease-in-out;
    }
    
    .main > .login > .signIn:after {
      content: ">";
      animation: tempt .5s ease-in-out infinite alternate;
      position: absolute;
      right: 0;
      top: 23%;
    }

    @keyframes tempt {
      from {
       right: 10px;
       opacity: 1;
      }
      to {
        right: 5px;
        opacity: 0;
      }
    }

    .main > .login > .signIn.loading {
      color: transparent;
      width: 40px;
      height: 40px;
      padding: 0;
      border-radius: 50%;
      border: none;
      background: #5AC045;
    }
    
    .main > .login > .signIn.loading:after {
      content: "";
      width: 20px;
      height: 20px;
      position: absolute;
      left: 0;
      top: 0;
      right: 0;
      bottom: 0;
      margin: auto;
      display: block;
      background: transparent;
      border-radius: 50%;
      border-top: 1px solid #fff;
      animation: spin .5s linear infinite;
      transform-origin: center;
    }

    @keyframes spin {
      from {
        transform: rotate(0deg);
      }
      to {
        transform: rotate(360deg);
      }
    }

    .help {
      position: absolute;
      bottom: 10px;
      left: 0;
      right: 0;
      margin: 0 auto;
      font-size: 0.8em;
      color: #888888;

    }

    .help .help-click {
      text-decoration: underline;
      cursor: pointer;
    }
  </style>
</beforeLogin>
