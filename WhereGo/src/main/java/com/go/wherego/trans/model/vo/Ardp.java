package com.go.wherego.trans.model.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class Ardp {
	
	private String arrPlaceNm;  //도착 터미널
	private String arrPlandTime;  //도착 시간 
	private String charge; //비용
	private String depPlaceNm;  // 출발 터미널
	private String depPlandTime; //출발 시간 
	private String gradeNm; //버스 등급 ex)우등 
}
