<cfcomponent
	displayname="LoginFilter"
	extends="MachII.framework.EventFilter"
	output="false"
	hint="A simple event filter for login and register.">
	
	<!---
	PROPERTIES
	--->
	
	<!---
	INITIALIZATION / CONFIGURATION
	--->
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
			<cfscript>
				var errorMessages = arrayNew(1);
				var count = 0;
				if( getParameter("callee") EQ "register" OR getParameter("callee") EQ "update"){
					arrayAppend(errorMessages,checkWord(event.getArg("name")));
					arrayAppend(errorMessages,checkMail(event.getArg("email")));
					arrayAppend(errorMessages,checkPhone(event.getArg("phone")));
					arrayAppend(errorMessages,checkWord(event.getArg("city")));
					arrayAppend(errorMessages,checkWord(event.getArg("country")));
					arrayAppend(errorMessages,checkWord(event.getArg("username")));
					if(getParameter("callee") EQ "update")
						arrayAppend(errorMessages,checkWord(event.getArg("about")));
				}else{
					if(getParameter("callee") EQ "login" AND 
						isValid("email",event.getArg("userlogin")))
						arrayAppend(errorMessages,checkMail(event.getArg("userlogin")));
					else
						arrayAppend(errorMessages,checkWord(event.getArg("userlogin")));
				}
				arrayAppend(errorMessages,checkWord(event.getArg("password")));
				for(i=1;i<=arrayLen(errorMessages);i++){
					if(errorMessages[i] EQ "OK")
						count++;		
				}
				if(count NEQ arrayLen(errorMessages)){
					arguments.event.setArg("message",errorMessages);
					arguments.event.setArg("callee",getParameter("callee"));
					if(getParameter("callee") EQ "update")
						announceEvent("userProfile",arguments.event.getArgs());
					else
						announceEvent("failed",arguments.event.getArgs());
					return false;
				}
				else{
					return true;
				}
				
			</cfscript>
	</cffunction>
	<cffunction name="checkWord" access="private" output="false" returntype="string">
		<cfargument name="fieldValue" type="string" required="true">
			<cfif isValid("String", arguments.fieldValue) AND fieldValue NEQ "">
				<cfreturn "OK">
			<cfelse>
				<cfreturn "Not a valid Input">
			</cfif>				

	</cffunction>
	<cffunction name="checkMail" access="private" output="false" returntype="string">
		<cfargument name="fieldValue" type="string" required="true">
			<cfif isValid("email", arguments.fieldValue) AND fieldValue NEQ "">
				<cfreturn "OK">
			<cfelse>
				<cfreturn "Not a valid Email">
			</cfif>
	</cffunction>
	<cffunction name="checkPhone" access="private" output="false" returntype="string">
		<cfargument name="fieldValue" type="string" required="true">
			<cfif isValid("telephone", arguments.fieldValue) AND fieldValue NEQ "">
				<cfreturn "OK">
			<cfelse>
				<cfreturn "Not a valid Phone Number">
			</cfif>
	</cffunction>
				
</cfcomponent>
