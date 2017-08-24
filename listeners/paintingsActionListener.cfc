<cfcomponent
	displayname="SampleListener"
	extends="MachII.framework.Listener"
	output="false"
	hint="update picture attempt listener "
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
	<cffunction name="makePublic" output="false" access="public" returntype="boolean" returnformat="JSON" 
		hint="I am a boilerplate function">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		<cfif StructKeyExists(session,"uid")>
			<cfquery datasource="Mach2DS">
				UPDATE dbo.User_Pictures
					SET isPublic = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.event.getArg("action")#">
				WHERE 
					pid = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.event.getArg("picId")#" null="false" maxlength="10">
						AND
					uid = #Session.uid#
			</cfquery>
		</cfif>
		<cfreturn false>
			
	</cffunction>
</cfcomponent>