<!----	
	Filename 		:	loginActionListener.cfc 
 	Functionality	:	Listnes for login action events and authenticates user 
 						and generates errors on unsuccessful attempts.
 	Creation Date	:	August ‎11, ‎2017, ‏‎2:42:59 PM
---->

<cfcomponent
	displayname="loginActionListener"
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
	<cffunction name="doLogin" output="false" access="public" returntype="void"
		hint="function to authenticate user">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		<!--- Put logic here. --->
		<cfif isValid("email" , ARGUMENTS.event.getArg("userlogin"))>
			<cfset var userlogin = "Email">
		<cfelse>
			<cfset var userlogin = "Username">
		</cfif>
		<cfset var password = ARGUMENTS.event.getArg("password")>
		<cfif NOT StructKeyExists(SESSION,"uid")>
		<!---User submits his username and password for validation--->
			<!---Fetch the salt for emailID--->
			<cfquery name = "nmFetchSalt" result = "resFetchSalt" datasource="Mach2DS">
				SELECT Salt
					FROM dbo.User_Details INNER JOIN dbo.User_Profile
				ON dbo.User_Details.uid = dbo.User_Profile.uid
					WHERE #userlogin# = <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#event.getArg("userlogin")#" null = "false" maxlength = "60" > 
				
			</cfquery>
			<!---check for user exsist---->
			<cfif resFetchSalt.recordCount NEQ 0>	
				<cfset LOCAL.hashedPassword = Hash(ARGUMENTS.event.getArg("password") & nmFetchSalt.Salt, "SHA-512")>
				<cfquery name = "nmLoginActivity" result = "rsLoginActivity" datasource="Mach2DS">
					SELECT dbo.User_Details.uid,isActive,Name
					FROM dbo.User_Details INNER JOIN dbo.User_Profile
						ON dbo.User_Details.uid = dbo.User_Profile.uid
					WHERE #userlogin# = <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#ARGUMENTS.event.getArg("userlogin")#" null = "false" maxlength = "60"> 
						AND 
					Password = '#LOCAL.hashedPassword#'
				</cfquery>
				<!---Validate user--->	
				<cfif rsLoginActivity.recordCount EQ 1>
					<!---check if user is already logged in--->
					<cfif #nmLoginActivity.isActive# EQ 0 >
						<cfquery datasource="Mach2DS">
							UPDATE dbo.User_Details 
							SET isActive = 1 
							WHERE uid = #nmLoginActivity.uid#
						</cfquery>
						<cflock timeout="30" type="exclusive" >
							<cfset SessionRotate()>
							<cfset SESSION.uid = #nmLoginActivity.uid#>
							<cfset SESSION.Name = #nmLoginActivity.Name#>
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
			<!---Set error flag and deny login--->
			<cfset ARGUMENTS.event.setArg("errors",VARIABLES.errorFlag)>
			<cfset announceEvent("publicPage",ARGUMENTS.event.getArgs())>
		<cfelse>
			<!---remove error flag and allow login--->
			<cfset ARGUMENTS.event.setArg("response","Login was sucessful")>
			<cfset announceEvent("publicPage",ARGUMENTS.event.getArgs())>
		</cfif>
	<cfelse>
		<!---If same user submits login requests--->
		<cfset ARGUMENTS.event.setArg("response","You have already logged in")>
		<cfset announceEvent("publicPage",ARGUMENTS.event.getArgs())>
	</cfif>
	</cffunction>

</cfcomponent>