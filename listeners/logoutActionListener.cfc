<!----	
	Filename 		:	logoutActionListener.cfc 
 	Functionality	:	Listens for logout events and de-authenticates user by clearing
 						session structure  and SessionInvalidate.
 	Creation Date	:	August ‎22, ‎2017, ‏‎2:42:59 PM
---->

<cfcomponent
	displayname="logoutActionListener"
	extends="MachII.framework.Listener"
	output="false"
	hint="logout attempt listener "
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
	<cffunction name="doLogout" output="false" access="public" returntype="void"
		hint="function deauthenticates user">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
			<!---set isActive flag to inactive--->
			<cfif StructKeyExists(session,"uid")>
				<cfquery datasource="Mach2DS">
					UPDATE dbo.User_Details
					SET isActive = 0
					WHERE uid = #SESSION.uid#
				</cfquery>
				<!---Logout the user--->
				<cfset StructClear(SESSION)>
				<cfset Sessioninvalidate()>
			<cfelse>
				<!---Set error flag --->
				<cfset ARGUMENTS.event.setArg("response","Your session has timed out")>
			</cfif>
	</cffunction>
</cfcomponent>