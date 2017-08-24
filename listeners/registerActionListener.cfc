<cfcomponent
	displayname="SampleListener"
	extends="MachII.framework.Listener"
	output="false"
	hint="A simple listener example."
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
	<cffunction name="doRegister" output="true" access="public" returntype="void"
		hint="I am a boilerplate function">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		<!--- Put logic here. --->
		<cfif checkForExsistingUser(arguments.event.getArg("username"),arguments.event.getArg("email"))
			 AND addUser(arguments.event)>
			<cfset arguments.event.setArg("response",VARIABLES.errorFlag)>
			<cfset announceEvent("publicPage",arguments.event.getArgs())>
			
		<cfelse>
			<cfset arguments.event.setArg("response","User already exsist")>
			<cfset announceEvent("failed",arguments.event.getArgs())>
		</cfif>
	</cffunction>
	<cffunction name="addUser" output="true" returntype="boolean" access="private">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
			<cfset VARIABLES.salt = Hash(GenerateSecretKey("AES"), "SHA-512") /> 
			<cfset VARIABLES.hashedPassword = Hash(event.getArg("password") & VARIABLES.salt, "SHA-512") />
				<cftransaction>
					<!---Insert user data into database--->
						<!---Add user details in dbo.User_Details --->
						<cfquery datasource="Mach2DS">
							INSERT INTO dbo.User_Details
								(Username,Password,Salt,isActive)
							VALUES
								(<cfqueryparam cfsqltype="cf_sql_varchar" value="#event.getArg("username")#" maxlength="10" null="false">,
								'#VARIABLES.hashedPassword#',
								'#VARIABLES.salt#',
								0)
						</cfquery>
						<!---fetch the uid for current user--->
						<cfquery name = "fetchUserID" datasource="Mach2DS">
							SELECT uid 
							FROM  dbo.User_Details 
							WHERE Username = <cfqueryparam cfsqltype="cf_sql_varchar" value="#event.getArg("username")#" maxlength="10" null="false">
						</cfquery>
						<!---Add user profile in dbo.User_Profile--->
						<cfquery datasource="Mach2DS">
							INSERT INTO dbo.User_Profile
								(uid,Email,Name,Phone,About,City,Country)
							VALUES
								(#fetchUserID.uid#,
								<cfqueryparam cfsqltype="cf_sql_varchar" value="#event.getArg("email")#" maxlength="50" null="false" >,
								<cfqueryparam cfsqltype="cf_sql_varchar" value="#event.getArg("name")#" maxlength="50" null="false" >,
								<cfqueryparam cfsqltype="cf_sql_varchar" value="#event.getArg("phone")#" maxlength="10" null="false" >,
								'Your sample about goes here',
								<cfqueryparam cfsqltype="cf_sql_varchar" value="#event.getArg("city")#" maxlength="50" null="false" >,
								<cfqueryparam cfsqltype="cf_sql_varchar" value="#event.getArg("country")#" maxlength="50" null="false" >
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
	<cffunction name="checkForExsistingUser" access="private" returntype="boolean" output="false" >
		<cfargument name="username" required="true" type="string" >
		<cfargument name="email" required="true" type="string" >
			<cfquery datasource="Mach2DS" result="fetchUsername">
				SELECT Username	
				FROM dbo.User_Details
				WHERE Username = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.username#" maxlength="10" null="false">
				
			</cfquery>
			<cfquery datasource="Mach2DS" result="fetchEmail">
				SELECT Email	
				FROM dbo.User_Profile
				WHERE Email = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.email#" maxlength="50" null="false" >
						
			</cfquery>
			<cfif fetchUsername.recordCount EQ 0 AND fetchEmail.recordCount EQ 0>
				<cfreturn true>
			<cfelse>
				<cfset VARIABLES.errorFlag = "User already Exsist">
				<cfreturn false>
			</cfif>	
	</cffunction>
</cfcomponent>