package com.go.wherego.plan.model.vo;

import java.sql.Date;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class PlanData {
	
	private int planNo;
	private int plannerNo;
	@JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd")
	private Date day;
	private String name;
	private String time;
	private String intro;
	private String mapx;
	private String mapy;
	private String firstImage;
	
	private Planner planner;
	private List<PlanData> planList;
	
	public PlanData(int planNo, int plannerNo, Date day, String name, String time, String intro, String mapx, String mapy, String firstImage) {
		
		super();
		this.planNo = planNo;
		this.plannerNo = plannerNo;
		this.day = day;
		this.name = name;
		this.time = time;
		this.intro = intro;
		this.mapx = mapx;
		this.mapy = mapy;
		this.firstImage = firstImage;
	}
}
