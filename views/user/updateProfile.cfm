<a href="##" id="updateProfilePopup">Edit Profile</a>

<div id="updateProfile-panel" style="hidden:true;display:none">
	<form action="index.cfm?event=updateAction" method="post" id="form-update">
		<div class="bd" style="padding:10px 10px;background-color:white">
			<div>
				<label class="form-header"><strong>Edit-Profile</strong> </label><br><br>
				<hr width="auto" style="border:1px solid black;"><br>
				<div class="edit-info-1" style="display:inline-block;">
				<label class="form-label">Name<label><br>
					<input type="text" name="name" id="name" placeholder="Name">
				<label class="form-label">Email</label><br>
					<input type="email" name="email" id="email" placeholder="Email Address">
				<label class="form-label">Phone</label><br>
					<input type="text" name="phone" id="phone" placeholder="Phone Number">
				<label class="form-label">City</label><br>
					<input type="text" name="city" id="city" placeholder="City">
				<label class="form-label">Country</label><br>
					<input type="text" name="country" id="country" placeholder="Country">
				<label class="form-label">Username</label><br>
					<input type="text" name="username" id="username" placeholder="Username">
				<label class="form-label">Password</label><br>
					<input type="password" name="password" id="password" placeholder="Password">
				</div>
				<div class="edit-info-2" style="display:inline-block;float:right">
					<label class="form-label">About</label><br>
						<textarea rows="21" cols="40" name="about"></textarea>
				</div>
			</div>
			<div style="padding:30px">
				<button style="display:inline-block;width:45%" type="Submit"><label >Save</label></button>
				<button style="display:inline-block;width:45%"><label >Cancel</label></button>
			</div>	
		</div>
		
	</form>	
</div>

<script>
	var loader = new YAHOO.util.YUILoader({
		require: ["container","element"],
		loadOptional: true,
		timeout: 1000,
		combine: true,
		onSuccess: function(){
			var updateProfilePanel = new YAHOO.widget.Panel("updateProfile-panel",{
				close:true,
				modal:true,
				visible:false,
				fixedcenter:true,
				constraintoviewport:true,
				width:"700px",
				height:"530px",
				underlay:"none",
				effect:[{effect:YAHOO.widget.ContainerEffect.FADE,duration:0.5}],
			});
			//if(document.getElementById("error") !== null){
				document.getElementById("updateProfile-panel").style.hidden = "false"
				document.getElementById("updateProfile-panel").style.display = "block"
				
				updateProfilePanel.render();
			
			YAHOO.util.Event.addListener("updateProfilePopup" , "click" , updateProfilePanel.show, updateProfilePanel, true);
			}
	});
	loader.insert();
</script>		