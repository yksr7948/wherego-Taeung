package com.go.wherego.weather.model.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder

public class Weather {
	private String locationName; //지역이름
	private String codeWeather; //날씨코드
	private String codeTemperature; //기온코드
	private String area; //광역시/도
}
