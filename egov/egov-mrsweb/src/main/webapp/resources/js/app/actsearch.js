/*
 * eGov suite of products aim to improve the internal efficiency,transparency,
 *    accountability and the service delivery of the government  organizations.
 *
 *     Copyright (C) <2016>  eGovernments Foundation
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


$(document).ready( function () {
	
	
$('#btnSearch').click(function(e) {
	 callAjaxSearch();
		return false;
	});


	function callAjaxSearch() {
		
						$('.report-section').removeClass('display-hide');
						reportdatatable =	$("#actResultTable")
								.dataTable(
										{
											ajax : {
												url : "/mrs/masters/act/searchResult",
												type : "POST",
												beforeSend:function(){
													$('.loader-class').modal('show', {backdrop: 'static'});
												},
												"data" : getFormData($('form')),
												complete:function(){
													$('.loader-class').modal('hide');
												}
											},

											"bDestroy" : true,
											"sDom" : "<'row'<'col-xs-12 hidden col-right'f>r>t<'row'<'col-xs-3'i><'col-xs-3 col-right'l><'col-xs-3 col-right'<'export-data'T>><'col-xs-3 text-right'p>>",
											"aLengthMenu" : [
													[ 10, 25, 50, -1 ],
													[ 10, 25, 50, "All" ] ],
											"oTableTools" : {
												"sSwfPath" : "../../../../../../egi/resources/global/swf/copy_csv_xls_pdf.swf",
												"aButtons" : [ "xls", "pdf",
														"print" ]
											},
											aaSorting : [],
											columns : [ {
												"data" : "name",
												"sClass" : "text-left"
											}, {
												"data" : "description",
												"sClass" : "text-left"
											}, {
												"data" : "createdDate",
												"sClass" : "text-left"
											}, {
												
												"data" : "id",
											    sortable: false,
											    "render": function ( data, type, row, meta ) {
												        var mode = $('#mode').val();
												        if(mode == 'edit'){
												          	 return '<button type="button" class="btn btn-xs btn-secondary edit"><span class="glyphicon glyphicon-edit"></span>&nbsp;Edit</button>';
												        }else{
												          	 return '<button type="button" class="btn btn-xs btn-secondary view"><span class="glyphicon glyphicon-tasks"></span>&nbsp;View</button>';
												        }
											    }
											
											}]
											
										});
								
						
						
				}
	
	$("#actResultTable").on('click','tbody tr td  .view',function(event) {
		var id = reportdatatable.fnGetData($(this).parent().parent(),3);
		window.open('/mrs/masters/act/view' +'/'+id,'','width=800, height=600,scrollbars=yes');
	});

	$("#actResultTable").on('click','tbody tr td  .edit',function(event) {
		var id = reportdatatable.fnGetData($(this).parent().parent(),3);
		window.open('/mrs/masters/act/edit' +'/'+id,'','width=800, height=600,scrollbars=yes');
	});
	
});



function getFormData($form){
    var unindexed_array = $form.serializeArray();
    var indexed_array = {};

    $.map(unindexed_array, function(n, i){
        indexed_array[n['name']] = n['value'];
    });

    return indexed_array;
}


