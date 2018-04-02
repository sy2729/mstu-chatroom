
<addRoom>
  <div class="card">
    <h3>Add a new chatroom</h3>
    <input type="add Room Name here" onkeypress={getInput} ref = 'inputValue'>
    <div class="btnGroup">
      <button class="btn-add" onclick={getInput} disabled = {!hasContent}>Add</button>
      <button class="btn-cancel" onclick={cancel}>Cancel</button>
    </div>
  </div>

  <script>
    that = this;
    this.hasContent = false;

    getInput(e) {

      if (e.type == "keypress" && e.key !== "Enter") {
            that.hasContent = true;
            // e.preventUpdate = true; // Prevents riot from auto update.
            return false; // Short-circuits function (function exits here, does not continue.)
          }

      var inputValue = this.refs.inputValue.value;
      
      var roomKey = messagesRef.child(inputValue).push().key;
      messagesRef.child(roomKey).set({roomName: inputValue, roomKey: roomKey})

      // this.parent.currentRoom = messagesRef.child(roomKey);
      this.parent.addActive = false;
      this.parent.update();
    }


    cancel() {
      this.parent.addActive = false;
      this.parent.update();
    }
  </script>

  <style>
    :scope p {
      color: #000;
    }

    .card {
      position: fixed;
      width: 280px;
      height: 200px;
      left: 0;
      right: 0;
      top: 0;
      bottom: 0;
      margin: auto;
      transform: translateY(-20px);
      opacity: 0;
      animation: slideIn 0.5s ease-in-out forwards;
      z-index: 100;
      border: 1px solid #B5B5B5;
      box-shadow: 1px 1px 10px 0 rgba(0, 0, 0, 0.3);
      background: #FFFFFF;
      box-sizing: border-box;
      padding: 10px 6px;
      text-align: center;
      display: flex;
      flex-direction: column;
      align-items: center;
      justify-content: space-around;
      
    }

    @keyframes slideIn {
      0% {
        transform: translateY(-20px);
        opacity: 0;        
      }
      100% {
        transform: translateY(0);
        opacity: 1;        
      }
    }

    .card input{
      border: 1px solid #CCCCCC;
			border-radius: 4px;
      margin: 10px 0;
      height: 25px;
    }

    .card .btnGroup button{
      border-radius: 4px;
      border: 1px solid #CCCCCC;
      padding: 3px 12px;
    }

  </style>
</addRoom>
