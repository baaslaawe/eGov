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
package org.egov.ptis.service.utils;

import static org.egov.collection.constants.CollectionConstants.QUERY_RECEIPTS_BY_RECEIPTNUM;
import static org.egov.ptis.constants.PropertyTaxConstants.APPCONFIG_DIGITAL_SIGNATURE;
import static org.egov.ptis.constants.PropertyTaxConstants.ARREARS;
import static org.egov.ptis.constants.PropertyTaxConstants.ARR_COLL_STR;
import static org.egov.ptis.constants.PropertyTaxConstants.ARR_DMD_STR;
import static org.egov.ptis.constants.PropertyTaxConstants.CURRENTYEAR_FIRST_HALF;
import static org.egov.ptis.constants.PropertyTaxConstants.CURRENTYEAR_SECOND_HALF;
import static org.egov.ptis.constants.PropertyTaxConstants.CURR_FIRSTHALF_COLL_STR;
import static org.egov.ptis.constants.PropertyTaxConstants.CURR_FIRSTHALF_DMD_STR;
import static org.egov.ptis.constants.PropertyTaxConstants.CURR_SECONDHALF_COLL_STR;
import static org.egov.ptis.constants.PropertyTaxConstants.CURR_SECONDHALF_DMD_STR;
import static org.egov.ptis.constants.PropertyTaxConstants.DEMANDRSN_STR_EDUCATIONAL_CESS;
import static org.egov.ptis.constants.PropertyTaxConstants.DEMANDRSN_STR_GENERAL_TAX;
import static org.egov.ptis.constants.PropertyTaxConstants.DEMANDRSN_STR_LIBRARY_CESS;
import static org.egov.ptis.constants.PropertyTaxConstants.DEMANDRSN_STR_UNAUTHORIZED_PENALTY;
import static org.egov.ptis.constants.PropertyTaxConstants.DEMANDRSN_STR_VACANT_TAX;
import static org.egov.ptis.constants.PropertyTaxConstants.PTMODULENAME;

import java.math.BigDecimal;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.TreeMap;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import org.apache.log4j.Logger;
import org.egov.collection.constants.CollectionConstants;
import org.egov.collection.entity.ReceiptHeader;
import org.egov.commons.Installment;
import org.egov.commons.dao.InstallmentDao;
import org.egov.eis.service.PositionMasterService;
import org.egov.infra.admin.master.entity.AppConfigValues;
import org.egov.infra.admin.master.entity.Module;
import org.egov.infra.admin.master.service.AppConfigValueService;
import org.egov.infra.admin.master.service.ModuleService;
import org.egov.infra.exception.ApplicationRuntimeException;
import org.egov.pims.commons.Position;
import org.egov.ptis.client.util.PropertyTaxUtil;
import org.egov.ptis.constants.PropertyTaxConstants;
import org.egov.ptis.domain.entity.property.BasicProperty;
import org.egov.ptis.domain.entity.property.Property;
import org.egov.ptis.service.DemandBill.DemandBillService;
import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;

public class PropertyTaxCommonUtils {
    private static final Logger LOGGER = Logger.getLogger(PropertyTaxCommonUtils.class);

    @PersistenceContext
    private EntityManager entityManager;

    @Autowired
    private AppConfigValueService appConfigValuesService;
    
    @Autowired
    private PropertyTaxUtil propertyTaxUtil;
    
    @Autowired
    private ApplicationContext beanProvider;

    @Autowired
    private PositionMasterService positionMasterService;
    
    @Autowired
    private ModuleService moduleService;
    
    @Autowired
    private InstallmentDao installmentDao;
    

    /**
     * Gives the first half of the current financial year
     *
     * @return Installment - the first half of the current financial year for PT
     *         module
     */
    public Installment getCurrentInstallment() {
        final Query query = entityManager
                .unwrap(Session.class)
                .createQuery(
                        "select installment from Installment installment,CFinancialYear finYear where installment.module.name =:moduleName  and (cast(:currDate as date)) between finYear.startingDate and finYear.endingDate "
                                + " and cast(installment.fromDate as date) >= cast(finYear.startingDate as date) and cast(installment.toDate as date) <= cast(finYear.endingDate as date) order by installment.fromDate asc ");
        query.setString("moduleName", PropertyTaxConstants.PTMODULENAME);
        query.setDate("currDate", new Date());
        List<Installment> installments = query.list();
        return installments.get(0);
    }

