package com.go.wherego.plan.model.service;

import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

import com.go.wherego.plan.model.vo.PlanData;

public interface PlanDataService {

	//days 가져오기
	List<Date> getDays(Date startDate, Date endDate);

	//플랜들 저장하기
	int insertPlanData(ArrayList<PlanData> pList);

}
