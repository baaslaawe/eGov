package entities.responses.propertyTax.masters.occupancy.create;

public class ResponseInfo {
    private String ver;
    private String resMsgId;
    private String msgId;
    private String apiId;
    private long ts;
    private String status;

    public String getVer() {
        return this.ver;
    }

    public void setVer(String ver) {
        this.ver = ver;
    }

    public String getResMsgId() {
        return this.resMsgId;
    }

    public void setResMsgId(String resMsgId) {
        this.resMsgId = resMsgId;
    }

    public String getMsgId() {
        return this.msgId;
    }

    public void setMsgId(String msgId) {
        this.msgId = msgId;
    }

    public String getApiId() {
        return this.apiId;
    }

    public void setApiId(String apiId) {
        this.apiId = apiId;
    }

    public long getTs() {
        return this.ts;
    }

    public void setTs(long ts) {
        this.ts = ts;
    }

    public String getStatus() {
        return this.status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}
