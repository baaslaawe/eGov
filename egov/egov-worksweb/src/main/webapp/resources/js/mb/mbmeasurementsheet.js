var sorMsArray=new Array(200);
var nonSorMsArray=new Array(200);
var headstart="<!--only for validity head start -->";
var headend="<!--only for validity head end -->";
var tailstart="<!--only for validity tail start -->";
var tailend="<!--only for validity tail end -->";
function addMBMSheet(obj)
{
	var rowid=obj.id;
	sorId=rowid.split(".");
	var	sortable=sorId[0];

	var msfieldsName=rowid.replace("msadd","measurementSheets");
	var   mscontent=document.getElementById(rowid.replace("msadd","mstd")).innerHTML;

	var   msopen=document.getElementById(rowid.replace("msadd","msopen")).value;
	if(msopen==1)
		return ;

	if(mscontent!='')
	{
		if(mscontent.indexOf(headstart) >=0)
		  {
		  var head= mscontent.substring(mscontent.indexOf(headstart),mscontent.indexOf(headend));
		  var tail= mscontent.substring(mscontent.indexOf(tailstart),mscontent.indexOf(tailend));
		  mscontent= mscontent.replace(head,"");
		  mscontent= mscontent.replace(tail,"");
		  }
		
		var curRow = $(obj).closest('tr');
		var k= "<tr id=\""+sortable+".mstr\"><td colspan=\"15\">";
		mscontent=k+mscontent+"</td></tr>";
		curRow.after(mscontent);
		document.getElementById(rowid.replace("msadd","mstd")).innerHTML="";
		document.getElementById(rowid.replace("msadd","msopen")).value="1";
		var idx=sortable.substr(sortable.indexOf("["),sortable.indexOf("]"));
		
		if(sortable.indexOf("sorMbDetails") >= 0)
		{
			sorMsArray[idx]=mscontent;
		}
		else
		{
			nonSorMsArray[idx]=mscontent;
		}
	}else
	{
		var curRow = $(obj).closest('tr');
		var newrow= $('#msheaderrowtemplate').html();

		newrow=  newrow.replace(/msrowtemplate/g,'msrow'+sortable);
		newrow=  newrow.replace(/templatesorMbDetails\[0\]/g,sortable);
		document.getElementById(rowid.replace("msadd","msopen")).value="1";
		document.getElementById(rowid.replace("msadd","mspresent")).value="1";
		curRow.after(newrow);
		var idx=sortable.substr(sortable.indexOf("["),sortable.indexOf("]"));
		if(sortable.indexOf("sorMbDetails") >= 0)
		{
			sorMsArray[idx]="";
		}
		else
		{
			nonSorMsArray[idx]="";
		}

	}
	patternvalidation();
}

$(document).on('click','.hide-ms',function () {

	var sid=$(this).closest('tr').attr("id");
	var name=	sid.split(".")[0]
	var idx=name.substr(name.indexOf("["),name.indexOf("]"));
	if(sid.split(".")[0].indexOf("sorMbDetails") >= 0)
	{
		document.getElementById(sid.split(".")[0]+".mstd").innerHTML=sorMsArray[idx];
		if(sorMsArray[idx].length==0)
			document.getElementById(sid.split(".")[0]+".mspresent").value="0";
			
	}else
	{
		document.getElementById(sid.split(".")[0]+".mstd").innerHTML=nonSorMsArray[idx];
		if(nonSorMsArray[idx].length==0)
			document.getElementById(sid.split(".")[0]+".mspresent").value="0";
	}

	document.getElementById(sid.split(".")[0]+".msopen").value="0";
	
	var mstr=document.getElementById(sid.split(".")[0]+".mstr");
	$(mstr).remove();
});

$(document).on('change','.runtime-update',function (e) {
	if($(this).is("input"))
	{
		//console.log('input value change triggered!');
		if($(this).val()==0)
			{
			alert("Zero is not allowed");
			$(this).val('');
			}
		$(this).attr('value', $(this).val());
	}
	else if($(this).is("textarea"))
	{
		$(this).html($(this).val());
	}
	if($(this).attr('id').indexOf("quantity")>=0)
		findNet(this);
	else
	findTotal(this);
});

