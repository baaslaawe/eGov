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

<%@ include file="/includes/taglibs.jsp" %>
<div id="CorrAddressDiv">
	<table width="100%">
		<tr>
	      <td class="bluebox" colspan="5" style="padding-left: 5%;"><s:text name="CorrAddrConfirm"/>
	     	<s:checkbox name="propertyDetail.corrAddressDiff" id="corrAddressDiff" value="%{propertyDetail.corrAddressDiff}" onclick="enableCorresAddr();"/> <!--  have to check this -->
	   	  </td>
	    
	    </tr>
	    <tr id="corrAddrHdr">
	      <td colspan="5"><div class="headingsmallbg"><span class="bold"><s:text name="CorrAddr"/></span></div></td>
	    </tr>
	    
	    <tr id="add1Row">
	      <td class="bluebox2" width="5%">&nbsp;</td>
	      <td class="bluebox" width="25%"><s:text name="Address1"/>:</td>
	      <td class="bluebox" style="width:26%;">
	        <s:textfield name="corrAddress1" id="corrAddress1" value="%{corrAddress1}" maxlength="256" onblur="trim(this,this.value);checkZero(this,'Corr Address1');validateAddress(this);"/>
	      </td>
	      
	    </tr>
	
	    <tr id="add2Row">
	      <td class="greybox2" width="5%">&nbsp;</td>
	      <td class="greybox" width="25%"><s:text name="Address2"/>:</td>
	      <td class="greybox" ><s:textfield name="corrAddress2" id="corrAddress2" value="%{corrAddress2}" maxlength="256" onblur="trim(this,this.value);checkZero(this,'Corr Address2');validateAddress(this);"/></td>
	      <td class="greybox" width="25%"><s:text name="PinCode"/>:</td>
	      <td class="greybox" ><s:textfield name="corrPinCode" id="corrPinCode" maxlength="6" styleId = "CorrPinCode" onchange="trim(this,this.value);" onblur = "validNumber(this);checkZero(this);"  value="%{corrPinCode}"/></td>
	    </tr>
    </table>
</div>
