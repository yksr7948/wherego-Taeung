package com.go.wherego.trip.model.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Reply {

	private int replyNo;
	private String contentId;
	private String userId;
	private String replyContent;
	private Date createDate;
}
