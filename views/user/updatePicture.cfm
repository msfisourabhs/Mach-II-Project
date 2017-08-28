<!----	
	Filename 		:	updatePicture.cfm 
 	Functionality	:	Displays form to update/add pictures/paintings.
 	Creation Date	:	August ‎11, ‎2017, ‏‎2:42:59 PM
---->	
<div id="updatePicture-panel">
	<div class="bd" style="padding:10px 10px;background-color:white">
		<form method="post" id="update-picture-form" action="index.cfm?event=updatePicture" enctype="multipart/form-data" style="display:none;hidden:true;background:url('/img/background8.jpg');background-size:cover;background-repeat:no-repeat;">
			<label class="form-header"><strong>Update-Picture</strong> </label><br><br>
			<hr width="auto" style="border:1px solid black;"><br>
			
			<div class="input-group">
		      <span class="input-group-addon"><i class="glyphicon glyphicon-open-file"></i></span>
		    
				<cfoutput>
					<input type="file" name="userpicture" >
					<input type="hidden" id="fileIdentifier" name="fileIdentifier" value="#event.getArg("userPictures").pid#_">
				</cfoutput>
			</div>
			<button type="submit" class="btn btn-primary btn-block"><label class="uploadbttn">Upload</label></button>
			<br><br>
		</form>
	</div>
</div>
<script>
	var loader = new YAHOO.util.YUILoader({
		require: ["container","element"],
		loadOptional: true,
		timeout: 1000,
		combine: true,
		onSuccess: function(){
			
			var updatePicturePanel = new YAHOO.widget.Panel("updatePicture-panel",{
				close:true,
				modal:true,
				visible:false,
				fixedcenter:true,
				constraintoviewport:true,
				width:"400px",
				height:"220px",
				underlay:"none",
				effect:[{effect:YAHOO.widget.ContainerEffect.FADE,duration:0.5}],
			});
			document.getElementById("update-picture-form").style.hidden = "false"
			document.getElementById("update-picture-form").style.display = "block"
			updatePicturePanel.render();
			
			YAHOO.util.Event.addListener("updatePicturePopup" , "click" , updatePicturePanel.show, updatePicturePanel, true);
			YAHOO.util.Event.addListener("updatePaintingsPopup" , "click" , updatePicturePanel.show, updatePicturePanel, true);
			
		}
	});
	loader.insert();
	function updateFileIdentifier(element){
		var picID = document.getElementById('fileIdentifier');
		if (element.id === "updatePicturePopup"){
			picID.value = picID.value.split("_")[0] + "_userpicture";
		}
		else{
			picID.value = "_userpaintings";
		}
	}
	function makePaintingsPublic(element){
		var picID = element.id.split("_")[1];
		var action = 0;
		if(element.checked ){
			element.setAttribute("title", "Hide from public?");
			action = 1;
		}
		else
			element.setAttribute("title", "Make public?");
		$.getJSON('index.cfm?event=makePaintingsPublic&picId='+picID+'&action='+action,function(result){
			console.log(result);
		});
	}
	</script>

