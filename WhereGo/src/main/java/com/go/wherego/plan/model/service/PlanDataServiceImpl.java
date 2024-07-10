package com.go.wherego.plan.model.service;

import java.sql.Date;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.go.wherego.plan.model.dao.PlanDataDao;
import com.go.wherego.plan.model.dao.PlannerDao;
import com.go.wherego.plan.model.vo.PlanData;
import com.go.wherego.plan.model.vo.Planner;

@Service
public class PlanDataServiceImpl implements PlanDataService{

	@Autowired
	private PlanDataDao planDataDao;
	@Autowired
	private SqlSessionTemplate sqlSession;
	
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

	//planList 저장
	@Override
	public int insertPlanData(ArrayList<PlanData> pList) {

		int result = planDataDao.insertPlanData(sqlSession, pList);
		
		return result;
	}

	//플랜들 가져오기
	@Override
	public ArrayList<PlanData> selectPlanData(ArrayList<Planner> plannerList) {
		
		ArrayList<PlanData> planList = planDataDao.selectPlanData(sqlSession, plannerList);
		
		return planList;
	}
	
	// 특정 플래너의 플랜들 가져오기
	@Override
	public ArrayList<PlanData> selectPlanDataByPlannerNo(int plannerNo) {
		return planDataDao.selectPlanDataByPlannerNo(sqlSession, plannerNo);
	}

}
