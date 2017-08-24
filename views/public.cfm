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
<p>Welcome Artists and Art Lovers.Have a look at our art gallery.</p>

<div class="paintings">
	<cfloop query="#event.getArg("paintings")#">
		<cfoutput >
			<div class="gallery">
			  <a href="##">
				<img src="/img/#PictureLocation#" alt="#PictureName#" width="166px" height="170px">
		 	  </a>
			  <div class="desc">
			  	<a href="index.cfm?event=showPublicProfile&uid=#uid#">
			  		#Name#
			  	</a>
				<div class="public-box">
				</div>		
			  </div>
			</div>
		</cfoutput>
	</cfloop>
</div>

<br>

