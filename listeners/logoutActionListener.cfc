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
	<cffunction name="doLogout" output="true" access="public" returntype="void"
		hint="I am a boilerplate function">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
			<cfif StructKeyExists(session,"uid")>
				<cfquery datasource="Mach2DS">
					UPDATE dbo.User_Details
					SET isActive = 0
					WHERE uid = #Session.uid#
				</cfquery>
				<cfset StructClear(session)>
				<cfset Sessioninvalidate()>
			<cfelse>
				<cfset arguments.event.setArg("response","Your session has timed out")>
			</cfif>
	</cffunction>
</cfcomponent>