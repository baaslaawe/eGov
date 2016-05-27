/*
 * eGov suite of products aim to improve the internal efficiency,transparency,
 *    accountability and the service delivery of the government  organizations.
 *
 *     Copyright (C) <2015>  eGovernments Foundation
 *
 *     The updated version of eGov suite of products as by eGovernments Foundation
 *     is available at http://www.egovernments.org
 *
 *     This program is free software: you can redistribute it and/or modify
 *     it under the terms of the GNU General Public License as published by
 *     the Free Software Foundation, either version 3 of the License, or
 *     any later version.
 *
 *     This program is distributed in the hope that it will be useful,
 *     but WITHOUT ANY WARRANTY; without even the implied warranty of
 *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *     GNU General Public License for more details.
 *
 *     You should have received a copy of the GNU General Public License
 *     along with this program. If not, see http://www.gnu.org/licenses/ or
 *     http://www.gnu.org/licenses/gpl.html .
 *
 *     In addition to the terms of the GPL license to be adhered to in using this
 *     program, the following additional terms are to be complied with:
 *
 *         1) All versions of this program, verbatim or modified must carry this
 *            Legal Notice.
 *
 *         2) Any misrepresentation of the origin of the material is prohibited. It
 *            is required that all modified versions of this material be marked in
 *            reasonable ways as different from the original version.
 *
 *         3) This license does not grant any rights to any user of the program
 *            with regards to rights under trademark law for use of the trade names
 *            or trademarks of eGovernments Foundation.
 *
 *   In case of any queries, you can reach eGovernments Foundation at contact@egovernments.org.
 */

jQuery(document).ready(function(){
	
	var hint='<a href="#" class="hintanchor" onMouseover="showhint(\'@fulldescription@\', this, event, \'300px\')"><img src="/egworks/resources/erp2/images/help.gif" alt="Help" width="16" height="16" border="0" align="absmiddle"/></a>'
	
	jQuery('#sorSearch').blur(function() {
		jQuery('#sorSearch').val('');
	});
	
	var sorSearch = new Bloodhound({
	    datumTokenizer: function (datum) {
	        return Bloodhound.tokenizers.whitespace(datum.value);
	    },
	    queryTokenizer: Bloodhound.tokenizers.whitespace,
	    remote: {
	        url: '/egworks/abstractestimate/ajaxsor-byschedulecategories?code=',
	        replace: function (url, query) {
	        		var scheduleCategories = jQuery('#scheduleCategory').val();
	        		if(scheduleCategories == null)
	        			bootbox.alert("Please select Schedule Of Category");
	        	    return url + query + '&scheduleCategories=' + scheduleCategories;
	        	},
	        filter: function (data) {
	            return jQuery.map(data, function (ct) {
	                return {
	                	id: ct.id,
	                    code: ct.code,
	                    description: ct.description,
	                    uom: ct.uom.uom,
	                    rate: ct.sorRates[0].rate.value,
	                    summary: ct.summary,
	                    displayResult: ct.code+' : '+ct.summary
	                };
	            });
	        }
	    }
	});

	sorSearch.initialize();
	var sorSearch_typeahead = jQuery('#sorSearch').typeahead({
		hint : true,
		highlight : true,
		minLength : 2
	}, {
		displayKey : 'displayResult',
		source : sorSearch.ttAdapter()
	}).on('typeahead:selected', function (event, data) {
		var flag = false;
		jQuery('.hidden-input').each(function() {
			if(jQuery(this).val() == data.id) {
				flag = true;
			}
		});
		if(flag) {
			bootbox.alert("Sor Already added.", function() {
				jQuery('#sorSearch').val('');
			});
		}
		else {
			var hiddenRowCount = jQuery("#tblestimate tbody tr:hidden[id='estimateRow']").length;
			if(hiddenRowCount == 0) {
				addLineEstimate();
			} else {
				jQuery('#estimateRow').show();
			}
			var rowcount = jQuery("#tblestimate tbody tr").length;
			var key = parseInt(rowcount) - 2;
			jQuery.each(data, function(id, val) {
				if(id == "id")
					jQuery('#' + id + "_" + key).val(val);
				if(id == 'description') {
					jQuery('.' + id + "_" + key).html(hint.replace(/@fulldescription@/g, val));
				}
					
				else
					jQuery('.' + id + "_" + key).html(val);
			});
			jQuery('#message').hide();
		}
		jQuery('#sorSearch').val('');
    });
});

function getRow(obj) {
	if(!obj)return null;
	tag = obj.nodeName.toUpperCase();
	while(tag != 'BODY'){
		if (tag == 'TR') return obj;
		obj=obj.parentNode ;
		tag = obj.nodeName.toUpperCase();
	}
	return null;
}

