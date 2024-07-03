package com.go.wherego.plan.model.service;

import java.sql.Date;
import java.util.List;

public interface PlanDataService {

	//days 가져오기
	List<Date> getDays(Date startDate, Date endDate);

}
