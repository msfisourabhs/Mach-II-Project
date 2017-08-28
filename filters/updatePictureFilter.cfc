﻿<cfcomponent
	displayname="RegisterDataFilter"
	extends="MachII.framework.EventFilter"
	output="true"
	hint="A simple event filter for registration data.">
	
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
		hint="I am invoked by the Mach II framework.">
		<cfargument name="event" type="MachII.framework.Event" required="true"
			hint="I am the current event object created by the Mach II framework." />
		<cfargument name="eventContext" type="MachII.framework.EventContext" required="true"
			hint="I am the current event context object created by the Mach II framework." />
		<cfargument name="paramArgs" type="struct" required="false" default="#structNew()#"
			hint="I am the structure containing the parameters specified in the filter invocation in mach-ii.xml." />		
		<!--- Put logic here.
			Return FALSE to abort the current event handler.
			Return TRUE to continue the current event handler. --->
		<cfset LOCAL.tempDirectory = getTempDirectory()>
			<cftry>
				<cfif len(trim(arguments.event.getArg("userpicture")))>
				  <cffile action="upload" 
				     fileField="userpicture"
				     destination=#LOCAL.tempDirectory#
					 accept="image/jpg,image/png,image/jpeg"
					 result="uploadResponse"
					 nameconflict="overwrite" >
				<cfelse>
					<cfset VARIABLES.errorFlag = "The file size cannot be 0 bytes">
				</cfif>
				
			<cfcatch name="fileResponse" type="any">
				<cfset VARIABLES.errorFlag = fileResponse.Detail>
			</cfcatch>	
			</cftry>
			<cfif VARIABLES.errorFlag EQ "">	
				<cfset arguments.event.setArg("fileInfo",variables.uploadResponse)>
				<cfreturn true>
			<cfelse>
				<cfset arguments.event.setArg("errors",VARIABLES.errorFlag)>
		 		<cfset announceEvent("userProfile",arguments.event.getArgs())>
				<cfreturn false>
			</cfif>
	</cffunction>
	
</cfcomponent>
