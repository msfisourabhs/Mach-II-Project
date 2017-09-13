<!----	
	Filename 		:	profile.cfm 
 	Functionality	:	Displays user profile for public/private events.
 	Creation Date	:	August ‎11, ‎2017, ‏‎2:42:59 PM
---->

<cfdump var="#SESSION.User#">
<cfoutput>
<div class="user-info">
	
	<div class="profile-picture" style="display:inline-block;float:left">
		<img src="/img/#SESSION.User.getProfilePicture().getLocation()#" alt=#SESSION.User.getProfilePicture().getName()# width="166px" height="170px">
		<cfif event.getArg("display") EQ "private">
			<cfoutput>
				<button id="updatePicturePopup" class="btn btn-primary" style="display:block" onclick="updateFileIdentifier(this)">
					<label class="uploadbttn">Upload Profile Picture</label>
				</button>
			</cfoutput>
		</cfif>
		#event.getArg("updatePicture")#
	</div>
	<div class="profile-description" style="display:inline-block;width:75%;padding-left:140px"> 
		<div class="profile-meta" style="display:inline-block;">
			<h3>#SESSION.User.getName()#<h3>
			<h5>#SESSION.User.getCity()#,#SESSION.User.getCountry()#</h5>
		</div>
		<div class="update-profile" style="display:inline-block;float:right;">
			#event.getArg("updateProfile")#
			
		</div>
		<div class="profile-about">
			<p>#SESSION.User.getAbout()#</p>
		</div>
		
		<div class="profile-meta" style="float:right">
			<p>#SESSION.User.getEmail()# | #SESSION.User.getPhone()#</p>
		</div>
	</div>
</div>

<hr style="border:1px dashed black;display:inline-block;">
<h3>Paintings</h3>

<div class="user-paintings">
	<cfif event.getArg("display") EQ "private">
		<cfoutput>
			<div class="painting-edit" style="text-align:right">
				<a href="##" id="updatePaintingsPopup" onclick="updateFileIdentifier(this)">Add Painting</a>
			</div>
		</cfoutput>
	</cfif>
	<div class="painting-collection">
		<cfloop array="#SESSION.User.getPaintings()#" index="painting">
			<cfoutput>
				<div class="gallery">
					<a href="##">
					<img src="/img/#painting.getLocation()#" alt="#painting.getName()#" width="166px" height="170px">
	 				 </a>
  					<div class="desc">
  						<a href="##">#painting.getName()#</a>
						<div class="public-box">
						<cfif event.getArg("display") EQ "private">
							<cfif painting.getIsPublic() EQ 1>
								<input type="checkbox" checked title="Hide from Public?" name="public-check" id="public-check_#painting.getPid()#" style="float:right" onclick="makePaintingsPublic(this)">
							<cfelse>
								<input type="checkbox" title="Make Public?" name="public-check" id="public-check_#painting.getPid()#" style="float:right" onclick="makePaintingsPublic(this)">
							</cfif>
						</cfif>
						</div>
					</div>
			 	</div>		
			</cfoutput>
		</cfloop>
	</div>
</div>
</cfoutput>

<script>
	window.onload = function(){
			$(".alert").fadeOut(4000);
		}	
</script>
