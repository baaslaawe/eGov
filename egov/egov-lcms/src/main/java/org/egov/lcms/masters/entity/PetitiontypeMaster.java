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
package org.egov.lcms.masters.entity;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.validation.constraints.Max;
import javax.validation.constraints.NotNull;

import org.egov.infra.persistence.entity.AbstractAuditable;
import org.egov.infra.persistence.validator.annotation.OptionalPattern;
import org.egov.infra.persistence.validator.annotation.Required;
import org.egov.infra.persistence.validator.annotation.Unique;
import org.egov.lcms.utils.LcmsConstants;
import org.hibernate.validator.constraints.Length;

@Entity
@Table(name = "eglc_petitiontype_master")
@Unique(id = "id", tableName = "eglc_petitiontype_master", columnName = { "code" }, fields = {
        "code" }, enableDfltMsg = true)
@SequenceGenerator(name = PetitiontypeMaster.SEQ_PETITIONTYPE, sequenceName = PetitiontypeMaster.SEQ_PETITIONTYPE, allocationSize = 1)
public class PetitiontypeMaster extends AbstractAuditable {
    private static final long serialVersionUID = 796823780349590496L;
    public static final String SEQ_PETITIONTYPE = "SEQ_EGLC_COURT_MASTER";

    @Id
    @GeneratedValue(generator = SEQ_PETITIONTYPE, strategy = GenerationType.SEQUENCE)
    private Long id;

    private Boolean active;

    public Boolean getActive() {
        return active;
    }

    public void setActive(final Boolean active) {
        this.active = active;
    }

    @Required(message = "masters.petitionmaster.petitioncodereq")
    @Length(max = 15, message = "masters.petitionmaster.petitioncodemaxleng")
    @OptionalPattern(regex = "[0-9A-Za-z-]*", message = "masters.petitionmaster.petitioncodePattern")
    private String code;

    @Required(message = "masters.petitionmaster.petitiontypereq")
    @Length(max = 128, message = "masters.petitionmaster.petitiontypemaxleng")
    @OptionalPattern(regex = LcmsConstants.mixedChar, message = "masters.petitionmaster.petitiontypePattern")
    private String petitionType;

    @Max(value = 1000, message = "masters.orderNumber.length")
    private Long ordernumber;

    @NotNull
    @ManyToOne
    @JoinColumn(name = "courttype")
    private CourttypeMaster courtType;

    @Override
    public Long getId() {
        return id;
    }

    @Override
    protected void setId(final Long id) {
        this.id = id;
    }

    public String getCode() {
        return code;
    }

    public void setCode(final String code) {
        this.code = code;
    }

    public CourttypeMaster getCourtType() {
        return courtType;
    }

    public void setCourtType(final CourttypeMaster courtType) {
        this.courtType = courtType;
    }

    public String getPetitionType() {
        return petitionType;
    }

    public void setPetitionType(final String petitionType) {
        this.petitionType = petitionType;
    }

    public Long getOrdernumber() {
        return ordernumber;
    }

    public void setOrdernumber(final Long ordernumber) {
        this.ordernumber = ordernumber;
    }

}