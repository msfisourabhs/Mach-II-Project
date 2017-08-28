<div class="header">
	<div class="header-left">
		<h1 style="font-size:50px"> <a href="index.cfm?event=publicPage">
			<img src="/img/logo.jpg" width="50px" height="50px">The Art Gallery</a></h1>
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
	<div style="float:right" >
		<cfif event.isArgDefined("callee")>
			<cfoutput>
				<div class="alert alert-danger">
		  			<p>User #event.getArg("callee")# Failed</p>
				</div>
			</cfoutput>
		</cfif>
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
		<cfif event.isArgDefined("response")>
			<cfoutput>
				<div class="alert alert-success">
					<p>#event.getArg("response")# </p>
				</div>
			</cfoutput>
		</cfif>

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