$(document).on('click','.ms-submit',function () {

	var sid=$(this).attr("id");
	var mscontent="<tr id=\""+sid.split(".")[0]+".mstr\">";

	var net=eval(document.getElementById(sid.split(".")[0]+".msnet").innerHTML);
	if(net==NaN ||net<=0)
	{
		alert("Net amount should be greater than 0");
		return false;
	}
	var qobj1=document.getElementById(sid.split(".")[0]+".measurementSheets[0].no");
	if(!validateMsheet(qobj1))
	{
		return false;
	}

	document.getElementsByName(sid.split(".")[0]+".quantity")[0].value=document.getElementById(sid.split(".")[0]+".msnet").innerHTML;
	mscontent=document.getElementById(sid.split(".")[0]+".mstr").innerHTML;
	document.getElementById(sid.split(".")[0]+".mstr")
	document.getElementById(sid.split(".")[0]+".mstd")
	document.getElementById(sid.split(".")[0]+".mstd").innerHTML=mscontent;
	document.getElementById(sid.split(".")[0]+".msopen").value="0";
	var mstr=document.getElementById(sid.split(".")[0]+".mstr");
	$(mstr).remove();
	var qobj=document.getElementsByName(sid.split(".")[0]+".quantity")[0];
	if(sid.split(".")[0].indexOf("sorMbDetails") >= 0)
	{
		calculateSorAmounts(document.getElementsByName(sid.split(".")[0]+".quantity")[0]);
	}else
	{
		calculateNonSorAmounts(document.getElementsByName(sid.split(".")[0]+".quantity")[0]);
	}
});

function reindex(tableId)
{

	var idx=0;
	tbl=document.getElementById(tableId);
	////console.log($(tbl).html());

	$(tbl).find("tbody tr").each(function(e) {

		//console.log('for loop');
		$(this).find("input,select,textarea").each(function() {
			var classval = jQuery(this).attr('class');	
			if(classval.indexOf("spanslno") > -1) {
				jQuery(this).val(idx+1);
			}

			$(this).attr({
				'name' : function(_, name) {
					if(name)
						return name.replace(/measurementSheets\[.\]/g, "measurementSheets["+idx+"]");
				},
				'id' : function(_, id) {
					if(id)
						return id.replace(/measurementSheets\[.\]/g, "measurementSheets["+idx+"]");
				},
				'data-idx' : function(_, dataIdx) {
					return idx;
				}
			});

		});
		idx++;
	});


}

$(document).on('click','.reset-ms',function () {
	var len=$(this).closest('table').find('.runtime-update').val("");
});

function findTotal(obj)
{

	var name=obj.name.split(".");
	var lengthname=name[0]+'.'+name[1]+'.length';
	var no1,depthOrHeight1,width1,length1;
	var lent=$('input[id="'+lengthname+'"]');
	//console.log($(lent).attr('value'));
	var length=$(lent).attr('value');
	var no=$('input[id="'+name[0]+'.'+name[1]+'.no'+'"]').attr('value');
	var depthOrHeight=$('input[id="'+name[0]+'.'+name[1]+'.depthOrHeight'+'"]').attr('value');
	var width=$('input[id="'+name[0]+'.'+name[1]+'.width'+'"]').attr('value');

	if(isEmpty(length) && isEmpty(no) && isEmpty(depthOrHeight)  && isEmpty(width))
		$('input[id="'+name[0]+'.'+name[1]+'.quantity'+'"]').attr('value',0);
	else {
		if (length === undefined || length == '' || length == 0)
			length = 1;
		if (no === undefined || no == '' || no == 0)
			no = 1;
		if (depthOrHeight === undefined || depthOrHeight == '' || depthOrHeight == 0)
			depthOrHeight = 1;
		if (width === undefined || width == '' || width == 0)
			width = 1;
		var net=parseFloat(length * no * width * depthOrHeight).toFixed(4);

		document.getElementById(name[0]+'.'+name[1]+'.quantity').value=net;
		$('input[id="'+name[0]+'.'+name[1]+'.quantity'+'"]').attr('value',net);

	}
	var netObj=document.getElementById(name[0]+'.'+name[1]+'.quantity');
	$(netObj).attr('value', document.getElementById(name[0] + '.' + name[1] + '.quantity').value);
	var len=$(obj).closest('table').find('tbody').children.length;
	//console.log(len);
	if(name[0].indexOf("sorMbDetails") >= 0)
		findNet(netObj);
	else
		findNonSorNet(netObj);
}

