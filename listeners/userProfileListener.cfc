<!----	
	Filename 		:	loginActionListener.cfc 
 	Functionality	:	Listnes for user profile display to public/private users.
 						and fetches user data.
 	Creation Date	:	August ‎22, ‎2017, ‏‎2:42:59 PM
---->
<cfcomponent
	displayname="userProfileListener"
	extends="MachII.framework.Listener"
	output="false"
	hint="user profile public/private listener "
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
		<cfset VARIABLES.painterDAO = createObject("component","models.painter.painterDAO").init(SESSION.User)>
		<cfset VARIABLES.painterService = createObject("component","models.painter.painterService").init(VARIABLES.painterDAO)>
	</cfif>
	</cffunction>
	
	<!---
	PUBLIC FUNCTIONS
	--->
	<cffunction name="fetchUserDetails" output="false" access="public" returntype="void"
		hint="function fetches registered user data to public/private events">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		<cfif StructKeyExists(SESSION,"User")>
			<cfif event.isArgDefined("uid") AND getParameter("callee") EQ "public">
				<cfset LOCAL.uid = event.getArg("uid")>
			<cfelse>
				<cfset LOCAL.uid = SESSION.User.getUid()>
			</cfif>
		<cfelse>
			<cfif ARGUMENTS.event.isArgDefined("uid")>
				<cfset LOCAL.uid = ARGUMENTS.event.getArg("uid")>
			<cfelse>
				<cfset VARIABLES.errorFlag = "You are not authorised to view this page">
			</cfif>	
		</cfif>
		<cfset ARGUMENTS.event.setArg("display",getParameter("callee"))>
			
		<!---
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
			<cfset ARGUMENTS.event.setArg("display",getParameter("callee"))>
			<cfset ARGUMENTS.event.setArg("user" , fetchUserData)>
			<cfset ARGUMENTS.event.setArg("userPictures" , fetchUserPicture)>
			<cfset ARGUMENTS.event.setArg("userPaintings" ,fetchUserPaintings)>
		
		<cfcatch type="any">
			<cfset ARGUMENTS.event.setArg("response",VARIABLES.errorFlag)>
			<cfset announceEvent("error",ARGUMENTS.event.getArgs())>
		</cfcatch>
		</cftry>
		--->
	</cffunction>

</cfcomponent>