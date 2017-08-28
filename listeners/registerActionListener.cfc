<!----	
	Filename 		:	registerActionListener.cfc 
 	Functionality	:	Listnes for register attempts and on successful server side 
 						validation creates the user account.It adds user data into the DB.
 	Creation Date	:	August ‎21, ‎2017, ‏‎2:42:59 PM
---->
<cfcomponent
	displayname="registerActionListener"
	extends="MachII.framework.Listener"
	output="false"
	hint="Listener for register attempts."
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
	<cffunction name="doRegister" output="false" access="public" returntype="void"
		hint="function checks for exsisting user and adds user data if no exsisting data is found">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		<!--- Check if username or email is taken,and addUser was success --->
		<cfif checkForExsistingUser(ARGUMENTS.event.getArg("username"),ARGUMENTS.event.getArg("email"))
			 AND addUser(ARGUMENTS.event)>
			<cfset ARGUMENTS.event.setArg("response",VARIABLES.errorFlag)>
			<cfset announceEvent("publicPage",ARGUMENTS.event.getArgs())>
			
		<cfelse>
			<cfset ARGUMENTS.event.setArg("response","User already exsist")>
			<cfset announceEvent("failed",ARGUMENTS.event.getArgs())>
		</cfif>
	</cffunction>
	<cffunction name="addUser" output="false" returntype="boolean" access="private">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
			<cfset VARIABLES.salt = Hash(GenerateSecretKey("AES"), "SHA-512") /> 
			<cfset VARIABLES.hashedPassword = Hash(ARGUMENTS.event.getArg("password") & VARIABLES.salt, "SHA-512") />
				<cftransaction>
					<!---Insert user data into database--->
						<!---Add user details in dbo.User_Details --->
						<cfquery datasource="Mach2DS">
							INSERT INTO dbo.User_Details
								(Username,Password,Salt,isActive)
							VALUES
								(<cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.event.getArg("username")#" maxlength="10" null="false">,
								'#VARIABLES.hashedPassword#',
								'#VARIABLES.salt#',
								0)
						</cfquery>
						<!---fetch the uid for current user--->
						<cfquery name = "fetchUserID" datasource="Mach2DS">
							SELECT uid 
							FROM  dbo.User_Details 
							WHERE Username = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.event.getArg("username")#" maxlength="10" null="false">
						</cfquery>
						<!---Add user profile in dbo.User_Profile--->
						<cfquery datasource="Mach2DS">
							INSERT INTO dbo.User_Profile
								(uid,Email,Name,Phone,About,City,Country)
							VALUES
								(#fetchUserID.uid#,
								<cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.event.getArg("email")#" maxlength="50" null="false" >,
								<cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.event.getArg("name")#" maxlength="50" null="false" >,
								<cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.event.getArg("phone")#" maxlength="10" null="false" >,
								'Your sample about goes here',
								<cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.event.getArg("city")#" maxlength="50" null="false" >,
								<cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.event.getArg("country")#" maxlength="50" null="false" >
								)
						</cfquery>
						<cfquery datasource="Mach2DS">
							INSERT INTO dbo.User_Pictures
								(uid,PictureName,PictureLocation,isPublic,TypeID)
							VALUES
								(#fetchUserID.uid#,'Unknown-User','uploads/unknown-user.jpg',1,1)
						</cfquery>
					</cftransaction>
					<cfset VARIABLES.errorFlag = "Database Error Occurred">
					<cfreturn false>
		<cfreturn true>
	</cffunction>
	<cffunction name="checkForExsistingUser" access="private" returntype="boolean" output="false" 
				hint="function checks if a username or email address already exsists">
		<cfargument name="username" required="true" type="string" >
		<cfargument name="email" required="true" type="string" >
			<!---Look for exsisting users--->
			<cfquery datasource="Mach2DS" result="fetchUsername">
				SELECT Username	
				FROM dbo.User_Details
				WHERE Username = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.username#" maxlength="10" null="false">
				
			</cfquery>
			<cfquery datasource="Mach2DS" result="fetchEmail">
				SELECT Email	
				FROM dbo.User_Profile
				WHERE Email = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.email#" maxlength="50" null="false" >
						
			</cfquery>
			<cfif fetchUsername.recordCount EQ 0 AND fetchEmail.recordCount EQ 0>
				<cfreturn true>
			<cfelse>
				<cfset VARIABLES.errorFlag = "User already Exsist">
				<cfreturn false>
			</cfif>	
	</cffunction>
</cfcomponent>