<h4>
	Welcome	
	<cfif StructKeyExists(Session,"name")>
		<cfoutput>
			<a href="index.cfm?event=userProfile">#Session.name#</a>
		</cfoutput>
	</cfif>
	| <a href="index.cfm?event=logoutAction">Sign Out</a>
</h4>
