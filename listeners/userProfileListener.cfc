<cfcomponent
	displayname="SampleListener"
	extends="MachII.framework.Listener"
	output="false"
	hint="update attempt listener "
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
	<cffunction name="fetchUserDetails" output="true" access="public" returntype="void"
		hint="I am a boilerplate function">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		<cfif StructKeyExists(session,"uid")>
			<cfif event.isArgDefined("uid") AND getParameter("callee") EQ "public">
				<cfset local.uid = event.getArg("uid")>
			<cfelse>
				<cfset local.uid = Session.uid>
			</cfif>
		<cfelse>
			<cfif event.isArgDefined("uid")>
				<cfset local.uid = arguments.event.getArg("uid")>
			<cfelse>
				<cfset VARIABLES.errorFlag = "You are not authorised to view this page">
			</cfif>	
		</cfif>
		<cftry>
			<cfquery name = "fetchUserData" datasource="Mach2DS">
				SELECT Name,Email,Phone,About,City,Country
					FROM dbo.User_Profile
				WHERE uid = #local.uid#
			</cfquery>
			<cfquery datasource="Mach2DS" name="fetchUserPicture">
				SELECT pid,PictureName,PictureLocation
					FROM dbo.User_Pictures
				WHERE 
					uid = #local.uid#
				AND
					TypeID = 1	
			</cfquery>
			<cfif getParameter("callee") EQ "public">
				<cfquery datasource="Mach2DS" name="fetchUserPaintings">
					SELECT pid,PictureName,PictureLocation,isPublic
						FROM dbo.User_Pictures
					WHERE 
						uid = #local.uid#
					AND
						TypeID = 2
					AND
						isPublic = 1	
				</cfquery>
			<cfelse>
				<cfquery datasource="Mach2DS" name="fetchUserPaintings">
					SELECT pid,PictureName,PictureLocation,isPublic
						FROM dbo.User_Pictures
					WHERE 
						uid = #local.uid#
					AND
						TypeID = 2
				</cfquery>
			</cfif>
			<cfset arguments.event.setArg("display",getParameter("callee"))>
			<cfset arguments.event.setArg("user" , fetchUserData)>
			<cfset arguments.event.setArg("userPictures" , fetchUserPicture)>
			<cfset arguments.event.setArg("userPaintings" ,fetchUserPaintings)>
		
		<cfcatch type="any">
			<cfset arguments.event.setArg("response",VARIABLES.errorFlag)>
			<cfset announceEvent("error",arguments.event.getArgs())>
		</cfcatch>
		</cftry>
		
	</cffunction>

</cfcomponent>