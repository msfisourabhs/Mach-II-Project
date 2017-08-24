<cfif event.isArgDefined("callee")>
	<cfoutput>
		<p>User #event.getArg("callee")# Failed</p>
	</cfoutput>
</cfif>
<cfif event.isArgDefined("message")>
	
	<cfloop array="#event.getArg("message")#" index="i">
		<cfoutput >
			<div id="error">
				<p>#i#</p>
			</div>
		</cfoutput>
	</cfloop>
</cfif>
<cfif event.isArgDefined("response")>
	<cfoutput>
		<p>#event.getArg("response")# </p>
	</cfoutput>
</cfif>
<!---Display all the public painting
	<cfif event.isArgDefined("callee")>
	<cfoutput>
		<p>User #event.getArg("callee")# Failed</p>
	</cfoutput>
</cfif>s in a box format--->
<p>Welcome to this page.Have a look at our art gallery</p>

<div class="paintings">
	<div class="gallery">
	  <a href="#">
	    <img src="/img/machiiLogo.gif" alt="Forest" width="166" height="170">
	  </a>
	  <div class="desc"><a href="#">BatMan</a></div>
	</div>
	<div class="gallery">
	  <a href="#">
	    <img src="/img/machiiLogo.gif" alt="Forest" width="166" height="170">
	  </a>
	  <div class="desc"><a href="#">SuperMan</a></div>
	</div>
</div>

<br>

