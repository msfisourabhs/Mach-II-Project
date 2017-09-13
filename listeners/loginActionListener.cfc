<!----	
	Filename 		:	loginActionListener.cfc 
 	Functionality	:	Listnes for login action events and authenticates user 
 						and generates errors on unsuccessful attempts.
 	Creation Date	:	August ‎11, ‎2017, ‏‎2:42:59 PM
---->

<cfcomponent
	displayname="loginActionListener"
	extends="MachII.framework.Listener"
	output="true"
	hint="login attempt listener "
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
		<cfset VARIABLES.painter = createObject("component","models.painter.painter").init()>
		<cfset VARIABLES.painterDAO = createObject("component","models.painter.painterDAO").init(VARIABLES.painter)>
		<cfset VARIABLES.painterService = createObject("component","models.painter.painterService").init(VARIABLES.painterDAO)>
	</cffunction>
	
	<!---
	PUBLIC FUNCTIONS
	--->
	<cffunction name="doLogin" output="true" access="public" returntype="void"
		hint="function to authenticate user">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		<cfif StructKeyExists(SESSION,"User")>
			<!---If same user submits login requests--->
			<cfset ARGUMENTS.event.setArg("response","You have already logged in")>
			<cfset announceEvent("publicPage",ARGUMENTS.event.getArgs())>
		<cfelse>
			<!--- Fill the painter bean with user inputs --->
			<cfif isValid("email" , ARGUMENTS.event.getArg("userlogin"))>
				<cfset VARIABLES.painter.setEmail(ARGUMENTS.event.getArg("userlogin"))>
			<cfelse>
				<cfset VARIABLES.painter.setUsername(ARGUMENTS.event.getArg("userlogin"))>
			</cfif>
			<cfset VARIABLES.painter.setPassword(ARGUMENTS.event.getArg("password"))>
			<!---Validate the user--->
			<cfset LOCAL.validation = createObject("component","models.painter.authenticationService").init(
												VARIABLES.painter,VARIABLES.painterService)>
			<cfset VARIABLES.errorFlag = LOCAL.validation.doLogin()>
		
			<cfif VARIABLES.errorFlag NEQ "">
				<!---Set error flag and deny login--->
				<cfset ARGUMENTS.event.setArg("errors",VARIABLES.errorFlag)>
				<cfset announceEvent("publicPage",ARGUMENTS.event.getArgs())>
			<cfelse>
				<!---remove error flag and allow login--->
				<cfset ARGUMENTS.event.setArg("response","Login was sucessful")>
				<cfset announceEvent("publicPage",ARGUMENTS.event.getArgs())>
			</cfif>
		</cfif>
	
	</cffunction>

</cfcomponent>