function addLineEstimate() {
	var rowcount = jQuery("#tblestimate tbody tr").length;
	if (rowcount < 31) {
		if (document.getElementById('estimateRow') != null) {
			// get Next Row Index to Generate
			var nextIdx = jQuery("#tblestimate tbody tr").length - 1;

			// Generate all textboxes Id and name with new index
			jQuery("#estimateRow").clone().find("input, span").each(
					function() {

						if(!jQuery(this).is('span')) {
							jQuery(this).attr({
								'name' : function(_, name) {
									return name.replace(/\d+/,nextIdx);
								},
								'id' : function(_, id) {
									return id.replace(/\d+/, nextIdx);
								},
								'data-idx' : function(_,dataIdx)
								{
									return nextIdx;
								}
							});
						} else {
							jQuery(this).attr({
								'class' : function(_, name) {
									return name.replace(/\d+/, nextIdx);
								}
							});
						}
					}).end().appendTo("#tblestimate tbody");
			$('#quantity_' + nextIdx).val('');
			$('.amount_' + nextIdx).html('');
			$('#vat_' + nextIdx).val('');
			$('.vatAmount_' + nextIdx).html('');
			$('.total_' + nextIdx).html('');
			
			generateSno();
			
		}
	} else {
		  bootbox.alert('limit reached!');
	}
}

function generateSno()
{
	var idx=1;
	jQuery(".spansno").each(function(){
		jQuery(this).text(idx);
		idx++;
	});
}

function deleteLineEstimate(obj) {
    var rIndex = getRow(obj).rowIndex;
    
    var id = jQuery(getRow(obj)).children('td:first').children('input:first').val();
    //To get all the deleted rows id
    var aIndex = rIndex - 1;

	var tbl=document.getElementById('tblestimate');	
	var rowcount=jQuery("#tblestimate tbody tr").length;

	if(rowcount==2) {
		jQuery('.hidden-input').val('');
		jQuery('#estimateRow').hide();
		jQuery('#message').show();
	} else {
		tbl.deleteRow(rIndex);
	}
	//starting index for table fields
	generateSno();
	
	var idx = -1;
	
	//regenerate index existing inputs in table row
	jQuery("#tblestimate tbody tr").each(function() {
		jQuery(this).find("input, span").each(function() {
			if(!jQuery(this).is('span')) {
			   jQuery(this).attr({
			      'name': function(_, name) {
			    	  return name.replace(/\d+/, idx); 
			      },
			      'id' : function(_, id) {
						return id.replace(/\d+/, idx);
					},
					'data-idx' : function(_,dataIdx)
					{
						return idx;
					}
			   });
			} else {
				jQuery(this).attr({
					'class' : function(_, name) {
						return name.replace(/\d+/, idx);
					}
				});
			}
	    });
		idx++;
	});
	calculateEstimateAmountTotal();
	return true;
}

function calculateEstimateAmount(currentObj) {
	rowcount = getRow(currentObj).rowIndex - 2;
	var rate = parseFloat($('.rate_' + rowcount).html().trim());
	$('.amount_' + rowcount).html(parseFloat($(currentObj).val() * rate).toFixed(2));
	$('.total_' + rowcount).html(parseFloat($(currentObj).val() * rate).toFixed(2));
	calculateEstimateAmountTotal();
	total();
}

function calculateEstimateAmountTotal() {
	var total = 0;
	$('.amount').each(function() {
		total = parseFloat(parseFloat(total) + parseFloat($(this).html().trim())).toFixed(2);
	});
	$('#sorEstimateTotal').html(total);
}

function total() {
	var total = 0.0;
	$('.total').each(function() {
		total = parseFloat(parseFloat(total) + parseFloat($(this).html().trim())).toFixed(2);
	});
	$('#sorTotal').html(total);
}

var ie=document.all
var ns6=document.getElementById&&!document.all

function showhint(menucontents, obj, e, tipwidth) {
	if ((ie || ns6) && document.getElementById("hintbox")) {
		dropmenuobj = document.getElementById("hintbox")
		dropmenuobj.innerHTML = menucontents
		dropmenuobj.style.left = dropmenuobj.style.top = -500
		if (tipwidth != "") {
			dropmenuobj.widthobj = dropmenuobj.style
			dropmenuobj.widthobj.width = tipwidth
		}
		dropmenuobj.x = getposOffset(obj, "left")
		dropmenuobj.y = getposOffset(obj, "top")
		dropmenuobj.style.left = dropmenuobj.x
				- clearbrowseredge(obj, "rightedge") + obj.offsetWidth + "px"
		dropmenuobj.style.top = dropmenuobj.y
				- clearbrowseredge(obj, "bottomedge") + "px"
		dropmenuobj.style.visibility = "visible"
		obj.onmouseout = hidetip
	}
}