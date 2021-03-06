/*
*eGov suite of products aim to improve the internal efficiency,transparency,
*     accountability and the service delivery of the government  organizations.
* 
*      Copyright (C) <2015>  eGovernments Foundation
* 
*      The updated version of eGov suite of products as by eGovernments Foundation
*      is available at http://www.egovernments.org
* 
*      This program is free software: you can redistribute it and/or modify
*      it under the terms of the GNU General Public License as published by
*      the Free Software Foundation, either version 3 of the License, or
*      any later version.
* 
*      This program is distributed in the hope that it will be useful,
*      but WITHOUT ANY WARRANTY; without even the implied warranty of
*      MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
*      GNU General Public License for more details.
* 
*      You should have received a copy of the GNU General Public License
*      along with this program. If not, see http://www.gnu.org/licenses/ or
*      http://www.gnu.org/licenses/gpl.html .
* 
*      In addition to the terms of the GPL license to be adhered to in using this
*      program, the following additional terms are to be complied with:
* 
*          1) All versions of this program, verbatim or modified must carry this
*             Legal Notice.
* 
*          2) Any misrepresentation of the origin of the material is prohibited. It
*             is required that all modified versions of this material be marked in
*             reasonable ways as different from the original version.
* 
*          3) This license does not grant any rights to any user of the program
*             with regards to rights under trademark law for use of the trade names
*             or trademarks of eGovernments Foundation.
* 
*    In case of any queries, you can reach eGovernments Foundation at contact@egovernments.org.
*/
package org.egov.model.repository;

import java.util.List;

import org.egov.commons.CChartOfAccounts;
import org.egov.model.budget.BudgetGroup;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface BudgetingGroupRepository extends JpaRepository<BudgetGroup, Long> {

    BudgetGroup findByMajorCode_Id(Long id);

    BudgetGroup findByMajorCode_IdAndIdNotIn(Long majorCodeId, Long id);

    List<BudgetGroup> findByMinCodeGlcodeLessThanEqualAndMaxCodeGlcodeGreaterThanEqual(String minCode, String minCode1);

    List<BudgetGroup> findByMinCodeGlcodeLessThanEqualAndMaxCodeGlcodeGreaterThanEqualAndIdNotIn(String minCode,
            String minCode1, Long id);

    @Query("from BudgetGroup  where  upper(name) like '%'||upper(:name)||'%' order by id")
    List<BudgetGroup> findBudgetGroupByNameLike(@Param("name") String name);

    @Query("from BudgetGroup where substr(minCode.glcode,1,:length)<=:majorCode and substr(maxCode.glcode,1,:length)>=:majorCode")
    List<BudgetGroup> getBudgetGroupForMappedMajorCode(@Param("length") Integer length,
            @Param("majorCode") String majorCode);

    @Query("from BudgetGroup where majorCode.glcode<=:minCode and majorCode.glcode>=:minCode")
    BudgetGroup getBudgetGroupForMinorCodesMajorCode(@Param("minCode") String minCode);

    @Query("from CChartOfAccounts  where length(glcode)=:length order by glcode")
    List<CChartOfAccounts> findCOAByLength(@Param("length") Integer length);

    List<BudgetGroup> findByAccountTypeIs(String accountType);

    List<BudgetGroup> findBybudgetingTypeIs(String budgetingType);

    List<BudgetGroup> findByIsActiveTrue();

}
