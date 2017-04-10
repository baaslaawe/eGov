<%--
  ~ eGov suite of products aim to improve the internal efficiency,transparency,
  ~    accountability and the service delivery of the government  organizations.
  ~
  ~     Copyright (C) <2017>  eGovernments Foundation
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
<div class="row">
	<div class="col-md-12">
		<div class="panel panel-primary" data-collapsed="0">
			<div class="panel-heading">
				<div class="panel-title">Search BPA Applications</div>
			</div>
			<div class="panel-body">
				<div class="form-group">
					<label class="col-sm-3 control-label text-right"><spring:message
							code="lbl.applicant.name" /></label>
					<div class="col-sm-3 add-margin">
						<form:input class="form-control patternvalidation"
							data-pattern="alphabetwithspace" maxlength="128"
							id="applicantName" path="applicantName" required="required" />
						<form:errors path="applicantName" cssClass="add-margin error-msg" />
					</div>
					<label class="col-sm-2 control-label text-right"><spring:message
							code="lbl.application.no" />
						<span class="mandatory"></span>
					</label>
					<div class="col-sm-3 add-margin">
						<form:input class="form-control patternvalidation" maxlength="50"
							id="applicationNumber" path="applicationNumber" />
						<form:errors path="applicationNumber"
							cssClass="add-margin error-msg" />
					</div>
				</div>

				<div class="form-group">
					<label class="col-sm-3 control-label text-right"><spring:message
							code="lbl.ward" /> 
					</label>
					<div class="col-sm-3 add-margin">
						<form:select path="wardId" data-first-option="false" id="wardId"
							cssClass="form-control">
							<form:option value="">
								<spring:message code="lbl.select" />
							</form:option>
							<form:options items="${wards}" itemValue="id" itemLabel="name" />
						</form:select>
						<form:errors path="wardId" cssClass="add-margin error-msg" />
					</div>
					<label class="col-sm-2 control-label text-right"><spring:message
							code="lbl.election.ward" /></label>
					<div class="col-sm-3 add-margin">
						<form:select path="electionWardId" data-first-option="false"
							id="electionWardId" cssClass="form-control" required="required">
							<form:option value="">
								<spring:message code="lbl.select" />
							</form:option>
							<form:options items="${electionwards}" itemValue="id"
								itemLabel="name" />
						</form:select>
						<form:errors path="electionWardId" cssClass="add-margin error-msg" />
					</div>
				</div>
			</div>
		</div>
	</div>
</div>