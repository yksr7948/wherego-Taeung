package com.go.wherego.trip.model.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Trip {
	private String contentId;	//	CONTENT_ID	VARCHAR2(10 BYTE)
	private String contentTypeId;	//	CONTENT_TYPE_ID	VARCHAR2(10 BYTE)
	private String title;	//	TITLE	VARCHAR2(20 BYTE)
	private String addr1;	//	ADDR1	VARCHAR2(50 BYTE)
	private String addr2;	//	ADDR2	VARCHAR2(10 BYTE)
	private String zipCode;	//	ZIP_CODE	VARCHAR2(10 BYTE)
	private String areaCode;	//	AREA_CODE	VARCHAR2(10 BYTE)
	private String firstImage1;
	private String firstImage2;	//	FIRST_IMAGE2	VARCHAR2(100 BYTE)
	private String createdTime;
	private String modifiedTime;
	private String homepage;
	private String mapx;
	private String mapy;
	private String mLevel;
	private String overView;
	private int count;
	private int likeCount;
	
	public Trip(String contentId, String contentTypeId, String title, String addr1, 
				String addr2, String zipCode, String areaCode, String firstImage2) {
		
		super();
		this.contentId = contentId;
		this.contentTypeId = contentTypeId;
		this.title = title;
		this.addr1 = addr1;
		this.addr2 = addr2;
		this.zipCode = zipCode;
		this.areaCode = areaCode;
		this.firstImage2 = firstImage2;
	}
	
	public Trip(String contentId, String contentTypeId, String title, String addr1, 
			String addr2, String zipCode, String areaCode, String firstImage2, int count, int likeCount) {
	
		super();
		this.contentId = contentId;
		this.contentTypeId = contentTypeId;
		this.title = title;
		this.addr1 = addr1;
		this.addr2 = addr2;
		this.zipCode = zipCode;
		this.areaCode = areaCode;
		this.firstImage2 = firstImage2;
		this.count = count;
		this.likeCount = likeCount;
	}
}

	
