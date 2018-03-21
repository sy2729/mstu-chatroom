<app>

	<h1>Welcome to MSTU Chat!</h1>

	<div class="chatLog" ref="chatLog">
		<!-- Messages go here: -->
		<message each={ msg in chatLog }></message>
	</div>
	<span class="user" style={"background: " + randomColor +";"}>{this.username || test}</span>
	<input type="text" ref="messageInput" onkeypress={ sendMsg } placeholder="Enter Message">
	<button type="button" onclick={ sendMsg } class="send">SEND</button>

	<script>
		var that = this;
		this.color = ["#D74D42", "#FE9F34", "#EE742B", "#83CE8A", "#DADAAE", "#2EA7E7", "#9D4FA8","#A371C8", "#B5C3C7", "#299C2B", "#725E4F", "#F82C21"];
		this.randomIndex = Math.round(Math.random() * (this.color.length -1));
		this.randomColor = this.color[this.randomIndex];

		this.username = '';

		this.on('mount', function () {

			var askName = function() {
				that.username = prompt("Please enter your name", );
				
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
			
			// that.username = prompt("Please enter your name", );
			// if (that.username === "") {
			// 	alert('Type in your name!!!')
			// 	that.username = prompt("Please enter your name", );
			// }else {
			// 	that.username = prompt("Please enter your name", );
			// }
		})



		// Demonstration Data
		this.chatLog = [
			// { message: "Hello" }, { message: "Hola" }, { message: "Konnichiwa" }
		];

		messagesRef.on('value', function(snapshot) {
			var data = snapshot.val();
			that.chatLog = [];
			for(key in data) {
				that.chatLog.push(data[key]);
			}

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
			msg.author = this.username;
			var time = moment().format('LTS');
			msg.time = time;
			msg.color = this.randomColor;
			console.log(msg.author)

			messagesRef.push(msg);

			this.clearInput();
		}

		clearInput(e) {
			this.refs.messageInput.value = "";
			this.refs.messageInput.focus();
		}
		
	</script>

	<style>
		:scope {
			display: block;
			font-family: Helvetica;
			font-size: 1em;
		}

		h1 {
			text-align: center;
		}

		.chatLog {
			border: 1px solid grey;
			padding: 1em;
			margin-bottom: 1em;
			height: 500px;
			overflow: auto;
		}
		[ref="messageInput"], button {
			font-size: 1em;
			padding: 0.5em;
		}
		[ref="messageInput"] {
			width: 70%;
		}

		.send {
			padding: 0.5em 2em;
			background: transparent;
			border-radius: 4px;
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
			border-radius: 2px;
		}
	</style>
</app>
