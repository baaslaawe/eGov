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

$(document).ready(function() {
	
	drillDowntableContainer = jQuery("#attendanceResultTable");	
	
		reportdatatable = drillDowntableContainer
			.dataTable({
				ajax : {
					url : "/council/councilmeeting/attendance/ajaxsearch/"+$('#councilId').val(),      
					type: "GET"
				},
				"destroy": true,
				"sDom": "<'row'<'col-xs-12 hidden col-right'f>r>t<'row'<'col-md-3 col-xs-12'i><'col-md-3 col-xs-6 col-right'l><'col-xs-12 col-md-3 col-right'<'export-data'T>><'col-md-3 col-xs-6 text-right'p>>",
				"aLengthMenu" : [[10,25,50,-1 ],[10,25,50,"All" ] ],
				"autoWidth" : false,
				"oTableTools" : {
					"sSwfPath" : "../../../../../../egi/resources/global/swf/copy_csv_xls_pdf.swf",
					"aButtons" : [ 
					               {
						             "sExtends": "pdf",
						             "sPdfMessage" : "Council Meeting Attendance Report generated on "
											+ $('#currDate').val() + "",
				                     "sTitle": $('#cityName').val(),
				                     "sPdfOrientation": "landscape"
					                },
					                {
							             "sExtends": "xls",
							             "sPdfMessage" : "Council Meeting Attendance Report generated on "
												+ $('#currDate').val() + "",
				                         "sTitle": $('#cityName').val()
						             },
						             {
							             "sExtends": "print",
				                         "sTitle": "Council Meeting Attendance Report"
						             }],
			},
				aaSorting: [],				

				columns : [ {
									"data" : "name",
									"sClass" : "text-left"
								}, {
									"data" : "electionWard",
									"sClass" : "text-center"
								}, {
									"data" : "designation",
									"sClass" : "text-center"
								}, {
									"data" : "qualification",
									"sClass" : "text-left"
								}, {
									"data" : "partyAffiliation",
									"sClass" : "text-center"
								}, {
									"data" : "mobileNumber",
									"sClass" : "text-left"
								}, {
									"data" : "address",
									"sClass" : "text-left"
								}, {
									"data" : "meetingDate",
									"sClass" : "text-left"
								}, {
									"data" : "committeeType",
									"sClass" : "text-left"
								}, {
									"data" : "attendance",
									"sClass" : "text-left"
								} ]				
			});
			
});