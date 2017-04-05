package builders.eGovEIS.Attendances;

import entities.requests.eGovEIS.RequestInfo;
import entities.requests.eGovEIS.Attendances.SearchAttendanceRequest;

public final class SearchAttendanceRequestBuilder {

    SearchAttendanceRequest searchAttendanceRequest = new SearchAttendanceRequest();
    RequestInfo requestInfo = new RequestInfoBuilder("Search").build1();

    public SearchAttendanceRequestBuilder() {
        searchAttendanceRequest.setRequestInfo(requestInfo);
    }

    public SearchAttendanceRequestBuilder withRequestInfo(RequestInfo requestInfo){
        searchAttendanceRequest.setRequestInfo(requestInfo);
        return this;
    }

    public SearchAttendanceRequest build() {
        return searchAttendanceRequest;
    }
}