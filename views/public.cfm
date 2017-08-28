
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
<script>
	window.onload = function(){
			$(".alert").fadeOut(4000);
		}	
</script>
