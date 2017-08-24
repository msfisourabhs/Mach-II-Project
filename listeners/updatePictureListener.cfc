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
	<cffunction name="updatePicture" output="true" access="public" returntype="void"
		hint="I am a boilerplate function">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		
		<cfset local.pictureType = arguments.event.getArg("fileIdentifier").Split("_")[2]>
		<cfset local.fileIdentifier = arguments.event.getArg("fileIdentifier").Split("_")[1]>
		<cfif local.pictureType EQ "userpicture">
			<!---Grab the file location for the older file--->
			<cfquery datasource="Mach2DS" name="fetchFileName">
				SELECT PictureLocation,PictureName
					FROM dbo.User_Pictures
				WHERE pid = <cfqueryparam cfsqltype="cf_sql_integer" value="#local.fileIdentifier#" null="false" maxlength="5">
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
					PictureName = '#event.getArg("fileInfo").serverfilename#' ,
					PictureLocation = 'uploads/#event.getArg("fileInfo").serverfile#' 
				WHERE 
					uid = #Session.uid# 
					AND
					pid = <cfqueryparam cfsqltype="cf_sql_integer" value=#local.fileIdentifier# null="false" maxlength="5">
			</cfquery>
		<cfelse>
			<cfquery datasource="Mach2DS">
				INSERT INTO dbo.User_Pictures
					(uid,PictureName,PictureLocation,isPublic,TypeID)
				VALUES
					(#Session.uid#,
					<cfqueryparam cfsqltype="cf_sql_varchar" value=#event.getArg("fileInfo").serverfilename# null="false" maxlength="100">,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="uploads/#event.getArg("fileInfo").serverfile#" null="false" maxlength="150">,
					0,2)
			</cfquery>
		</cfif>
		<!---Move the new file--->
		<cfset fileMove("#getTempDirectory()##event.getArg("fileInfo").serverFile#","C:\ColdFusion10\cfusion\wwwroot\Projects\Mach2\img\uploads\")>
		
			
	</cffunction>
</cfcomponent>