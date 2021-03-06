package com.fanqielaile.toms.dto.homestay;
import java.util.List;

import com.fanqielaile.toms.enums.ResultCode;
import com.fanqielaile.toms.model.homestay.RoomStatusData;

/**
 * Created by LZQ on 2016/9/2.
 */
public class GetRoomStatusDto extends BaseResultDto {
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String roomId;
    private List<RoomStatusData> data;

    public GetRoomStatusDto() {
		super();
	}

	public GetRoomStatusDto(ResultCode code) {
		super(code);
	}

	public String getRoomId() {
        return roomId;
    }

    public void setRoomId(String roomId) {
        this.roomId = roomId;
    }

    public List<RoomStatusData> getData() {
        return data;
    }

    public void setData(List<RoomStatusData> data) {
        this.data = data;
    }
}
