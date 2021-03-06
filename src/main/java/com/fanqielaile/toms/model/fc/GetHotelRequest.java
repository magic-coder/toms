package com.fanqielaile.toms.model.fc;

import com.fanqie.support.OtaRequest;

import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;

/**
 * DESC : 酒店基本信息查询接口
 * @author : 番茄木-ZLin
 * @data : 2015/9/2
 * @version: v1.0.0
 */
@XmlRootElement(name = "Request")
public class GetHotelRequest extends OtaRequest {
    @XmlElement(name = "Header")
    public Header header;
    @XmlElement(name = "GetHotelInfoRequest")
    public  GetHotelInfoRequest   getHotelInfoRequest;

    public GetHotelRequest() {
    }

    public GetHotelRequest(Header header, GetHotelInfoRequest getHotelInfoRequest) {
        this.header = header;
        this.getHotelInfoRequest = getHotelInfoRequest;
    }



    public void setHeader(Header header) {
        this.header = header;
    }

    public void setGetHotelInfoRequest(GetHotelInfoRequest getHotelInfoRequest) {
        this.getHotelInfoRequest = getHotelInfoRequest;
    }
}
