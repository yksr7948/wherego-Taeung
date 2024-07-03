package com.go.wherego.plan.model.service;

import java.sql.Date;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import org.springframework.stereotype.Service;

@Service
public class PlanDataServiceImpl implements PlanDataService{

	//days 가져오기
	@Override
	public List<Date> getDays(Date startDate, Date endDate) {

		Calendar cal = Calendar.getInstance();
		//시작일로 초기화
		cal.setTime(startDate);
		
		int count = (int)((endDate.getTime() - startDate.getTime()) / 1000 / 60 / 60 / 24);
		//반복문에서 1을 더해주니 -1
		cal.add(Calendar.DATE, -1);
		
        List result = new ArrayList();
        
        for(int i = 0; i<=count; i++){
        	cal.add(Calendar.DATE, 1);
            result.add(cal.getTime());
        }
		
		return result;
	}

}
