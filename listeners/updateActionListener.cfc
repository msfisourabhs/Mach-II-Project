<!----	
	Filename 		:	updateActionListener.cfc 
 	Functionality	:	Listnes for update action events and updates user data on successful
 						server side validations and generates errors on unsuccessful attempts.
 	Creation Date	:	August ‎23, ‎2017, ‏‎2:42:59 PM
---->

<cfcomponent
	displayname="updateActionListener"
	extends="MachII.framework.Listener"
	output="true"
	hint="listener for update action."
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
	<cffunction name="updateProfile" output="true" access="public" returntype="void"
		hint="function updates user data before looking for exsisting user data clash">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		<!--- Put logic here. --->
		<cfif StructKeyExists(SESSION,"uid")> 
			<cfif checkForExsistingUser(ARGUMENTS.event.getArg("username"),ARGUMENTS.event.getArg("email")) 
				AND updateUser(ARGUMENTS.event)>
				<cfset ARGUMENTS.event.setArg("response",VARIABLES.errorFlag)>
			<cfelse>
				<cfset ARGUMENTS.event.setArg("response","Database error occurred")>
			</cfif>
		<cfelse>
			<cfset ARGUMENTS.event.setArg("response","User not logged in")>
		</cfif>
		<cfset announceEvent("userProfile",ARGUMENTS.event.getArgs())>
	</cffunction>
	<cffunction name="updateUser" output="true" returntype="boolean" access="private">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
			<cfset VARIABLES.salt = Hash(GenerateSecretKey("AES"), "SHA-512") /> 
			<cfset VARIABLES.hashedPassword = Hash(ARGUMENTS.event.getArg("password") & VARIABLES.salt, "SHA-512") />
			<cftransaction>
					<!---Insert user data into database--->
						<!---Add user details in dbo.User_Details --->
						<cfquery datasource="Mach2DS">
							UPDATE dbo.User_Details
								SET
								Username = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.event.getArg("username")#" maxlength="10" null="false">,
								Password = '#VARIABLES.hashedPassword#',
								Salt = '#VARIABLES.salt#'
							WHERE uid = #SESSION.uid#	
						</cfquery>
						
						<!---Add user profile in dbo.User_Profile--->
						<cfquery datasource="Mach2DS">
							UPDATE dbo.User_Profile
								SET
								Email = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.event.getArg("email")#" maxlength="50" null="false" >,
								Name = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.event.getArg("name")#" maxlength="50" null="false" >,
								Phone = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.event.getArg("phone")#" maxlength="10" null="false" >,
								About = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.event.getArg("about")#" maxlength="1500" null="false" >,
								City = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.event.getArg("city")#" maxlength="50" null="false" >,
								Country = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.event.getArg("country")#" maxlength="50" null="false" >
							WHERE uid = #Session.uid#			
						</cfquery>
				
		</cftransaction>
		<cfreturn true>
	</cffunction>
	<cffunction name="checkForExsistingUser" access="private" returntype="boolean" output="false" 
				hint="checks if username/email address already exsist">
		<cfargument name="username" required="true" type="string" >
		<cfargument name="email" required="true" type="string" >
			<cfquery datasource="Mach2DS" result="fetchUsername" name="getUsername">
				SELECT Username,uid	
				FROM dbo.User_Details
				WHERE Username = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.username#" maxlength="10" null="false">
			</cfquery>
			<cfquery datasource="Mach2DS" result="fetchEmail" name="getEmail">
				SELECT Email,uid	
				FROM dbo.User_Profile
				WHERE Email = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.email#" maxlength="50" null="false" >
			</cfquery>
			<cfif (fetchUsername.recordCount EQ 0 AND fetchEmail.recordCount EQ 0)
				OR (getUsername.uid EQ SESSION.uid OR getEmail.uid EQ SESSION.uid)> 
					<cfreturn true>
			<cfelse>
				<cfset VARIABLES.errorFlag = "User already Exsist">
				<cfreturn false>
			</cfif>	
	</cffunction>
</cfcomponent>