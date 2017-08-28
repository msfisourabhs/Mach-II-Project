/*	Filename 		: 	login.js
 	Functionality	:	Adds client side validation of fields
 						Dynamically generates errors on invalid inputs 
	Creation Date	:	August ‎22, ‎2017, ‏‎2:42:59 PM
*/

window.onload = addHandler();	
function addHandler(){
	var userlogin = document.getElementById("form-userlogin");
	userlogin.addEventListener("blur", checkUserLogin);
	userlogin.addEventListener("focus", clearErrors);
	
	var password = document.getElementById("form-password");
	password.addEventListener("blur", checkEmptyAndSpaces);
	password.addEventListener("focus", clearErrors);
}

function checkUserLogin(){
	if(!checkEmptyAndSpaces.call(this)){ 
		if(( checkWords.call(this) || checkEmail.call(this))
			|| (checkEmail.call(this) || checWords.call(this)))
			
			{}
		else
			generateErrors("Email address/Username is not valid",this);
	}
}
function checkWords()
{
	var value = this;
	var counter=0;
	var len = this.value.length;
	for(var iterator=0 ; iterator<len; iterator++)
	{
		var unicode = this.value.charCodeAt(iterator);
		if((unicode >= 65 && unicode <=90) || (unicode >= 97 && unicode <= 122))
				counter++;
	}
	
	if(counter !== len)
		return false;	
	return true;
}

function checkEmail()
{
		
	var counter_d=0,counter_p=0;
	var val = this.value;
	var atloc = val.indexOf("@");
	var charAllowed = ["!","#","$","%","&","'","*","+","-","/","=","?","^","_","`","{","}","|","~"];
	if(atloc === 0 || atloc === val.length-1 || atloc !== val.lastIndexOf("@") || atloc === -1)
	{
		return false;
	}
	var personalInfo = val.split("@")[0];
	var domainInfo = val.split("@")[1];
	var checkPinfo = function(){
		for(var iterator = 0 ; iterator<personalInfo.length ; iterator++)
		{
			var unicode = personalInfo.charCodeAt(iterator);
		
			if((unicode >= 65 && unicode <=90) || (unicode >= 97 && unicode <= 122) || (charAllowed.indexOf(personalInfo[iterator]) !== -1) || (unicode>=48 && unicode<=57))
			
				counter_p++;
			
			if(unicode === 46)
			{
				
				if(iterator !== 0 && iterator !== personalInfo.length-1 && personalInfo[iterator+1] !== ".")
					counter_p++;	
			}
		}
		if(counter_p !== personalInfo.length)
			return false;
		else
			return true;
	};
	
	
	var checkDinfo = function(){
		for(var iterator = 0 ; iterator<domainInfo.length ; iterator++)
		{
			var unicode = domainInfo.charCodeAt(iterator);
			if((unicode >= 65 && unicode <=90) || (unicode >= 97 && unicode <= 122) || (unicode === 45) || (unicode>=48 && unicode<=57))
				counter_d++;
			
			if(unicode === 46)
			{
				if(iterator !== 0 && iterator !== domainInfo.length-1 && (domainInfo[iterator+1] !== ".") &&iterator !== domainInfo.length-2 && (domainInfo[iterator+2] !== "."))
					counter_d++;
			}
			
		
		}
		if(counter_d !== domainInfo.length)
			return false;
		else
			return true;
	};
	
	if (checkDinfo() === false || checkPinfo() === false) {
		return false;
	}
	
}
function generateErrors(errormssg,name)
{
	var em = document.createElement("p");
	if(name.classList.contains("required") && errormssg.length === 0)
		em.appendChild(document.createTextNode("This field cannot be empty"));
	else	
		em.appendChild(document.createTextNode(errormssg));
	
	name.insertAdjacentElement('afterend',em);
	em.setAttribute("class" , "errors");
	em.style.color = "red";	
	return;
}

function clearErrors()
{
	
	if(this.nextElementSibling.classList.contains("errors"))
		this.nextElementSibling.remove();
	
	return;
}

function checkEmptyAndSpaces()
{
	
	var val = this.value;
	var len = this.value.length;
	var temp = "";
	for(iterator = 0 ; iterator < len ; iterator++)
	{
		if(val.charAt(iterator) !== " ")
			temp +=  val.charAt(iterator).toString();
	}
	this.value = temp;
	if(temp.length === 0)
	{	
		generateErrors("",this);
		return true;
	}
	else
		return false;
	
}
    
