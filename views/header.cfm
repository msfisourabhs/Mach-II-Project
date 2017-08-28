<!----	
	Filename 		:	header.cfm 
 	Functionality	:	Displays header with welcome message,signin or signout content,
 						Errors,responses and messages to users
 	Creation Date	:	August ‎11, ‎2017, ‏‎2:42:59 PM
---->
<div class="header">
	<div class="header-left">
		<h1 style="font-size:50px"> <a href="index.cfm?event=publicPage">
			<img src="/img/logo.jpg" width="50px" height="50px">The Art Gallery</a></h1>
	</div>
	<div class="header-right"> 
		<!---to look for sign in status of user--->
		<cfoutput>
			<cfif StructKeyExists(SESSION,"uid")>
				#event.getArg("logoutContent")#
			<cfelse>
				#event.getArg("loginForm")#
			</cfif>
		</cfoutput>
	</div>
	<div style="float:right" >
		<!---user action--->
		<cfif event.isArgDefined("callee")>
			<cfoutput>
				<div class="alert alert-danger">
		  			<p>User #event.getArg("callee")# Failed</p>
				</div>
			</cfoutput>
		</cfif>
		<!---User action failed error message--->
		<cfif event.isArgDefined("message")>
			<cfoutput >
				<div class="alert alert-danger">
		  			<p> There were one or more errors in your submissions</p>
				</div>
			</cfoutput>
			<!---
			<cfloop array="#event.getArg("message")#" index="i">
				<cfoutput >
					<div class="alert alert-danger">
		  				<p>#i#</p>
					</div>
				</cfoutput>
			</cfloop>
			--->
		</cfif>
		<!---User action success--->
		<cfif event.isArgDefined("response")>
			<cfoutput>
				<div class="alert alert-success">
					<p>#event.getArg("response")# </p>
				</div>
			</cfoutput>
		</cfif>
		<!---custom errors--->
		<cfif event.isArgDefined("errors")>
			<cfoutput>
				<div class="alert alert-danger">
					<p>#event.getArg("errors")# </p>
				</div>
			</cfoutput>
		</cfif>
	</div>
</div>

<hr>