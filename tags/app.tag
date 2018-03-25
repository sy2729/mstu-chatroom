<app>

	<div class="wrapper">
		
		<div class="chatLog" ref="chatLog">
			<div class="chatHeading">
				<h3>Welcome to MSTU Chat!</h3>
			</div>
			<!-- Messages go here: -->
			<message each={ msg in chatLog }></message>
		</div>
		<div class="animationBox">

		</div>
		<div class="bottom">
			<span class="user" style={"background: " + randomColor +";"}>{this.username || test}</span>
			<input type="text" ref="messageInput" onkeypress={ sendMsg } placeholder="Enter Message">
			<button type="button" onclick={ sendMsg } class="send">SEND</button>
		</div>
	</div>
	<script>
		var that = this;
		this.color = ["#D74D42", "#FE9F34", "#EE742B", "#83CE8A", "#DADAAE", "#2EA7E7", "#9D4FA8","#A371C8", "#B5C3C7", "#299C2B", "#725E4F", "#F82C21"];
		this.randomIndex = Math.round(Math.random() * (this.color.length -1));
		this.randomColor = this.color[this.randomIndex];

		this.deletingMessage = false;

		this.username = '';

		this.on('mount', function () {

			var askName = function() {
				that.username = prompt("Please enter your name", );
				//--------make sure there must be a name------------//
				  if (that.username === "") {
					// user pressed OK, but the input field was empty
					askName();
				} else if (that.username) {
					return;
				} else {
					// user hit cancel
					askName();
				}

			}
			askName();


		})

		this.on('update', function() {
			//--------always scroll to the bottom when new messages come------------//
			if(!that.deletingMessage) {
				var chatLog = this.refs.chatLog;
				chatLog.scrollTop = chatLog.scrollHeight;
			}
			that.deletingMessage = false;
		})



		// Demonstration Data
		this.chatLog = [
			// { message: "Hello" }, { message: "Hola" }, { message: "Konnichiwa" }
		];


		//-<<<<<<<<<-[[[[[[ method1 ]]]]]-->>>>>>>--------obtain data all in once
		// messagesRef.on('value', function(snapshot) {
		// 	var data = snapshot.val();
		// 	that.chatLog = [];
		// 	for(key in data) {
		// 		that.chatLog.push(data[key]);
		// 	}

		// 	that.update();
		// })


		//-<<<<<<<<<-[[[[[[ method2 ]]]]]-->>>>>>>--------obtain data one by one
		messagesRef.on('child_added', function(e) {
			var data = e.val();
			var id = e.key;
			data.id = id;
			that.chatLog.push(data);
			that.update();
		})

		messagesRef.on('child_removed', function (e) {
			var id = e.key;

			var target;
			for (let i = 0; i < that.chatLog.length; i++) {
				if (that.chatLog[i].id === id) {
					target = that.chatLog[i];
					break
				}
			}
			var index = that.chatLog.indexOf(target);
			that.chatLog.splice(index, 1);

			that.update();
		})
















		sendMsg(e) {
			if (e.type == "keypress" && e.key !== "Enter") {
				e.preventUpdate = true; // Prevents riot from auto update.
				return false; // Short-circuits function (function exits here, does not continue.)
			}

			

			var msg = {
				message: this.refs.messageInput.value
			};

			if(this.refs.messageInput.value !== '') {
				msg.author = this.username;				//record the author
				var time = moment().format('LTS');		
				msg.time = time;						//record the time
				msg.color = this.randomColor;			//record the color
				msg.up = 0;								//record the thumbs-up
				msg.down = 0;							//record the thumbs-down

				messagesRef.push(msg);

				this.clearInput();
			}

			var animateBox = document.querySelector('.animationBox');
			animateBox.classList.add('activate');
			setTimeout(function() {
				animateBox.classList.remove('activate');
			}, 500);

		}

		clearInput(e) {
			this.refs.messageInput.value = "";
			this.refs.messageInput.focus();
		};
		
	</script>




	<style>
		:scope {
			display: block;
			font-family: Helvetica;
			font-size: 1em;
		}

		.chatHeading {
			background: #273138;
			color: #CFD1D2;
			padding: 17.5px 0;
			position: sticky;
			top: 0;
			z-index: 10;
			text-align: center;
		}

		.wrapper {
			width: 85%;
			margin: 0 auto;
			position: relative;
		}

		.bottom {
			background: #FFFFFF;
			display: flex;
			position: relative;
			z-index: 10;
		}

		.chatLog {
			/* padding: 1em; */
			margin-bottom: 3px;
			height: 550px;
			overflow: auto;
			position: relative;
			background: #FFFFFF;
		}

		.animationBox {
			width: 100%;
			height: 36px;
			background-color: #426687;
			right: 0;
			position: absolute;
			bottom: 10px;
			z-index: 9;
		}

		.animationBox.activate {
			animation: sending .4s ease-in-out;
		}

		@keyframes sending {
			from {
				bottom: 10px;	
				width: 100%;
			}
			to {
				bottom: 100px;
    			width: 30%;
    			right: 0;
				opacity: 0;
				background-color: #426687;
			}
		}

		button {
			color: #88C3E8;
		}

		[ref="messageInput"], button {
			font-size: 1em;
			padding: 0.5em;
		}
		[ref="messageInput"] {
			width: 70%;
			flex: 1;
		}

		.send {
			padding: 0.5em 2em;
			background: transparent;
			transition: all .4s;
			cursor: pointer;
		}
		.send:hover {
			background: #222;
			color: #fff;
		}

		.user {
			display: inline-block;
			background: #F9C968;
			padding: 4px 10px;
			line-height: 38px;
		}
	</style>
</app>
