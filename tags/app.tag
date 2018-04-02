<app>

	<beforeLogin if = { !!!user }></beforeLogin>
	<div class="main" if = { !!user }>
		<h2 style="text-align:center; margin: 15px 0;">Welcome to a MSTU ChatRoom</h2>
	
		<addRoom if={addActive}></addRoom>
	
		<div class="wrapper">
			<div class="user-panel">
				<div class="window-tool">
					<span></span>
					<span></span>
					<span></span>
				</div>
				<div class="user-profile">
					<img src={user.photoURL} alt="user-profile">
				</div>
				<button class="logOut" onclick={logOut}>
					LogOut
				</button>
			</div>
			<div class="contact">
				<div class="navbar">
					<input type="text" placeholder="Search" class="search" onkeyup ={searchTriggered} ref = "search">
					<button class="addRoom" onclick={addRoom}>+</button>
				</div>
				<div class="chatGroup-wrap">
					<div each={i in chatGroup} class="chatGroup" onclick={changeRoom} id={groupHighlight: i.roomKey === currentRoom.roomKey} ref = 'chatGroup'>
						<div class="groupProfile">
							<img src="http://via.placeholder.com/40x40" alt="profile">
						</div>
						<div class="headingWrap">
							<span>
								{ i.roomName }
							</span>
							<span class="groupMessage-preview">
								{ i.message? i.message[Object.keys(i.message)[Object.keys(i.message).length - 1]].author +` : ` + i.message[Object.keys(i.message)[Object.keys(i.message).length - 1]].message:undefined || 'no messages for now'}
							</span>
						</div>
					</div>
				</div>
			</div>
			<div class="chat-wrap">
				<div class="chatLog" ref="chatLog">
					<div class="chatHeading">
						<h3 class="roomName">{currentRoom.roomName}</h3>
					</div>
					<!-- Messages go here: -->
					<message each={ msg in currentRoom.message }></message>
				</div>
				<div class="animationBox">
		
				</div>
				<div class="bottom">
					<span class="user"}>{this.user.displayName || test}</span>
					<input type="text" ref="messageInput" onkeypress={ sendMsg } placeholder="Enter Message">
					<button type="button" onclick={ sendMsg } class="send">SEND</button>
				</div>
			</div>
		</div>
	</div>
	<script>
		var that = this;
		this.addActive = false;
		this.deletingMessage = false;
		this.chatGroup = [];
		this.currentRoom = '';

		this.user = false;


		// this.on('mount', function () {

		// 	var askName = function() {
		// 		that.username = prompt("Please enter your name", );
		// 		//--------make sure there must be a name------------//
		// 		  if (that.username === "") {
		// 			// user pressed OK, but the input field was empty
		// 			askName();
		// 		} else if (that.username) {
		// 			return;
		// 		} else {
		// 			// user hit cancel
		// 			askName();
		// 		}

		// 	}
		// 	askName();

		// })

		this.on('update', function() {
			//--------always scroll to the bottom when new messages come------------//

			if(!!!that.user) {
				if(!that.deletingMessage) {
					var chatLog = this.refs.chatLog;
					chatLog.scrollTop = chatLog.scrollHeight;
				}
				that.deletingMessage = false;
			}
		})



		// Demonstration Data
		this.chatLog = [];


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
		this.on('mount', function() {

			

			messagesRef.on('value', function(e) {
				var roomData = e.val();
				that.chatGroup  = [];
				for(roomName in roomData) {
					that.chatGroup.push(roomData[roomName])
				}
				if(that.currentRoom === '') {
					that.currentRoom = that.chatGroup[0];
				}else{
					that.currentRoom = that.chatGroup.find(function(each){
						return each.roomKey === that.currentRoom.roomKey;
					})
				}
				that.update();
				console.log(that.user)
			})
		
		})



			// messagesRef.child(that.currentRoom).on('child_added', function(e) {
			// 	var data = e.val();
			// 	// console.log(e.val());
			// 	var id = e.key;
			// 	data.id = id;
			// 	console.log(data)
			// 	that.chatLog.push(data);
			// 	that.update();
			// })

			// messagesRef.child(that.currentRoom.roomKey).on('child_removed', function (e) {
			// 	var id = e.key;

			// 	var target;
			// 	for (let i = 0; i < that.chatLog.length; i++) {
			// 		if (that.chatLog[i].id === id) {
			// 			target = that.chatLog[i];
			// 			break
			// 		}
			// 	}
			// 	var index = that.chatLog.indexOf(target);
			// 	that.chatLog.splice(index, 1);

			// 	that.update();
			// })




		sendMsg(e) {
			if (e.type == "keypress" && e.key !== "Enter") {
				e.preventUpdate = true; // Prevents riot from auto update.
				return false; // Short-circuits function (function exits here, does not continue.)
			}

			var msg = {
				message: this.refs.messageInput.value
			};

			if(this.refs.messageInput.value !== '') {

				var id = messagesRef.child(this.currentRoom.roomKey).child('message').push().key;
				msg.author = this.user.displayName;				//record the author
				var time = moment().format('LTS');		
				msg.time = time;						//record the time
				msg.up = 0;								//record the thumbs-up
				msg.down = 0;							//record the thumbs-down
				msg.id = id;
				msg.userProfile = this.user.photoURL;
				msg.uid = this.user.uid;

				messagesRef.child(this.currentRoom.roomKey).child('message').child(id).set(msg);
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

		addRoom() {
			// this.currentRoom = 
			this.addActive = true;
		}

		changeRoom(e) {
			this.currentRoom = e.item.i;
			this.update();
		}

		searchTriggered(e) {
			var filter = this.refs.search.value.toUpperCase();

			for(let i = 0; i < this.chatGroup.length; i++) {
				if(this.chatGroup[i].roomName.toUpperCase().indexOf(filter) > -1) {
					that.refs.chatGroup[i].style.display = '';
				}else {
					that.refs.chatGroup[i].style.display = 'none';
				}
			}
			that.update();
		}
		

		logOut() {
			firebase.auth().signOut().then(function () {
						// Sign-out successful.
					}).catch(function (error) {
						// An error happened.
					});
		}

		firebase.auth().onAuthStateChanged(function (userObj) {
			that.user = firebase.auth().currentUser;
			that.parent.update();
		})

	</script>













	<style>
		:scope {
			display: block;
			font-family: Helvetica;
			font-size: 1em;
		}

		.chatHeading {
			background: #F3F3F3;
			color: #25395A;
			position: sticky;
			top: 0;
			z-index: 10;
			text-align: center;
			border-bottom: 1px solid #E2E2E2;
			box-sizing: border-box;
			height: 49px;
			line-height: 49px;
		}

		.wrapper {
			width: 85%;
			max-width: 1000px;
			margin: 0 auto;
			position: relative;
			box-shadow: 0px 5px 14px 1px rgba(0, 0, 0, 0.5);
			display: flex;
			height: 600px;
			min-width: 700px;
		}

		.chat-wrap {
			position: relative;
			flex: 1;
		}

		.navbar {
			display: flex;
			/* justify-content: space-around; */
			padding: 10px 12px;
			box-sizing: border-box;
		}

		.navbar .search {
			flex: 1;
			background: #E4E4E4;
			border: none;
			border-radius: 4px;
			margin-right: 5px;
		}

		.navbar .addRoom {
			padding: 5px 4px;
			border-radius: 2px;
			color: #7F7F7F;
		}

		.navbar .addRoom:focus {
			outline: none;
		}

		.bottom {
			background: #FFFFFF;
			display: flex;
			position: relative;
			z-index: 10;
		}

		.chatLog {
			padding: 0 10px;
			margin-bottom: 3px;
			height: 550px;
			overflow: auto;
			position: relative;
			background: #F3F3F3;
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

		.contact {
			width: 30%;
			height: 100%;
			overflow: hidden;
		}

		.chatGroup {
			height: 60px;
			border-bottom: 1px solid #ECECEC;
			cursor: pointer;
			display: flex;
			box-sizing: border-box;
			padding: 10px;
			align-items: center;
		}

		.chatGroup:hover {
			background: #FAFAFA;
		}

		#groupHighlight {
			background: #EFEFEF;
		}

		.chatGroup-wrap {
			overflow: auto;
			height: 90%;
		}

		.groupProfile img{
			border-radius: 5px;
		}

		.roomName {
			text-align: left;
			text-indent: 27px;
			font-weight: 400;
		}

		.headingWrap {
			margin-left: 20px;
		}
		.headingWrap span{
			display: block;
		}

		.groupMessage-preview {
			font-size: 0.8em;
			color: #B7B2B2;
		}

		.user-panel {
			width: 70px;
			height: 100%;
			background: #262626;
		}

		.window-tool {
			display: flex;
			justify-content: space-around;

		}

		.window-tool span {
			display: inline-block;
			width: 12px;
			height: 12px;
			border-radius: 50%;
			margin-top: 16px;
		}
		.window-tool span:nth-child(1) {
			background: #FC625E;
		}
		.window-tool span:nth-child(2) {
			background: #FEBE4A;
		}
		.window-tool span:nth-child(3) {
			background: #3ECB51;
		}

		.user-profile {
			padding: 48px 0;
			width: 44px;
			height: 44px;
			margin: 0 auto;
		}

		.user-profile img {
			width: 100%;
		}
	</style>
</app>
