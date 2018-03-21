<message>
	<div class="clearfix">
		<div class={message-wrap: true, float-right: msg.author === `${this.author}`} ref="messageWrap">
			<span class="name" style={"background: " + msg.color +";"}>{msg.author} :</span>
			<div class={message-content: true, float-left: msg.author === `${this.author}`, float-none: msg.author !== `${this.author}`}>
				{ msg.message }
				<br>
				<span class="time">{msg.time}</span>
				<div class="status" show= {showStatus}>
					<span class="up">
						<i class="fa fa-thumbs-o-up" onclick={thumbsUp}></i>
						{msg.up}
					</span>
					<span class="down">
						<i class="fa fa-thumbs-o-down" onclick={thumbsDown}></i>
						 {msg.down}
					</span>
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
		})


		thumbsUp(event) {
			console.log(event.item)
			event.item.msg.up ++

			//change the icon color
			event.currentTarget.style.color = "green";
		}
		thumbsDown(event) {
			console.log(event.item)
			event.item.msg.down ++

			event.currentTarget.style.color = "red";
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
			/* float: right; */
			font-size: 10px;
		}

		.message-content {
			display: inline-block;
			background: #ddd;
			width: 400px;
			padding: 6px; 
			vertical-align: text-top;
			border-radius: 4px;
			margin-left: 10px;
			position: relative;
			box-sizing: border-box;
		}

		.message-content.float-none:after {
			content: '';
			position: absolute;
			top: 0px;
			left: -9px;
			width: 0px;
			height: 0px;
			border: 10px solid transparent;
			border-top-color: #ddd;
			border-radius: 0px;
			transform: rotate(23deg);
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
			border-top-color: #ddd;
			border-radius: 0px;
			transform: rotate(-23deg);
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
			right: 10px;
    		top: 35%;

		}

		.down i, .up i {
			cursor: pointer;
		}
	</style>
</message>
