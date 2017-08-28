<!----	
	Filename 		:	validateFields.cfc 
 	Functionality	:	Filter validates the user provided inputs and retruns error 
 						on in successful attempts.
 	Creation Date	:	August ‎11, ‎2017, ‏‎2:42:59 PM
---->
<cfcomponent
	displayname="validateFieldsFilter"
	extends="MachII.framework.EventFilter"
	output="false"
	hint="event filter to validate user inputs.">
	
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
		hint="function validates differrent form fields in various forms">
		<cfargument name="event" type="MachII.framework.Event" required="true"
			hint="current event object created by the Mach II framework." />
		<cfargument name="eventContext" type="MachII.framework.EventContext" required="true"
			hint="current event context object created by the Mach II framework." />
		<cfargument name="paramArgs" type="struct" required="false" default="#structNew()#"
			hint="structure containing the parameters specified in the filter invocation in mach-ii.xml." />		
		<cfscript>
				var errorMessages = arrayNew(1);
				var count = 0;
				//If the event is register or update
				if( getParameter("callee") EQ "register" OR getParameter("callee") EQ "update"){
					arrayAppend(errorMessages,checkWord(ARGUMENTS.event.getArg("name")));
					arrayAppend(errorMessages,checkMail(ARGUMENTS.event.getArg("email")));
					arrayAppend(errorMessages,checkPhone(ARGUMENTS.event.getArg("phone")));
					arrayAppend(errorMessages,checkWord(ARGUMENTS.event.getArg("city")));
					arrayAppend(errorMessages,checkWord(ARGUMENTS.event.getArg("country")));
					arrayAppend(errorMessages,checkWord(ARGUMENTS.event.getArg("username")));
					if(getParameter("callee") EQ "update")
						arrayAppend(errorMessages,checkWord(event.getArg("about")));
				}else{
					//if the parameter is login
					if(getParameter("callee") EQ "login" AND 
						isValid("email",event.getArg("userlogin")))
						arrayAppend(errorMessages,checkMail(ARGUMENTS.event.getArg("userlogin")));
					else
						arrayAppend(errorMessages,checkWord(ARGUMENTS.event.getArg("userlogin")));
				}
				arrayAppend(errorMessages,checkWord(ARGUMENTS.event.getArg("password")));
				//Look for the number of errors encountered
				for(i=1;i<=arrayLen(errorMessages);i++){
					if(errorMessages[i] EQ "OK")
						count++;		
				}
				//errors were encountered.return the error messages
				if(count NEQ arrayLen(errorMessages)){
					ARGUMENTS.event.setArg("message",errorMessages);
					ARGUMENTS.event.setArg("callee",getParameter("callee"));
					if(getParameter("callee") EQ "update")
						announceEvent("userProfile",ARGUMENTS.event.getArgs());
					else
						announceEvent("publicPage",ARGUMENTS.event.getArgs());
					return false;
				}
				else{
					//no errors
					return true;
				}
				
			</cfscript>
	</cffunction>
	<cffunction name="checkWord" access="private" output="false" returntype="string"
				hint="validates if a field has only words">
		<cfargument name="fieldValue" type="string" required="true">
			<cfif isValid("String", ARGUMENTS.fieldValue) AND fieldValue NEQ "">
				<cfreturn "OK">
			<cfelse>
				<cfreturn "Not a valid Input">
			</cfif>				

	</cffunction>
	<cffunction name="checkMail" access="private" output="false" returntype="string"
				hint="validates if a field has email">
		<cfargument name="fieldValue" type="string" required="true">
			<cfif isValid("email", ARGUMENTS.fieldValue) AND fieldValue NEQ "">
				<cfreturn "OK">
			<cfelse>
				<cfreturn "Not a valid Email">
			</cfif>
	</cffunction>
	<cffunction name="checkPhone" access="private" output="false" returntype="string"
				hint="validates if a field has phone number">
		<cfargument name="fieldValue" type="string" required="true">
			<cfif isValid("telephone", ARGUMENTS.fieldValue) AND fieldValue NEQ "">
				<cfreturn "OK">
			<cfelse>
				<cfreturn "Not a valid Phone Number">
			</cfif>
	</cffunction>
				
</cfcomponent>
