<!----	
	Filename 		:	updatePictureFilter.cfc 
 	Functionality	:	Filter validates whether picture uploaded follows all
 						the constraintsa and filters out unsuccessful attempts. 
 	Creation Date	:	August ‎23, ‎2017, ‏‎2:42:59 PM
---->
<cfcomponent
	displayname="updatePictureFilter"
	extends="MachII.framework.EventFilter"
	output="true"
	hint="event filter for checking the picture uploaded.">
	
	<!---
	PROPERTIES
	--->
	
	<!---
	INITIALIZATION / CONFIGURATION
	--->
	<cfset VARIABLES.errorFlag = "">
	<cffunction name="configure" access="public" returntype="void" output="false"
		hint="Configures the filter.">
		<!--- Put custom configuration for this filter here. --->
	</cffunction>
	
	<!---
	PUBLIC FUNCTIONS
	--->
	<cffunction name="filterEvent" access="public" returntype="boolean" output="true"
		hint="functions validates whether a picture uploaded follows all the constraints">
		<cfargument name="event" type="MachII.framework.Event" required="true"
			hint="current event object created by the Mach II framework." />
		<cfargument name="eventContext" type="MachII.framework.EventContext" required="true"
			hint="current event context object created by the Mach II framework." />
		<cfargument name="paramArgs" type="struct" required="false" default="#structNew()#"
			hint="structure containing the parameters specified in the filter invocation in mach-ii.xml." />		
		<cfset LOCAL.tempDirectory = getTempDirectory()>
			<cftry>
				<!---Check for the upload type to be image files only--->
				<cfif len(trim(ARGUMENTS.event.getArg("userpicture")))>
				  <cffile action="upload" 
				     fileField="userpicture"
				     destination=#LOCAL.tempDirectory#
					 accept="image/jpg,image/png,image/jpeg"
					 result="uploadResponse"
					 nameconflict="overwrite" >
				<cfelse>
					<!---User enetered no file---->
					<cfset VARIABLES.errorFlag = "The file size cannot be 0 bytes">
				</cfif>
				
			<cfcatch name="fileResponse" type="any">
				<!---User entered a non-image file---->
				<cfset VARIABLES.errorFlag = fileResponse.Detail>
			</cfcatch>	
			</cftry>
			<cfif VARIABLES.errorFlag EQ "">	
				<!---Upload was successful with all the checks--->
				<cfset ARGUMENTS.event.setArg("fileInfo",VARIABLES.uploadResponse)>
				<cfreturn true>
			<cfelse>
				<!----Return user to their profile page with error message--->
				<cfset ARGUMENTS.event.setArg("errors",VARIABLES.errorFlag)>
		 		<cfset announceEvent("userProfile",ARGUMENTS.event.getArgs())>
				<cfreturn false>
			</cfif>
	</cffunction>
	
</cfcomponent>
