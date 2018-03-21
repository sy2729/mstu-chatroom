<message>
	<div class="clearfix">
		<div class={float-right: msg.author === `${this.author}`}>
			<span class="name" style={"background: " + msg.color +";"}>{msg.author} :</span>
			<span class={message-content: true, float-left: msg.author === `${this.author}`, float-none: msg.author !== `${this.author}`}>{ msg.message }<br>
				<span class="time">{msg.time}</span></span>
		</div>
	</div>

	<script>
		var that = this;
		this.author = this.parent.username;
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
			display: block;
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
	</style>
</message>
