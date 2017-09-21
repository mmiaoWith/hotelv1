var curIndex = 0;
function show(){
	var bigImgSpan = document.getElementById('bigImage');
	var arrayLength = pictures.length;
	if(curIndex>=arrayLength){
		curIndex = curIndex -1;
		alert("The last one!");
		return;
	}
	if(curIndex<0){
		curIndex=curIndex+1;
		alert("The first one!");
		return;
	}
	document.getElementById('bigNext').className = "";
	document.getElementById('bigPre').className = "";
	document.getElementById('litterNext').className = "";
	document.getElementById('litterPre').className = "";
	if(curIndex == arrayLength-1){
		document.getElementById('bigNext').className = "endlink";
		document.getElementById('litterNext').className = "end";
	}
	if(curIndex == 0){
		document.getElementById('bigPre').className = "endlink";
		document.getElementById('litterPre').className = "end";
	}
	var litters=document.getElementById('litterImage').getElementsByTagName('span');
	for(var i=0;i<arrayLength;i++){
		litters[i].className = "";
	};
	
	bigImgSpan.innerHTML = "<IMG src='"+pictures[curIndex]+"' id='curBigImg'/>";
	litters[curIndex].className = "dc_select";
	var curBigImg = document.getElementById('curBigImg');
	var currentRate = curBigImg.width / curBigImg.height;
	if(curBigImg.width > 620){
		if(620/currentRate<420){
			curBigImg.width = 620;
			curBigImg.height = 620/currentRate;
		}else{
			curBigImg.width = 420*currentRate;
			curBigImg.height = 420;
		}
	}
	if(curBigImg.height > 420){
		if(420*currentRate<620){
			curBigImg.width = 420*currentRate;
			curBigImg.height = 420;
		}else{
			curBigImg.width = 620;
			curBigImg.height = 620/currentRate;
		}
	}
}
function showFix(fixIndex){
	curIndex = fixIndex;
	show();
}
function next(){
	curIndex = curIndex+1;
	show();
}
function pre(){
	curIndex = curIndex-1;
	show();
}
function changeImage(){
	if(moveAction=="pre"){
		pre();
	}
	if(moveAction=="next"){
		next();
	}
}
var moveAction;
$(document).ready(function() {
	$("#bigImage").mousemove(function(e){  
		 var positionX=e.originalEvent.x||e.originalEvent.layerX||0;
		 if(positionX<=$(this).width()/2){           
			 this.style.cursor='url("booth_left.cur"),auto';
			 $(this).attr('title','1');
			 moveAction = 'pre';
		 }else{  
			 this.style.cursor='url("booth_right.cur"),auto';
			 $(this).attr('title','2');
			  moveAction = 'next';
		}  
	});
});