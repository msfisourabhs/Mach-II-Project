<div class="header">
	<div class="header-left">
		<h1> <a href="index.cfm?event=publicPage">The Art Gallery</a></h1>
	</div>
	<div class="header-right"> 
		<cfoutput>
			<cfif StructKeyExists(Session,"uid")>
				#event.getArg("logoutContent")#
			<cfelse>
				#event.getArg("loginForm")#
			</cfif>
		</cfoutput>
	</div>
</div>

<hr>