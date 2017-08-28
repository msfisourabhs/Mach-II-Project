<!----	
	Filename 		:	logout.cfm 
 	Functionality	:	Displays user name of logged in user and a logout button
 	Creation Date	:	August ‎11, ‎2017, ‏‎2:42:59 PM
---->
<h4>
	Welcome	
	<cfif StructKeyExists(Session,"name")>
		<cfoutput>
			<a href="index.cfm?event=userProfile">#Session.name#</a>
		</cfoutput>
	</cfif>
	| <a href="index.cfm?event=logoutAction">Sign Out</a>
</h4>
