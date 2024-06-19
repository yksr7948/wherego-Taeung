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
	private String firstImage2;	//	FIRST_IMAGE2	VARCHAR2(100 BYTE)
}
