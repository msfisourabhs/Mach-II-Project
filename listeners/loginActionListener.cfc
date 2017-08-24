<cfcomponent
	displayname="SampleListener"
	extends="MachII.framework.Listener"
	output="false"
	hint="login attempt listener "
	>

	<!---
	PROPERTIES
	--->

	<!---
	CONFIGURATION / INITIALIZATION
	--->
	<cfset VARIABLES.errorFlag = "">
	<cffunction name="configure" access="public" returntype="void" output="false"
		hint="Configures the listener.">
		<!--- Put custom configuration for this listener here. --->
	</cffunction>
	
	<!---
	PUBLIC FUNCTIONS
	--->
	<cffunction name="doLogin" output="true" access="public" returntype="void"
		hint="I am a boilerplate function">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		<!--- Put logic here. --->
		<cfif isValid("email" , event.getArg("userlogin"))>
			<cfset var userlogin = "Email">
		<cfelse>
			<cfset var userlogin = "Username">
		</cfif>
		<cfset var password = event.getArg("password")>
		<cfif NOT StructKeyExists(session,"uid")>
		<!---User submits his username and password for validation--->
			<!---Fetch the salt for emailID--->
			<cfquery name = "nmFetchSalt" result = "resFetchSalt" datasource="Mach2DS">
				SELECT Salt
					FROM dbo.User_Details INNER JOIN dbo.User_Profile
				ON dbo.User_Details.uid = dbo.User_Profile.uid
					WHERE #userlogin# = <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#event.getArg("userlogin")#" null = "false" maxlength = "60" > 
				
			</cfquery>
			<cfif resFetchSalt.recordCount NEQ 0>	
				<cfset LOCAL.hashedPassword = Hash(event.getArg("password") & nmFetchSalt.Salt, "SHA-512")>
				<cfquery name = "nmLoginActivity" result = "rsLoginActivity" datasource="Mach2DS">
					SELECT dbo.User_Details.uid,isActive,Name
					FROM dbo.User_Details INNER JOIN dbo.User_Profile
						ON dbo.User_Details.uid = dbo.User_Profile.uid
					WHERE #userlogin# = <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#event.getArg("userlogin")#" null = "false" maxlength = "60"> 
						AND 
					Password = '#LOCAL.hashedPassword#'
				</cfquery>	
				<cfif rsLoginActivity.recordCount EQ 1>
					<cfif #nmLoginActivity.isActive# EQ 0 >
						<cfquery datasource="Mach2DS">
							UPDATE dbo.User_Details 
							SET isActive = 1 
							WHERE uid = #nmLoginActivity.uid#
						</cfquery>
						<cflock timeout="30" type="exclusive" >
							<cfset SessionRotate()>
							<cfset SESSION.uid = #nmLoginActivity.uid#>
						</cflock>
					<cfelse>
						<cfset VARIABLES.errorFlag = "Suspicious login detected">			
					</cfif>
				<cfelse>
					<cfset VARIABLES.errorFlag = "Invalid Username/Password">		
				</cfif>
			<cfelse>	
				<cfset VARIABLES.errorFlag = "Invalid Username/Password">		
			</cfif>
		<cfif VARIABLES.errorFlag NEQ "">
			<cfset arguments.event.setArg("response",VARIABLES.errorFlag)>
			<cfset announceEvent("failed",arguments.event.getArgs())>
		<cfelse>
			<cfset arguments.event.setArg("Name" , nmLoginActivity.Name)>
			<cfset arguments.event.setArg("response","Login was sucessful")>
			<cfset announceEvent("userPublicPage",arguments.event.getArgs())>
		</cfif>
	<cfelse>
		<cfset arguments.event.setArg("Name" , nmLoginActivity.Name)>
		<cfset arguments.event.setArg("response","You have already logged in")>
		<cfset announceEvent("userPublicPage",arguments.event.getArgs())>
	</cfif>
	</cffunction>

</cfcomponent>