<!----	
	Filename 		:	updatePictureListener.cfc 
 	Functionality	:	Listnes for update picture events and updates user paintings/picture
 						It updates user data in DB.
 	Creation Date	:	August ‎23, ‎2017, ‏‎2:42:59 PM
---->
<cfcomponent
	displayname="updatePictureListener"
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
	<cffunction name="updatePicture" output="false" access="public" returntype="void"
		hint="function updates profile information by adding new paintings/pictures">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		
		<cfset LOCAL.pictureType = ARGUMENTS.event.getArg("fileIdentifier").Split("_")[2]>
		<cfset LOCAL.fileIdentifier = ARGUMENTS.event.getArg("fileIdentifier").Split("_")[1]>
		<cfif LOCAL.pictureType EQ "userpicture">
			<!---Grab the file location for the older file--->
			<cfquery datasource="Mach2DS" name="fetchFileName">
				SELECT PictureLocation,PictureName
					FROM dbo.User_Pictures
				WHERE pid = <cfqueryparam cfsqltype="cf_sql_integer" value="#LOCAL.fileIdentifier#" null="false" maxlength="5">
			</cfquery>
			<!---Delete the older file--->
			<cfif fetchFileName.PictureName NEQ "unknown-user"> 
				<cffile action="delete" 
					file="C:\ColdFusion10\cfusion\wwwroot\Projects\Mach2\img\#fetchFileName.PictureLocation#">
			</cfif>
			<!---Update the new file in the database--->
			<cfquery datasource="Mach2DS" >
				UPDATE dbo.User_Pictures
				SET 
					PictureName = '#ARGUMENTS.event.getArg("fileInfo").serverfilename#' ,
					PictureLocation = 'uploads/#ARGUMENTS.event.getArg("fileInfo").serverfile#' 
				WHERE 
					uid = #SESSION.uid# 
					AND
					pid = <cfqueryparam cfsqltype="cf_sql_integer" value=#LOCAL.fileIdentifier# null="false" maxlength="5">
			</cfquery>
		<cfelse>
			<cfquery datasource="Mach2DS">
				INSERT INTO dbo.User_Pictures
					(uid,PictureName,PictureLocation,isPublic,TypeID)
				VALUES
					(#SESSION.uid#,
					<cfqueryparam cfsqltype="cf_sql_varchar" value=#ARGUMENTS.event.getArg("fileInfo").serverfilename# null="false" maxlength="100">,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="uploads/#ARGUMENTS.event.getArg("fileInfo").serverfile#" null="false" maxlength="150">,
					0,2)
			</cfquery>
		</cfif>
		<!---Move the new file--->
		<cfset fileMove("#getTempDirectory()##ARGUMENTS.event.getArg("fileInfo").serverFile#","C:\ColdFusion10\cfusion\wwwroot\Projects\Mach2\img\uploads\")>
		
			
	</cffunction>
</cfcomponent>