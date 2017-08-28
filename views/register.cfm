<!----	
	Filename 		:	register.cfm 
 	Functionality	:	Displays register form.
 	Creation Date	:	August ‎11, ‎2017, ‏‎2:42:59 PM
---->
<div id="register-panel">
	<form action="index.cfm?event=registerAction" method="post" >
		<div class="bd" style="padding:10px 10px;background:url('/img/background8.jpg');background-size:cover;background-repeat:no-repeat;">
			<label class="form-header"><strong>Sign Up</strong> </label><br><br>
			<hr width="auto" style="border:1px solid black;"><br>
			<div class="input-group">
		      <span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
		      <input id="name" type="text" class="form-control required" name="name" placeholder="Name">
		    </div>
		    
			<div class="input-group">
		      <span class="input-group-addon"><i class="glyphicon glyphicon-envelope"></i></span>
		      <input id="email" type="text" class="form-control required" name="email" placeholder="Email">
		    </div>
			<div class="input-group">
		      <span class="input-group-addon"><i class="glyphicon glyphicon-phone"></i></span>
		      <input id="phone" type="text" class="form-control required" name="phone" placeholder="Phone Number">
		    </div>
		    <div class="input-group">
		      <span class="input-group-addon"><i class="glyphicon glyphicon-map-marker"></i></span>
		      <input id="city" type="text" class="form-control required" name="city" placeholder="City">
		    </div>
		    <div class="input-group">
		      <span class="input-group-addon"><i class="glyphicon glyphicon-map-marker"></i></span>
		      <input id="country" type="text" class="form-control required" name="country" placeholder="Country">
		    </div>
		    <div class="input-group">
		      <span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
		      <input id="username" type="text" class="form-control required" name="username" placeholder="Username">
		    </div>
		    <div class="input-group">
		      <span class="input-group-addon"><i class="glyphicon glyphicon-lock"></i></span>
		      <input id="password" type="password" class="form-control required" name="password" placeholder="Password">
		    </div>
		    <br>
			<button type="submit" value="Submit" class="btn btn-primary btn-block">
				<span class="glyphicon glyphicon-check"></span>
				<label class="submitbttn">Register</label>
			</button>
		</div>	
	</form>	
</div>
<script src="/includes/js/userRegister.js">

</script>
