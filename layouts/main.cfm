<html>
		<head>
			<title>Welcome!</title>
			<meta name="viewport" content="width=device-width, initial-scale=1">
  			<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  			<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
  			<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
			<script src="http://yui.yahooapis.com/2.9.0/build/yuiloader/yuiloader-min.js">
			</script>
			<script>
				var loader = new YAHOO.util.YUILoader({
					require: ["base","fonts","container"],
					loadOptional: true,
					timeout: 1000,
					combine: true
				});
				loader.insert();
			</script>
			
			<link rel="stylesheet" href="/includes/css/public.css">
		</head>
		<body class="yui-skin-sam" >
			<!--Header-->
			<cfoutput>
				#event.getArg("headerContent")#
			</cfoutput>

			<!--Body-->
			<cfoutput>
				#event.getArg("publicContent")#
			</cfoutput>
			<!--Footer-->
			<cfoutput>
				#event.getArg("footerContent")#
			</cfoutput>
		</body>
</html>