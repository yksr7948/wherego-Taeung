package com.go.wherego.plan.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.go.wherego.plan.model.dao.PlannerDao;
import com.go.wherego.plan.model.vo.Planner;

@Service
public class PlannerServiceImpl implements PlannerService {

	@Autowired
	private PlannerDao plannerDao;
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	//planner 저장
	@Override
	public int insertPlanner(Planner planner) {
		
		int result = plannerDao.insertPlanner(planner, sqlSession);
		
		return result;
	}

	//plannner, plan리스트 가져오기
	@Override
	public ArrayList<Planner> selectPlanner(String userId) {

		ArrayList<Planner> plannerList = plannerDao.selectPlanner(userId, sqlSession);
		
		return plannerList;
	}

	@Override
	public Planner selectPlannerByNo(int plannerNo) {
		return plannerDao.selectPlannerByNo(plannerNo, sqlSession);
	}

	//플래너 조회하기
	@Override
	public int deletePlanner(int plannerNo) {

		int result = plannerDao.deletePlanner(plannerNo, sqlSession);
		
		return result;
	}
}
