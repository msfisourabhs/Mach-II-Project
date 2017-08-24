<cfcomponent
	displayname="RegisterDataFilter"
	extends="MachII.framework.EventFilter"
	output="false"
	hint="A simple event filter for registration data.">
	
	<!---
	PROPERTIES
	--->
	
	<!---
	INITIALIZATION / CONFIGURATION
	--->
	<cffunction name="configure" access="public" returntype="void" output="false"
		hint="Configures the filter.">
		<!--- Put custom configuration for this filter here. --->
		<cfscript>
			variables.name = "";
			variables.email = "";
			variables.phone = "";
			variables.city = "";
			variables.country = "";
			variables.phone = "";
			variables.username = "";
			variables.password = "";
		</cfscript>
	</cffunction>
	
	<!---
	PUBLIC FUNCTIONS
	--->
	<cffunction name="filterEvent" access="public" returntype="boolean" output="false"
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
			<cfscript>
				variables.name = event.getArg("name");
				variables.email = event.getArg("email");
				variables.phone = event.getArg("phone");
				variables.city = event.getArg("city");
				variables.country = event.getArg("country");
				variables.username = event.getArg("username");
				variables.password = event.getArg("password");

				if(variables.username EQ "" AND variables.password EQ ""){
					arguments.event.setArg("message","Username/Password field was empty");
					announceEvent("loginFailed",arguments.event.getArgs());
					return false;
				}
				else
					return true;
			</cfscript>
			
	</cffunction>
	
</cfcomponent>
