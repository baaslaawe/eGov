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

<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="/WEB-INF/taglibs/cdn.tld" prefix="cdn"%>

<form:form name="overheadForm" id="overheadForm" role="form" action="/egworks/masters/overhead-save" modelAttribute="overhead"  class="form-horizontal form-groups-bordered">
	<input type="hidden" value="<spring:message code='overhead.overheadRates.invalid' />" id='overheadRateDetails'>
	<input type="hidden" value="<spring:message code='overhead.date.invalid' />" id='validateDate'>
	<input type="hidden" value="<spring:message code='overhead.lumpsumandpercentage.invalid' />" id='validateLumpsumAndPercentage'>
	<input type="hidden" value="<spring:message code='overhead.percentage.invalid' />" id='validateTotalPercentage'>
	<div class="errorstyle" id="overhead_error" class="alert alert-danger"
		style="display: none;"></div>
		<input type="hidden" name="mode" value="${mode}" />
	<spring:hasBindErrors name="overhead">
		<div class="alert alert-danger col-md-10 col-md-offset-1">
			<form:errors path="*" cssClass="add-margin" />
			<br />
		</div>
	</spring:hasBindErrors>
	<div class="row">
		<div class="col-md-12">
			<jsp:include page="overheadHeader.jsp" />
			<jsp:include page="overheadDetails.jsp" />
		</div>
	</div>
	<div class="row">
		<div class="col-sm-12 text-center">
		<c:choose>
			<c:when test="${mode == 'edit' }">
				<button type="submit" name="submit" id="save"
					class="btn btn-primary" value="Modify">
					<spring:message code="lbl.modify" />
				</button>
			</c:when>
			<c:otherwise>
				<button type="submit" name="submit" id="save"
					class="btn btn-primary" value="Save">
					<spring:message code="lbl.save" />
				</button>
			</c:otherwise>
		</c:choose>
			<button type="button" class="btn btn-default" id="button2"
				onclick="window.close();">
				<spring:message code="lbl.close" />
			</button>
		</div>
	</div>
</form:form>
<script
	src="<cdn:url value='/resources/js/master/overhead.js?rnd=${app_release_no}'/>"></script>