<h4><a href="#" id="loginPopup">Sign In</a></h4>
		
<div id="login-panel">
	
	<div class="bd" style="padding:10px 10px;background-color:white">
		<form method="post" action="index.cfm?event=loginAction">
			<label class="form-header"><strong>Sign In</strong> </label><br><br>
			<hr width="auto" style="border:1px solid black;"><br>
			<label class="form-label">Username or Email<label>
				<input type="text" name="userlogin" id="username" placeholder="User Name">
			<label class="form-label">Password</label>
				<input type="password" name="password" id="password" placeholder="Password">
			<button type="submit" value="Submit"><label class="submitbttn">Login</label></button>
			<br><br>
			<label class="footer"><a href="#" id="registerPopup">New User? Register Here</a>
			</label>
		</form>
	</div>
	
</div>
<script>
		
	var loader = new YAHOO.util.YUILoader({
		require: ["container","element"],
		loadOptional: true,
		timeout: 1000,
		combine: true,
		onSuccess: function(){
			var loginPanel = new YAHOO.widget.Panel("login-panel",{
				close:true,
				modal:true,
				visible:false,
				fixedcenter:true,
				constraintoviewport:true,
				width:"400px",
				height:"350px",
				underlay:"none",
				effect:[{effect:YAHOO.widget.ContainerEffect.FADE,duration:0.5}],
			});
			//if(document.getElementById("error") !== null){
				document.getElementById("login-panel").style.hidden = "false"
				document.getElementById("login-panel").style.display = "block"
				
				loginPanel.render();
			
			YAHOO.util.Event.addListener("loginPopup" , "click" , loginPanel.show, loginPanel, true);
			var registerPanel = new YAHOO.widget.Panel("register-panel",{
				close:true,
				modal:true,
				visible:false,
				fixedcenter:true,
				constraintoviewport:true,
				width:"500px",
				height:"630px",
				underlay:"none",
				effect:[{effect:YAHOO.widget.ContainerEffect.FADE,duration:0.5}],
			});
			document.getElementById("register-panel").style.hidden = "false"
			document.getElementById("register-panel").style.display = "block"
				
			registerPanel.render();
			YAHOO.util.Event.addListener("registerPopup" , "click" , loginPanel.hide, loginPanel, true);
			YAHOO.util.Event.addListener("registerPopup" , "click" , registerPanel.show, registerPanel, true);
			 
		}
	});
	loader.insert();
	
</script>
<cfoutput>
	#event.getArg("registerForm")#
</cfoutput>
