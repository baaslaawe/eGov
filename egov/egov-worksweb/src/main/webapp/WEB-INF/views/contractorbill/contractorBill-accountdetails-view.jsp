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

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>



<div class="panel-heading custom_form_panel_heading">
	<div class="panel-title">
		<spring:message  code="lbl.debit.details"/>
	</div>
</div>

<div style="padding: 0 15px;">
		<table class="table table-bordered" id="tbldebitdetails-view">
			<thead>
				<tr>
					<th><spring:message code="lbl.account.code"/></th>
					<th><spring:message code="lbl.account.head"/></th>
					<th><spring:message code="lbl.debit.amount"/></th>
				</tr>
			</thead>
			<tbody>
			<c:forEach items="${billDetailsMap}" var="debitBillDetails" varStatus="item">
				<c:if test="${debitBillDetails.isDebit && !debitBillDetails.isRefund}"> 
					<tr>					
						<td>
							<c:out value="${debitBillDetails.glcode}" /> 
						</td>
						<td>
							<c:out value="${debitBillDetails.accountHead}" /> 
						</td>
						<td class="text-right">
							<fmt:formatNumber maxFractionDigits="2" minFractionDigits="2" groupingUsed="false" value="${debitBillDetails.amount}" />
						</td>
					</tr>
				</c:if>
			</c:forEach>
			</tbody>
		</table>
	</div>
	
	<div class="panel-heading custom_form_panel_heading">
	<div class="panel-title">
		<spring:message  code="lbl.refund"/>
	</div>
</div>

<div style="padding: 0 15px;">
		<table class="table table-bordered" id="tbldebitdetails-view">
			<thead>
				<tr>
					<th><spring:message code="lbl.account.code"/></th>
					<th><spring:message code="lbl.account.head"/></th>
					<th><spring:message code="lbl.withheld.amount"/></th>
					<th><spring:message code="lbl.refundedsofar.amount"/></th>
					<th><spring:message code="lbl.debit.amount"/></th>
				</tr>
			</thead>
			<tbody>
			<c:forEach items="${billDetailsMap}" var="debitBillDetails" varStatus="item">
				<c:if test="${debitBillDetails.isDebit && debitBillDetails.isRefund}"> 
					<tr>	
					    <td>
							<c:out value="${debitBillDetails.glcode}" /> 
						</td>
						<td>
							<c:out value="${debitBillDetails.accountHead}" /> 
						</td>
						<td class="text-right">
							<c:out value="${debitBillDetails.withHeldAmount}" /> 
						</td>
						<td class="text-right">
							<c:out value="${debitBillDetails.RefundedAmount}" /> 
						</td>
						<td class="text-right">
							<fmt:formatNumber maxFractionDigits="2" minFractionDigits="2" groupingUsed="false" value="${debitBillDetails.amount}" />
						</td>
					</tr>
					</c:if>
					</c:forEach>
					
	</tbody>
	</table>
	</div>

<div class="panel-heading custom_form_panel_heading">
	<div class="panel-title">
		<spring:message  code="lbl.credit.details"/>
	</div>
</div>


<div class="panel-heading custom_form_panel_heading">
	<div class="panel-title">
			<spring:message  code="lbl.deductions"/>
	</div>
</div>

<div style="padding: 0 15px;">
		<table class="table table-bordered" id="tblcreditdetails-view">
			<thead>
				<tr>
					<th><spring:message code="lbl.account.code"/></th>
					<th><spring:message code="lbl.account.head"/></th>
					<th><spring:message code="lbl.credit.amount"/></th>
				</tr>
			</thead>
			<tbody>
			<c:forEach items="${billDetailsMap}" var="creditBillDetails" varStatus="item">
				<c:if test="${!creditBillDetails.isDebit && !creditBillDetails.isNetPayable}"> 
					<tr id="deductionRow">
						<td>
							<c:out value="${creditBillDetails.glcode}" /> 
						</td>
						<td>
							<c:out value="${creditBillDetails.accountHead}" /> 
						</td>
						<td class="text-right">
							<fmt:formatNumber maxFractionDigits="2" minFractionDigits="2" groupingUsed="false" value="${creditBillDetails.amount}" />
						</td>					
					</tr>
				</c:if>
			</c:forEach>
			</tbody>
		</table>
</div>

<div class="panel-heading custom_form_panel_heading">
	<div class="panel-title">
		<spring:message  code="lbl.netpayable"/>
	</div>
</div>
	
	<div style="padding: 0 15px;">
		<table class="table table-bordered" id="tblnetpayable-view"> 
			<thead>
				<tr>
					<th><spring:message code="lbl.account.code"/></th>
					<th><spring:message code="lbl.account.head"/></th>
					<th><spring:message code="lbl.credit.amount"/></th>
				</tr>
			</thead>
			<tbody>
			<c:forEach items="${billDetailsMap}" var="netPayableDetails" varStatus="item">
				<c:if test="${!netPayableDetails.isDebit && netPayableDetails.isNetPayable}"> 
					<tr id="deductionRow">
						<td>
							<c:out value="${netPayableDetails.glcode}" /> 
						</td>
						<td>
							<c:out value="${netPayableDetails.accountHead}" /> 
						</td>
						<td class="text-right">
							<fmt:formatNumber maxFractionDigits="2" minFractionDigits="2" groupingUsed="false" value="${netPayableDetails.amount}" />
						</td>					
					</tr>
				</c:if>
			</c:forEach>
			</tbody>
		</table>
	</div>
