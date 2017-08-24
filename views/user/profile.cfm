
<cfoutput>
<p>#event.getArg("response")#</p>
<div class="user-info">
	
	<div class="profile-picture" style="display:inline-block;">
		<img src="/img/#event.getArg("userPictures").pictureLocation#"	alt=#event.getArg("userPictures").pictureName# width="166px" height="170px">
		<cfif event.getArg("display") EQ "private">
			<cfoutput>
				<button id="updatePicturePopup" style="width:75%" onclick="updateFileIdentifier(this)"><label class="uploadbttn">Upload Profile Picture</label></button>
			</cfoutput>
		</cfif>
		#event.getArg("updatePicture")#
	</div>
	<div class="profile-description" style="display:inline-block;float:right"> 
		<div class="profile-meta" style="display:inline-block;">
			<h3>#event.getArg("user").name#<h3>
			<h5>#event.getArg("user").city#,#event.getArg("user").country#</h5>
		</div>
		<div class="update-profile" style="display:inline-block;float:right;padding-left:750px">
			#event.getArg("updateProfile")#
			
		</div>
		<div class="profile-about">
			<p>#event.getArg("user").about#</p>
		</div>
		
		<div class="profile-meta" style="float:right">
			<p>#event.getArg("user").email# | #event.getArg("user").phone#</p>
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
		<cfloop query="#event.getArg("userPaintings")#">
			<cfoutput>
				<div class="gallery">
					<a href="##">
					<img src="/img/#PictureLocation#" alt="#PictureName#" width="166px" height="170px">
	 				 </a>
  					<div class="desc">
  						<a href="##">#PictureName#</a>
						<div class="public-box">
						<cfif event.getArg("display") EQ "private">
							<cfif isPublic EQ 1>
								<input type="checkbox" checked title="Hide from Public?" name="public-check" id="public-check_#pid#" style="float:right" onclick="makePaintingsPublic(this)">
							<cfelse>
								<input type="checkbox" title="Make Public?" name="public-check" id="public-check_#pid#" style="float:right" onclick="makePaintingsPublic(this)">
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