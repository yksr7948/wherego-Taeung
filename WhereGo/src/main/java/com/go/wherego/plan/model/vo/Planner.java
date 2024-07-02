package com.go.wherego.plan.model.vo;

import java.sql.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Planner {
	private int plannerNo;
	private String userId;
	private String title;
	private String description;
	

	private Date startDate;
	

	private Date endDate;
	
	private Date createDate;
}