    /**
     * Returns AppConfig Value for given key and module.Key needs to exact as in
     * the Database,otherwise empty string will send
     *
     * @param key
     *            - Key value for which AppConfig Value is required
     * @param moduleName
     *            - Value for the User Id
     * @return String.
     */
    public String getAppConfigValue(final String key, final String moduleName) {
        String value = "";
        if (key != null && moduleName != null) {
            final AppConfigValues appConfigValues = appConfigValuesService.getAppConfigValueByDate(moduleName, key,
                    new Date());
            if (appConfigValues != null)
                value = appConfigValues.getValue();
        }
        return value;
    }
    
    /**
     * Fetches the tax details for workflow property
     * @param basicProperty
     * @return Map<String, Object>
     */
    public Map<String, Object> getTaxDetailsForWorkflowProperty(BasicProperty basicProperty) {
        Map<String, Map<String, BigDecimal>> demandCollMap = new TreeMap<String, Map<String, BigDecimal>>();
        Map<String, Object> wfPropTaxDetailsMap = new HashMap<String, Object>();
        Property property = basicProperty.getWFProperty();
        try {
            demandCollMap = propertyTaxUtil.prepareDemandDetForView(property, getCurrentInstallment());
            if (!demandCollMap.isEmpty()) {
                for (Entry<String, Map<String, BigDecimal>> entry : demandCollMap.entrySet()) {
                    String key = entry.getKey();
                    Map<String, BigDecimal> reasonDmd = entry.getValue();
                    if (key.equals(CURRENTYEAR_FIRST_HALF)) {
                        wfPropTaxDetailsMap.put("firstHalf", CURRENTYEAR_FIRST_HALF);
                        wfPropTaxDetailsMap.put("firstHalfGT",
                                reasonDmd.get(DEMANDRSN_STR_GENERAL_TAX) != null
                                        ? reasonDmd.get(DEMANDRSN_STR_GENERAL_TAX)
                                        : demandCollMap.get(DEMANDRSN_STR_VACANT_TAX));
                        wfPropTaxDetailsMap.put("firstHalfEC", reasonDmd.get(DEMANDRSN_STR_EDUCATIONAL_CESS) != null
                                ? reasonDmd.get(DEMANDRSN_STR_EDUCATIONAL_CESS) : BigDecimal.ZERO);
                        wfPropTaxDetailsMap.put("firstHalfLC", reasonDmd.get(DEMANDRSN_STR_LIBRARY_CESS));
                        wfPropTaxDetailsMap.put("firstHalfUAP",
                                reasonDmd.get(DEMANDRSN_STR_UNAUTHORIZED_PENALTY) != null
                                        ? reasonDmd.get(DEMANDRSN_STR_UNAUTHORIZED_PENALTY) : BigDecimal.ZERO);
                        wfPropTaxDetailsMap.put("firstHalfTotal", reasonDmd.get(CURR_FIRSTHALF_DMD_STR) != null
                                ? reasonDmd.get(CURR_FIRSTHALF_DMD_STR) : BigDecimal.ZERO);
                        wfPropTaxDetailsMap
                                .put("firstHalfTaxDue",
                                        (reasonDmd.get(CURR_FIRSTHALF_DMD_STR) != null
                                                ? reasonDmd.get(CURR_FIRSTHALF_DMD_STR) : BigDecimal.ZERO)
                                                        .subtract(reasonDmd.get(CURR_FIRSTHALF_COLL_STR)));

                    } else if (key.equals(CURRENTYEAR_SECOND_HALF)) {
                        wfPropTaxDetailsMap.put("secondHalf", CURRENTYEAR_SECOND_HALF);
                        wfPropTaxDetailsMap.put("secondHalfGT",
                                reasonDmd.get(DEMANDRSN_STR_GENERAL_TAX) != null
                                        ? reasonDmd.get(DEMANDRSN_STR_GENERAL_TAX)
                                        : demandCollMap.get(DEMANDRSN_STR_VACANT_TAX));
                        wfPropTaxDetailsMap.put("secondHalfEC", reasonDmd.get(DEMANDRSN_STR_EDUCATIONAL_CESS) != null
                                ? reasonDmd.get(DEMANDRSN_STR_EDUCATIONAL_CESS) : BigDecimal.ZERO);
                        wfPropTaxDetailsMap.put("secondHalfLC", reasonDmd.get(DEMANDRSN_STR_LIBRARY_CESS));
                        wfPropTaxDetailsMap.put("secondHalfUAP",
                                reasonDmd.get(DEMANDRSN_STR_UNAUTHORIZED_PENALTY) != null
                                        ? reasonDmd.get(DEMANDRSN_STR_UNAUTHORIZED_PENALTY) : BigDecimal.ZERO);
                        wfPropTaxDetailsMap
                                .put("secondHalfTotal",
                                        reasonDmd.get(CURR_SECONDHALF_DMD_STR) != null
                                        ? reasonDmd.get(CURR_SECONDHALF_DMD_STR) : BigDecimal.ZERO);
                        wfPropTaxDetailsMap.put("secondHalfTaxDue",
                                (reasonDmd.get(CURR_SECONDHALF_DMD_STR) != null
                                ? reasonDmd.get(CURR_SECONDHALF_DMD_STR) : BigDecimal.ZERO)
                                        .subtract(reasonDmd.get(CURR_SECONDHALF_COLL_STR)));

                    } else {
                        wfPropTaxDetailsMap.put("arrears", ARREARS);
                        wfPropTaxDetailsMap.put("arrearTax", reasonDmd.get(ARR_DMD_STR) != null ? reasonDmd.get(ARR_DMD_STR) : BigDecimal.ZERO);
                        wfPropTaxDetailsMap.put("totalArrDue",
                                (reasonDmd.get(ARR_DMD_STR) != null ? reasonDmd.get(ARR_DMD_STR) : BigDecimal.ZERO).subtract(reasonDmd.get(ARR_COLL_STR)));
                    }
                }
            }
        } catch (ParseException e) {
            LOGGER.error("Exception in getTaxDetailsForWorkflowProperty: ", e);
            throw new ApplicationRuntimeException("Exception in getTaxDetailsForWorkflowProperty : " + e);
        }
        return wfPropTaxDetailsMap;
    }

