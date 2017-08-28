<!----	
	Filename 		:	login.cfm 
 	Functionality	:	Login form with modal
 	Creation Date	:	August ‎11, ‎2017, ‏‎2:42:59 PM
---->
<h4><span class="glyphicon glyphicon-log-in"></span><a href="#" id="loginPopup">Sign In</a></h4>
		
<div id="login-panel">
	
	<div class="bd" style="padding:10px 10px;background:url('/img/background3.jpg');background-size:cover;background-repeat:no-repeat;">
		<form method="post" action="index.cfm?event=loginAction">
			<label class="form-header">
				<strong>Sign In</strong> 
			</label><br><br>
			<hr width="auto" style="border:1px solid black;"><br>
			<!---
			<label class="form-label">
				<span class="glyphicon glyphicon-user"></span>Username or Email
			</label>
				<input type="text" name="userlogin" id="username" placeholder="User Name">
			
			
			<label class="form-label">
				<span class="glyphicon glyphicon-lock"></span>Password
			</label>
				<input type="password" name="password" id="password" placeholder="Password">
			--->
			<div class="input-group">
      			<span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
     				 <input id="form-userlogin" type="text" class="form-control required" name="userlogin" placeholder="Email Address or Username">
   		    </div>
		
   			 <div class="input-group">
      			<span class="input-group-addon"><i class="glyphicon glyphicon-lock"></i></span>
      				<input id="form-password" type="password" class="form-control required" name="password" placeholder="Password">
    		</div>
			<br>
			<button type="submit" value="Submit" class="btn btn-primary btn-block">
				<span class="glyphicon glyphicon-log-in"></span>
				<label class="submitbttn">Sign In</label>
			</button>
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
				height:"auto",
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
				height:"100%",
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
<script type="text/javascript" src="/includes/js/login.js"></script>
<cfoutput>
	#event.getArg("registerForm")#
</cfoutput>
