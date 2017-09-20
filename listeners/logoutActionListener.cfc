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
		<cfset VARIABLES.painter = createObject("component","models.painter.painter").init()>	
		<cfset VARIABLES.painterDAO = createObject("component","models.painter.painterDAO").init(VARIABLES.painter)>
		<cfset VARIABLES.painterService = createObject("component","models.painter.painterService").init(VARIABLES.painterDAO)>
	</cffunction>
	
	<!---
	PUBLIC FUNCTIONS
	--->
	<cffunction name="doLogout" output="false" access="public" returntype="void"
		hint="function deauthenticates user">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
			<!---set isActive flag to inactive--->
			<cfif StructKeyExists(SESSION,"User")>
				<cfset VARIABLES.painterDAO.init(SESSION.User)>
				<cfset LOCAL.validation = createObject("component","models.painter.authenticationService").init(SESSION.User,VARIABLES.painterService)>
				<cfset VARIABLES.errorFlag = LOCAL.validation.doLogout()>
				<cfif NOT VARIABLES.errorFlag >	
					<!---Set error flag --->
					<cfset ARGUMENTS.event.setArg("response","Your session has timed out")>
				</cfif>
			</cfif>
	</cffunction>
</cfcomponent>