function isEmpty(str)
{
	if(!str)
	{
		return true;
	}
	else if(!str.trim()) {
		return true;
	}

	return false;
}


function findNet(obj)
{
	var len=$(obj).closest('tbody').find('tr').length;
	
	var name=obj.id.split(".");
	
	var index = name[0].split('[')[1].split(']')[0];

	var sum=0;
	for(var i=0;i<len - 1;i++)
	{
		var qname=name[0]+'.measurementSheets['+i+'].quantity';
		var quantity=eval(document.getElementById(qname).value);
		var oname= '#msrowidentifier_' + index + '_' + i;
		var operation=$(oname).html().trim();
		console.log(quantity+"---"+operation);
		if(quantity===undefined)
			quantity=0;
		if(quantity==NaN)
			quantity=0;
		if(quantity=='')
			quantity=0;
		if(operation=='No')
			sum=sum+quantity;
		else
			sum=sum-quantity;
	}
	//var fname=obj.name.split(".");
	var netName=name[0]+'.msnet';
	sum=parseFloat(sum).toFixed(4);
	//console.log(document.getElementById(netName).innerHTML);
	document.getElementById(netName).innerHTML=sum;
}

function findNonSorNet(obj)
{
	var len=$(obj).closest('tbody').find('tr').length;
	
	var name=obj.id.split(".");
	
	var index = name[0].split('[')[1].split(']')[0];

	var sum=0;
	for(var i=0;i<len - 1;i++)
	{
		var qname=name[0]+'.measurementSheets['+i+'].quantity';
		var quantity=eval(document.getElementById(qname).value);
		var oname= '#nonsormsrowidentifier_' + index + '_' + i;
		var operation=$(oname).html().trim();
		console.log(quantity+"---"+operation);
		if(quantity===undefined)
			quantity=0;
		if(quantity==NaN)
			quantity=0;
		if(quantity=='')
			quantity=0;
		if(operation=='No')
			sum=sum+quantity;
		else
			sum=sum-quantity;
	}
	//var fname=obj.name.split(".");
	var netName=name[0]+'.msnet';
	sum=parseFloat(sum).toFixed(4);
	//console.log(document.getElementById(netName).innerHTML);
	document.getElementById(netName).innerHTML=sum;
}

function closeAllmsheet()
{
	var open=false;
	$('.classmsopen').each(function (index)
			{

		if($( this ).val()==1)
		{
			var sid=$( this ).attr('id');
			// var sid=k.closest('tr').attr("id");
			var mscontent="<tr id=\""+sid.split(".")[0]+".mstr\">";
			document.getElementsByName(sid.split(".")[0]+".quantity")[0].value=document.getElementById(sid.split(".")[0]+".msnet").innerHTML;

			mscontent=document.getElementById(sid.split(".")[0]+".mstr").innerHTML;

			document.getElementById(sid.split(".")[0]+".mstr")
			document.getElementById(sid.split(".")[0]+".mstd")
			document.getElementById(sid.split(".")[0]+".mstd").innerHTML=mscontent;
			document.getElementById(sid.split(".")[0]+".msopen").value="false";
			var mstr=document.getElementById(sid.split(".")[0]+".mstr");
			$(mstr).remove(); 
			var qobj=document.getElementsByName(sid.split(".")[0]+".quantity")[0];
			$(qobj).attr("readonly","readonly");
			if(sid.split(".")[0].indexOf("sorMbDetails") >= 0)
			{
				calculateEstimateAmount(document.getElementsByName(sid.split(".")[0]+".quantity")[0]);
			}else
			{
				calculateNonSorEstimateAmount(document.getElementsByName(sid.split(".")[0]+".quantity")[0]);
			}

		}
			});
	return open;
}

function ismsheetOpen()
{
	var open=false;
	$('.classmsopen').each(function (index)
			{

		if($( this ).val()==1)
			open=true
			});
	return open;
}