<div class="header">
	<div class="header-left">
		<h1> Logo</h1>
	</div>
	<div class="header-right"> 
		<cfoutput>
			<cfif event.isArgDefined("logoutContent")>
				#event.getArg("logoutContent")#
			<cfelse>
				#event.getArg("loginForm")#
			</cfif>
		</cfoutput>
	</div>
</div>

<hr>