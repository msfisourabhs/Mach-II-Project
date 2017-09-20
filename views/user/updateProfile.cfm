<!----	
	Filename 		:	updateProfile.cfm 
 	Functionality	:	Shows form to update user data.
 	Creation Date	:	August ‎11, ‎2017, ‏‎2:42:59 PM
---->
<a href="##" id="updateProfilePopup">Edit Profile</a>

<div id="updateProfile-panel" style="hidden:true;display:none">
	<form action="index.cfm?event=updateAction" method="post" id="form-update">
		<div class="bd" style="padding:10px 10px;background:url('/img/background8.jpg');background-size:cover;background-repeat:no-repeat;">
			<div>
				<label class="form-header"><strong>Edit-Profile</strong> </label><br><br>
				<hr width="auto" style="border:1px solid black;"><br>
				<div class="edit-info-1" style="display:inline-block;float:left;width:50%">
			<cfoutput>
			<div class="input-group">
		      <span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
		      <input id="name" type="text" class="form-control required" name="name" placeholder="Name" value="#event.getArg("User").getName()#">
		    </div>
		    
			<div class="input-group">
		      <span class="input-group-addon"><i class="glyphicon glyphicon-envelope"></i></span>
		      <input id="email" type="text" class="form-control required" name="email" placeholder="Email" value="#event.getArg("User").getEmail()#">
		    </div>
			<div class="input-group">
		      <span class="input-group-addon"><i class="glyphicon glyphicon-phone"></i></span>
		      <input id="phone" type="text" class="form-control required" name="phone" placeholder="Phone Number" value="#event.getArg("User").getPhone()#">
		    </div>
		    <div class="input-group">
		      <span class="input-group-addon"><i class="glyphicon glyphicon-map-marker"></i></span>
		      <input id="city" type="text" class="form-control required" name="city" placeholder="City" value="#event.getArg("User").getCity()#">
		    </div>
		    <div class="input-group">
		      <span class="input-group-addon"><i class="glyphicon glyphicon-map-marker"></i></span>
		      <input id="country" type="text" class="form-control required" name="country" placeholder="Country" value="#event.getArg("User").getCountry()#">
		    </div>
		    <div class="input-group">
		      <span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
		      <input id="username" type="text" class="form-control required" name="username" placeholder="Username" value="#event.getArg("User").getUsername()#">
		    </div>
		    <div class="input-group">
		      <span class="input-group-addon"><i class="glyphicon glyphicon-lock"></i></span>
		      <input id="password" type="password" class="form-control required" name="password" placeholder="Password">
		    </div>
			</div>
		    <br>
			<div class="edit-info-2" style="display:inline-block;float:right">
				<div class="form-group">
	  				<label for="comment">About:</label>
	  					<textarea class="form-control" rows="10" cols="40" id="about" name="about" >#event.getArg("User").getAbout()#</textarea>
				</div>
			</div
			</cfoutput>	
			<div >
				<button style="display:inline-block;" type="Submit" class="btn btn-primary btn-block"><label >Save</label></button>
			</div>	
		</div>
		
	</form>	
</div>
<script src="/includes/js/userRegister.js"></script>
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
				height:"630px",
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