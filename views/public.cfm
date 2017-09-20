<!----	
	Filename 		:	public.cfm 
 	Functionality	:	View page for all the public paintings
 	Creation Date	:	August ‎11, ‎2017, ‏‎2:42:59 PM
---->

<p>Welcome Artists and Art Lovers.Have a look at our art gallery.</p>
<div id="paintings">
	<cfloop array="#event.getArg("paintings")#" index="painting">
		<cfoutput >
			<div class="gallery">
			  <a href="##">
				<img src="/img/#painting.Paintings.getLocation()#" alt="#painting.Paintings.getName()#" width="166px" height="170px">
		 	  </a>
			  <div class="desc">
			  	<a href="index.cfm?event=showPublicProfile&uid=#painting.uid#">
			  		#painting.PainterName#
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
