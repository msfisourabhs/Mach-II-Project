<div id="register-panel">
	<form action="index.cfm?event=registerAction" method="post" >
		<div class="bd" style="padding:10px 10px;background-color:white">
			<label class="form-header"><strong>Sign Up</strong> </label><br><br>
			<hr width="auto" style="border:1px solid black;"><br>
			<label class="form-label">Name<label>
				<input type="text" name="name" id="name" placeholder="Name">
			<label class="form-label">Email</label>
				<input type="email" name="email" id="email" placeholder="Email Address">
			<label class="form-label">Phone</label>
				<input type="text" name="phone" id="phone" placeholder="Phone Number">
			<label class="form-label">City</label>
				<input type="text" name="city" id="city" placeholder="City">
			<label class="form-label">Country</label>
				<input type="text" name="country" id="country" placeholder="Country">
			<label class="form-label">Username</label>
				<input type="text" name="username" id="username" placeholder="Username">
			<label class="form-label">Password</label>
				<input type="password" name="password" id="password" placeholder="Password">
			
			<button type="submit" value="Submit"><label class="submitbttn">Register</label></button>
		</div>	
	</form>	
</div>