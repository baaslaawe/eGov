<%--
  ~ eGov suite of products aim to improve the internal efficiency,transparency,
  ~    accountability and the service delivery of the government  organizations.
  ~
  ~     Copyright (C) <2015>  eGovernments Foundation
  ~
  ~     The updated version of eGov suite of products as by eGovernments Foundation
  ~     is available at http://www.egovernments.org
  ~
  ~     This program is free software: you can redistribute it and/or modify
  ~     it under the terms of the GNU General Public License as published by
  ~     the Free Software Foundation, either version 3 of the License, or
  ~     any later version.
  ~
  ~     This program is distributed in the hope that it will be useful,
  ~     but WITHOUT ANY WARRANTY; without even the implied warranty of
  ~     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  ~     GNU General Public License for more details.
  ~
  ~     You should have received a copy of the GNU General Public License
  ~     along with this program. If not, see http://www.gnu.org/licenses/ or
  ~     http://www.gnu.org/licenses/gpl.html .
  ~
  ~     In addition to the terms of the GPL license to be adhered to in using this
  ~     program, the following additional terms are to be complied with:
  ~
  ~         1) All versions of this program, verbatim or modified must carry this
  ~            Legal Notice.
  ~
  ~         2) Any misrepresentation of the origin of the material is prohibited. It
  ~            is required that all modified versions of this material be marked in
  ~            reasonable ways as different from the original version.
  ~
  ~         3) This license does not grant any rights to any user of the program
  ~            with regards to rights under trademark law for use of the trade names
  ~            or trademarks of eGovernments Foundation.
  ~
  ~   In case of any queries, you can reach eGovernments Foundation at contact@egovernments.org.
  --%>

<script type="text/javascript">

function setWpId(elem){
	document.workspackageForm.workPackageId.value = elem.value;;
}


</script>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
			&nbsp;
		</td>
	</tr>
	<tr>
		<td>
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td colspan="9" class="headingwk" align="left">
						<div class="arrowiconwk">
							<img src="/egworks/resources/erp2/images/arrow.gif" />
						</div>
						<div class="headerplacer">
							<s:text name='page.result.search.estimate' />
						</div>
					</td>
				</tr>
				<tr>
					<td>
						<display:table name="searchResult" pagesize="30" uid="currentRow"
							cellpadding="0" cellspacing="0" requestURI=""
							style="border:1px;width:100%;empty-cells:show;border-collapse:collapse;">

							<display:column headerClass="pagetableth" class="pagetabletd"
								title="Sl.No" titleKey="estimate.search.slno"
								style="width:3%;text-align:right">
								<s:property value="#attr.currentRow_rowNum + (page-1)*pageSize"/>
							</display:column>

							<display:column headerClass="pagetableth" class="pagetabletd"
								title="Select" titleKey="column.title.select"
								style="width:3%;text-align:left">
								<input name="radio" type="radio" id="radio"
									value="<s:property value='%{#attr.currentRow.id}'/>"
									onClick="setWpId(this);" />
							</display:column>

							<display:column headerClass="pagetableth" class="pagetabletd"
								title="WorksPackage Date" titleKey="wp.date" 
								style="width:15%;text-align:left;WORD-BREAK:BREAK-ALL" >
								<s:date name="#attr.currentRow.wpDate" format="dd/MM/yyyy" />
							</display:column>

							<display:column headerClass="pagetableth" class="pagetabletd"
								title="Package Number" titleKey="wp.No" style="width:12%;text-align:left"
								property="wpNumber" />

							<display:column headerClass="pagetableth" class="pagetabletd"
								title="Name" titleKey="wp.name" style="width:13%;text-align:left">
								<a
									href="${pageContext.request.contextPath}/tender/worksPackage-edit.action?id=<s:property value='%{#attr.currentRow.id}'/>&sourcepage=search"><s:property
										value='%{#attr.currentRow.name}' /> </a>
							</display:column>

							<display:column headerClass="pagetableth" class="pagetabletd"
								title="Total" titleKey="estimate.search.total"
								style="width:6%;text-align:right">
								<s:text name="contractor.format.number">
									<s:param name="value" value="%{#attr.currentRow.totalAmount}" />
								</s:text>
								<s:hidden name="abEstId" id="abEstId"
									value="%{#attr.currentRow.id}" />
							</display:column>
							
						</display:table>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
