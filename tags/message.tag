<message>
	<div class="clearfix">
		<div class={message-wrap: true, float-right: msg.author === `${this.author}`} ref="messageWrap">
			<span class="name" style={"background: " + msg.color +";"}>{msg.author} :</span>
			<div class={message-content: true, float-left: msg.author === `${this.author}`, float-none: msg.author !== `${this.author}`}>
				{ msg.message }
				<br>
				<span class="time">{msg.time}</span>
				<div class="status" show= {showStatus}>
					<div class="status-inner-wrapper">
						<span class="up">
							<i class="fa fa-thumbs-o-up" onclick={thumbsUp}></i>
							{msg.up}
						</span>
						<span class="down">
							<i class="fa fa-thumbs-o-down" onclick={thumbsDown}></i>
							 {msg.down}
						</span>
						<span class="delete">
							<i class="fa fa-trash-o" onclick={delete}></i>
						</span>
					</div>
				</div>
			</div>
		</div>
	</div>

	<script>
		var that = this;
		this.author = this.parent.username;
		this.showStatus = false;


		//Manipulate the DOM to show and hide the icon-------------------
		this.on('mount', function() {
			this.refs.messageWrap.addEventListener('mouseover', function(event) {
				event.currentTarget.childNodes[3].childNodes[5].style.display = "block";
			})
			this.refs.messageWrap.addEventListener('mouseout', function(event) {
				event.currentTarget.childNodes[3].childNodes[5].style.display = "none";
			})

			var messageWraps = document.querySelectorAll('.message-wrap');
			var lastMessage = messageWraps[messageWraps.length -1]
			lastMessage.style.marginBottom = 50+'px';
		})


		thumbsUp(e) {
			id = e.item.msg.id;
			
			messagesRef.child(id).child('up').set(e.item.msg.up++);


// anyway, fail to get the data and addup by 1------------, will solve next time
			// messagesRef.child(id).child('up').once('value', function(e) {
			// 	console.log(e.val());
			// 	var preUp = e.val();
			// 	messagesRef.child(id).child('up').set(preUp+1);
			// })


			//change the icon color
			e.currentTarget.style.color = "green";
		}
		thumbsDown(e) {
			id = e.item.msg.id;
			var preDown = messagesRef.child(id).child('up');
			messagesRef.child(id).child('down').set(e.item.msg.down++);

			e.currentTarget.style.color = "red";
		}
		delete(e) {
			this.parent.deletingMessage = true;
			var id = e.item.msg.id;
			messagesRef.child(this.parent.currentRoom.roomKey).child('message').child(id).remove();
		}

	</script>

	<style>
		:scope {
			display: block;
			padding: 0.5em;
		}
		:scope:not(:last-child) {
			margin-bottom: 1em;
		}

		.name {
			font-size: 0.8em;
			background: #F9C968;
			padding: 2px 7px;
			border-radius: 2px;
		}

		.time {
			position: absolute;
			bottom: -12px;
			color: #AAAAAB;
			font-size: 10px;
		}

		.message-content {
			display: inline-block;
			background: #FFFFFF;
			padding: 6px 40px 6px 6px;
			vertical-align: text-top;
			border-radius: 4px;
			margin-left: 10px;
			position: relative;
			box-sizing: border-box;
			color: #273138;
			max-width: 400px;
		}

		.message-content.float-none:after {
			content: '';
			position: absolute;
			top: 0px;
			left: -9px;
			width: 0px;
			height: 0px;
			border: 10px solid transparent;
			border-top-color: #FFFFFF;
			border-radius: 0px;
			transform: rotate(23deg);
		}

		.message-content.float-left {
			background-color: #A5E369;
		}

		.message-content.float-left:after {
			content: '';
			position: absolute;
			top: 0px;
			right: -9px;
			width: 0px;
			height: 0px;
			display: block;
			border: 10px solid transparent;
			border-top-color: #A5E369;;
			border-radius: 0px;
			transform: rotate(-23deg);
		}

		.message-content.float-left .status {
			left: -30px;
			color: #273138;
		}

		.float-left {
			float: left;
			margin-right: 14px;
		}

		.float-right {
			float: right;
		}

		.clearfix:after {
			content: "";
			clear: both;
			display: table;
		}

		.status {
			position: absolute;
			right: -30px;
    		top: 7px;

		}

		.status-inner-wrapper {
			display: flex;
			flex-direction: column;
		}

		.down i, .up i, .delete i {
			cursor: pointer;
		}
	</style>
</message>
