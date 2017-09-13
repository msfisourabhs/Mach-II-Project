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
		<cfif StructKeyExists(SESSION,"User")>
			<cfset VARIABLES.paintingDAO = createObject("component","models.picture.pictureDAO").init(SESSION.User)>
			<cfset VARIABLES.pictureService = createObject("component","models.picture.pictureService").init(VARIABLES.paintingDAO)>	
		</cfif>
	</cffunction>
	
	<!---
	PUBLIC FUNCTIONS
	--->
	<cffunction name="makePublic" output="false" access="remote" returntype="boolean" returnformat="JSON" 
		hint="function makes user paintings public">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		<!---Check if incoming request is from a logged in user--->
		<cfset LOCAL.painting = createObject("component","models.picture.picture").init()>	
		<cfif StructKeyExists(SESSION,"User")>
			<!---update the isPublic flag to public--->
			<cfset LOCAL.painting.setIsPublic(ARGUMENTS.event.getArg("action"))>
			<cfset LOCAL.painting.setPid(ARGUMENTS.event.getArg("picId"))>
			<cfset VARIABLES.pictureService.paintingsAccess(LOCAL.painting)>
			<cfreturn true>
		</cfif>
		<cfreturn false>
			
	</cffunction>
</cfcomponent>