    public boolean isDigitalSignatureEnabled() {
        List<AppConfigValues> appConfigValues = appConfigValuesService.getConfigValuesByModuleAndKey(PTMODULENAME,
                APPCONFIG_DIGITAL_SIGNATURE);
        return !appConfigValues.isEmpty() && "Y".equals(appConfigValues.get(0).getValue()) ? true : false;
    }

    /**
     * Fetches the list of installments for advance collections
     * @param startDate
     * @return List of Installment
     */
    public List<Installment> getAdvanceInstallmentsList(Date startDate){
    	List<Installment> advanceInstallments = new ArrayList<Installment>();
    	String query = "select inst from Installment inst where inst.module.name = '" + PTMODULENAME
                + "' and inst.fromDate >= :startdate order by inst.fromDate asc ";
    	advanceInstallments = entityManager.unwrap(Session.class).createQuery(query)
                .setParameter("startdate", startDate)
                .setMaxResults(PropertyTaxConstants.MAX_ADVANCES_ALLOWED).list();
    	return advanceInstallments;
    }
    
    /**
     * API to make the existing DemandBill inactive 
     * @param assessmentNo
     */
    public void makeExistingDemandBillInactive(String assessmentNo){
    	DemandBillService demandBillService = (DemandBillService) beanProvider.getBean("demandBillService");
    	demandBillService.makeDemandBillInactive(assessmentNo);
    }

    /**
     * Fetches a list of all the designations for the given userId
     * 
     * @param userId
     * @return designations for the given userId
     */
    public String getAllDesignationsForUser(final Long userId) {
        List<Position> positions = null;
        List<String> designationList = new ArrayList<String>();
        StringBuilder listString = new StringBuilder();
        if (userId != null && userId.intValue() != 0) {
            positions = positionMasterService.getPositionsForEmployee(userId);
            if (positions != null){
                for (Position position : positions)
                    designationList.add(position.getDeptDesig().getDesignation().getName());

                for (String s : designationList)
                listString.append(s + ", ");
            }
        }

        return listString.toString();
    }
    
    /**
     * API to check if a receipt is cancelled or not 
     * @param receiptNumber
     * @return boolean
     */
    public boolean isReceiptCanceled(String receiptNumber) {
        final javax.persistence.Query qry = entityManager.createNamedQuery(QUERY_RECEIPTS_BY_RECEIPTNUM);
        qry.setParameter(1, receiptNumber);
        ReceiptHeader receiptHeader = (ReceiptHeader) qry.getSingleResult();
        return receiptHeader.getStatus().getCode().equals(CollectionConstants.RECEIPT_STATUS_CODE_CANCELLED)
                ? Boolean.TRUE : Boolean.FALSE;
    }
    
    /**
     * API to get the current installment period
     * 
     * @return installment
     */
    public Installment getCurrentPeriodInstallment() {
        final Module module = moduleService.getModuleByName(PTMODULENAME);
        return installmentDao.getInsatllmentByModuleForGivenDate(module, new Date());
    }

}
