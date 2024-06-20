package com.go.wherego.weather.model.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Weather {
	private String locationCode; //지역코드
	private String locationName; //지역이름
	private String area; //광역시/도
}
