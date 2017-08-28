<!----	
	Filename 		:	paintingsActionListener.cfc 
 	Functionality	:	Listens for events where paintings are to be made public or private
 						and makes the paintings public or ptivate.
 	Creation Date	:	August ‎23, ‎2017, ‏‎2:42:59 PM
---->
<cfcomponent
	displayname="paintingsActionListener"
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
		hint="function makes user paintings public">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		<!---Check if incoming request is from a logged in user--->
		<cfif StructKeyExists(SESSION,"uid")>
			<!---update the isPublic flag to public--->
			<cfquery datasource="Mach2DS">
				UPDATE dbo.User_Pictures
					SET isPublic = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.event.getArg("action")#">
				WHERE 
					pid = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.event.getArg("picId")#" null="false" maxlength="10">
						AND
					uid = #SESSION.uid#
			</cfquery>
		</cfif>
		<cfreturn false>
			
	</cffunction>
</cfcomponent>